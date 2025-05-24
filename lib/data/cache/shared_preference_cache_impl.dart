import 'package:flutter_fake_store/data/cache/cache_service.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@LazySingleton(as: CacheService)
class SharedPreferenceCacheImpl implements CacheService {
  final SharedPreferences _sharedPreferences;

  SharedPreferenceCacheImpl(this._sharedPreferences);

  Future<void> remove(String key) async {
    await _sharedPreferences.remove(key);
  }

  @override
  Future read(String key) async {
    return _sharedPreferences.getString(key);
  }

  @override
  Future write(String key, String value) {
    return _sharedPreferences.setString(key, value);
  }

  @override
  Future clear() => _sharedPreferences.clear();

  @override
  Future delete(String key) async {
    await _sharedPreferences.remove(key);
  }
}
