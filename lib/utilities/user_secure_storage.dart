import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UserSecureStorage {
    static final _storage = FlutterSecureStorage();

    static const _keyJwt = 'Jwt';

    static Future setJwt(String jwt) async => await _storage.write(key: _keyJwt, value: jwt);

    static Future<String?> getJwt() async => await _storage.read(key: _keyJwt);
}