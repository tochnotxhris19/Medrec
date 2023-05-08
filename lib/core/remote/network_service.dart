import 'package:dio/dio.dart';
import 'package:dio_http_formatter/dio_http_formatter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../provider/base_url_provider.dart';
import 'network_service_interceptor.dart';

/// Provide the instance of Dio
final networkServiceProvider = Provider.autoDispose<Dio>((ref) {
  final baseUrl = ref.watch(baseUrlProvider);

  final options = BaseOptions(
    baseUrl: baseUrl,
    connectTimeout: const Duration(seconds: 20),
    sendTimeout: const Duration(minutes: 2),
    receiveTimeout: const Duration(minutes: 1),
  );

  // Add our custom interceptors
  final dio = Dio(options)
    ..interceptors.addAll([HttpFormatter(), NetworkServiceInterceptor()]);

  return dio;
  
});
