import '../../../domain/errors/errors.dart';
import '../../../errors/errors.dart';

abstract class CacheError extends DomainError {
  const CacheError._({String message = ''}) : super(message: message);

  factory CacheError.failedToSave({String message = ''}) => _FailedToSave(message: message);
  factory CacheError.failedToRetrieveData({String message = ''}) => _FailedToRetrieveData(message: message);
  factory CacheError.failedToDelete({String message = ''}) => _FailedToDelete(message: message);
}

class _FailedToSave extends CacheError {
  const _FailedToSave({String message = ''}) : super._(message: message);
}

class _FailedToRetrieveData extends CacheError {
  const _FailedToRetrieveData({String message = ''}) : super._(message: message);
}

class _FailedToDelete extends CacheError {
  const _FailedToDelete({String message = ''}) : super._(message: message);
}

extension ConvertToBaseError on CacheError {
  /// Convert CacheError to BaseError equivalent
  DomainError convertError() {
    switch (runtimeType) {
      case _FailedToSave:
        return LocalError(message: message);
      case _FailedToRetrieveData:
        return LocalError(message: message);
      case _FailedToDelete:
        return LocalError(message: message);
      default:
        return LocalError(message: message);
    }
  }
}
