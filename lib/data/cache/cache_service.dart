abstract class CacheService {
  Future read(String key);
  Future write(String key, String value);
  Future delete(String key);
  Future clear();
}
