import '../domain/errors/errors.dart';

abstract class BaseError extends DomainError {
  const BaseError({String message = ''}) : super(message: message);
}
