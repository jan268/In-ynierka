import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UserSecureStorage {
    static final _storage = FlutterSecureStorage();

    static const _keyJwt = 'Jwt';
    static const _keySneakers = 'Sneakers';
    static const _keyStreetwear = 'Streetwear';
    static const _keyCollectibles = 'Collectibles';
    static const _keyElectronics = 'Electronics';

    static Future setJwt(String jwt) async => await _storage.write(key: _keyJwt, value: jwt);

    static Future<String?> getJwt() async => await _storage.read(key: _keyJwt);

    static Future setSneakers(String jwt) async => await _storage.write(key: _keySneakers, value: jwt);

    static Future<String?> getSneakers() async => await _storage.read(key: _keySneakers);

    static Future setStreetwear(String jwt) async => await _storage.write(key: _keyStreetwear, value: jwt);

    static Future<String?> getStreetwear() async => await _storage.read(key: _keyStreetwear);

    static Future setCollectibles(String jwt) async => await _storage.write(key: _keyCollectibles, value: jwt);

    static Future<String?> getCollectibles() async => await _storage.read(key: _keyCollectibles);

    static Future setElectronics(String jwt) async => await _storage.write(key: _keyElectronics, value: jwt);

    static Future<String?> getElectronics() async => await _storage.read(key: _keyElectronics);
}