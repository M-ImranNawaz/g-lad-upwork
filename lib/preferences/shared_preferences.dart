import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SharedPreferencesService {

  late final FlutterSecureStorage _storage;

  SharedPreferencesService(){
    _storage = const FlutterSecureStorage();
  }

  saveValue(String key,String value) async {
    await _storage.write(key: key, value: value);
  }

  Future<String?> readValue(String key) async {
     return await _storage.read(key: key);
  }

}