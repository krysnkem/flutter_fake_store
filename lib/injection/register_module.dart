import 'package:dio/dio.dart';
import 'package:flutter_fake_store/core/utils/methods/create_dio.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@module
abstract class RegisterModule {
  @lazySingleton
  Dio get dio => createDio(baseUrl: baseUrl);

  @lazySingleton
  String get baseUrl => 'https://fakestoreapi.com';

  @lazySingleton
  Future<SharedPreferences> get sharedPreferences async {
    return await SharedPreferences.getInstance();
  }
}
