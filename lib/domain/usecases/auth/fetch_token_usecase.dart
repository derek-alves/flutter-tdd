import '../../entities/entities.dart';

abstract class FetchTokenUseCase {
  Future<AccountEntitiy> call();
}
