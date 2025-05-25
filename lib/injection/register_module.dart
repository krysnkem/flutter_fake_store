import 'package:dio/dio.dart';
import 'package:flutter_fake_store/core/utils/methods/create_dio.dart';
import 'package:injectable/injectable.dart';

@module
abstract class RegisterModule {
  @lazySingleton
  Dio get dio => createDio(baseUrl: baseUrl)
    ..interceptors.add(
      LogInterceptor(),
    );

  @lazySingleton
  String get baseUrl => 'https://fakestoreapi.com';
}
