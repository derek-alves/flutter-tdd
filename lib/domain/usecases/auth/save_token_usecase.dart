import '../../entities/entities.dart';

abstract class SaveTokenUseCase {
  Future<void> call({required AccountEntitiy token});
}
