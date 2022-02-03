import 'package:equatable/equatable.dart';

class AccountEntitiy extends Equatable {
  final String token;
  const AccountEntitiy({
    required this.token,
  });

  @override
  List<Object> get props => [token];
}
