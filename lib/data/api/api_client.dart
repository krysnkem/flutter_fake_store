import 'package:injectable/injectable.dart';
import 'package:dio/dio.dart';

@injectable
class ApiClient {
  final Dio _dio;
  ApiClient(this._dio);

  Future<Response> getProducts() async {
    return await _dio.get(
      '/products',
    );
  }

  Future<Response> login({
    required String email,
    required String password,
    required String username,
  }) async {
    return await _dio.post(
      '/users',
      data: {
        "email": email,
        "username": username,
        "password": password,
      },
    );
  }
}
