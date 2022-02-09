import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../data/services/cache/cache.dart';

class SecureStorageAdapter implements SaveSecureStorage, FetchSecureStorage, DeleteSecureStorage {
  final FlutterSecureStorage secureStorage;

  SecureStorageAdapter({required this.secureStorage});

  @override
  Future<String> fetch({required String key}) async {
    final String? data = await secureStorage.read(key: key);
    return data ?? '';
  }

  @override
  Future<void> save({required String key, required String value}) async {
    await secureStorage.write(key: key, value: value);
  }

  @override
  Future<void> delete({required String key}) async {
    await secureStorage.delete(key: key);
  }
}
