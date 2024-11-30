import 'package:get_storage/get_storage.dart';

class LocalCacheService {
  static final GetStorage _getStorage = GetStorage();

  static save(String key, dynamic value) {
    return _getStorage.write(key, value);
  }

  static read(String key) {
    return _getStorage.read(key);
  }
}
