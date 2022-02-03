import '../entities/entities.dart' show AccountEntitiy;

abstract class AuthenticationUseCase {
  Future<AccountEntitiy> call();
}
