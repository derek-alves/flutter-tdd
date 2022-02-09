import 'package:equatable/equatable.dart';

import '../../entities/entities.dart' show AccountEntitiy;

abstract class AuthenticationUseCase {
  Future<AccountEntitiy> call({required final AuthenticationUseCaseParams params});
}

class AuthenticationUseCaseParams extends Equatable {
  final String email;
  final String password;
  const AuthenticationUseCaseParams({
    required this.email,
    required this.password,
  });

  @override
  List<Object> get props => [
        email,
        password,
      ];
}
