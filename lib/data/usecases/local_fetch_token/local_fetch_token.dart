import 'dart:convert';

import 'package:flutter/foundation.dart';

import '../../../domain/entities/account_entitiy.dart';
import '../../../domain/errors/errors.dart';
import '../../../domain/usecases/auth/auth.dart';
import '../../models/models.dart';
import '../../services/cache/cache.dart';

class LocalFetchToken implements FetchTokenUseCase {
  final FetchSecureStorage fetchSecureStorage;

  LocalFetchToken({required this.fetchSecureStorage});

  @override
  Future<AccountEntitiy> call() async {
    try {
      final encodedToken = await fetchSecureStorage.fetch(key: 'token');
      final tokenResult = AccountModel.fromMap(jsonDecode(encodedToken));
      return tokenResult;
    } on CacheError catch (e) {
      debugPrint(e.toString());
      throw e.convertError();
    } on DomainError catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }
}
