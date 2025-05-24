import 'package:dio/dio.dart';

Dio createDio({
  required String baseUrl,
  Map<String, dynamic>? headers,
  int? connectTimeout,
  int? receiveTimeout,
}) {
  final options = BaseOptions(
    baseUrl: baseUrl,
    headers: headers ?? {'Content-Type': 'application/json'},
    connectTimeout: Duration(milliseconds: connectTimeout ?? 5000),
    receiveTimeout: Duration(milliseconds: receiveTimeout ?? 3000),
  );

  return Dio(options);
}
