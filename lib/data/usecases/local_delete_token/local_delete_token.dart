import 'package:flutter/foundation.dart';

import '../../../domain/errors/errors.dart';
import '../../../domain/usecases/auth/auth.dart';
import '../../services/cache/cache.dart';

class LocalDeleteToken implements DeleteTokenUseCase {
  final DeleteSecureStorage deleteSecureStorage;

  LocalDeleteToken({required this.deleteSecureStorage});

  @override
  Future<void> call() {
    try {
      return deleteSecureStorage.delete(key: 'token');
    } on CacheError catch (e) {
      debugPrint(e.toString());
      throw e.convertError();
    } on DomainError catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }
}
