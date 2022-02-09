import '../../domain/entities/entities.dart';

class AccountModel extends AccountEntitiy {
  final String dtoToken;

  const AccountModel({required this.dtoToken})
      : super(
          token: dtoToken,
        );

  factory AccountModel.fromMap(Map<String, dynamic> map) => AccountModel(
        dtoToken: (map['token'] ?? '').toString(),
      );
}
