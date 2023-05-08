import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/local/auth_service.dart';
import '../../../../core/remote/network_service.dart';
import '../../../../core/type_defs.dart';
import '../base/base_repository.dart';
import '../core/error/failure.dart';
import '../models/auth_user.dart';

final authAPIProvider = Provider((ref) {
  final dio = ref.read(networkServiceProvider);
  return AuthAPI(dio: dio);
});

abstract class IAuthAPI {
  FutureEither<AuthUser> login({
    required String email,
    required String password,
  });
  FutureEither<bool> register({
    required String email,
    required String password,
    required String doctor,
    required String location,
    required String role,
    required String name,
  });
  Future<List<User>> getDoctors();
  Future<List<User>> getPatients();
}

class AuthAPI with BaseRepository implements IAuthAPI {
  final Dio _dio;
  AuthAPI({required Dio dio}) : _dio = dio;
  @override
  FutureEither<AuthUser> login(
      {required String email, required String password}) async {
    try {
      final res = await _dio.post(
        "/login",
        data: {
          "email": email,
          "password": password,
        },
        onSendProgress: (count, total) {
          print((count / total) * 100);
        },
      );

      AuthService.instance.login(res.data);

      return right(AuthUser.fromJson(res.data));
    } on DioError catch (e, s) {
      if (e.response!.statusCode == 403) {
        return left(
            Failure(message: e.response!.data['detail'], stackTrace: s));
      } else if (e.error is SocketException) {
        return left(Failure(message: e.message!, stackTrace: s));
      } else if (e.error is TimeoutException) {
        return left(Failure(message: e.message!, stackTrace: s));
      }
      return left(Failure(
        message: e.response?.statusMessage ?? 'Something went wrong',
        code: e.response?.statusCode,
        exception: e,
        stackTrace: s,
      ));
    }
  }

  @override
  FutureEither<bool> register(
      {required String email,
      required String password,
      required String name,
      required String location,
      required String doctor,
      required String role}) async {
    try {
      await _dio.post("/users/", data: {
        "email": email,
        "password": password,
        "role": role,
        "doctor": doctor,
        "location": location,
        "name": name,
      });

      return right(true);
    } on DioError catch (e, s) {
      if (e.response!.statusCode == 409) {
        return left(
            Failure(message: e.response!.data['detail'], stackTrace: s));
      } else if (e.error is SocketException) {
        return left(Failure(message: e.message!, stackTrace: s));
      } else if (e.error is TimeoutException) {
        return left(Failure(message: e.message!, stackTrace: s));
      }
      return left(Failure(
        message: e.response?.statusMessage ?? 'Something went wrong',
        code: e.response?.statusCode,
        exception: e,
        stackTrace: s,
      ));
    }
  }

  @override
  Future<List<User>> getDoctors() async {
    try {
      final res = await _dio.get(
        "/users/doctors",
      );

      return usersFromJson(res.data);
    } on DioError catch (e, s) {
      if (e.response!.statusCode == 409) {
        return throw e.message!;
      } else if (e.error is SocketException) {
        return throw e.message!;
      } else if (e.error is TimeoutException) {
        return throw e.message!;
      }
      throw e.message!;
    }
  }

  @override
  Future<List<User>> getPatients() async {
    try {
      final res = await _dio.get(
        "/users/patients",
      );

      return usersFromJson(res.data);
    } on DioError catch (e, s) {
      if (e.response!.statusCode == 409) {
        return throw e.message!;
      } else if (e.error is SocketException) {
        return throw e.message!;
      } else if (e.error is TimeoutException) {
        return throw e.message!;
      }
      throw e.message!;
    }
  }
}
