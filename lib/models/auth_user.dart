// To parse this JSON data, do
//
//     final authUser = authUserFromJson(jsonString);

// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:convert';

part 'auth_user.freezed.dart';
part 'auth_user.g.dart';

List<User> usersFromJson(dynamic str) => List<User>.from(
      (str).map(
        (e) => User.fromJson(e),
      ),
    );
AuthUser authUserFromJson(String str) => AuthUser.fromJson(json.decode(str));

String authUserToJson(AuthUser data) => json.encode(data.toJson());

@immutable
@freezed
class AuthUser with _$AuthUser {
  @JsonSerializable()
  const factory AuthUser({
    @JsonKey(name: 'access_token') String? accessToken,
    @JsonKey(name: 'token_type') String? tokenType,
    User? user,
  }) = _AuthUser;

  factory AuthUser.fromJson(Map<String, dynamic> json) =>
      _$AuthUserFromJson(json);
}

@immutable
@freezed
class User with _$User {
  @JsonSerializable()
  const factory User({
    int? id,
    String? name,
    String? email,
    String? role,
    String? doctor,
    @JsonKey(name: 'phone_number') String? phoneNumber,
    @JsonKey(name: 'created_at') DateTime? createdAt,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
