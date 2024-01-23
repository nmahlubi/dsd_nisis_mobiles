import 'package:hive/hive.dart';

import 'roles/nisis_role.model.dart';

part 'auth_token.model.g.dart';

@HiveType(typeId: 1)
class AuthTokenModel {
  @HiveField(0)
  final int? userId;
  @HiveField(1)
  final String? username;
  @HiveField(2)
  final String? firstname;
  @HiveField(3)
  final String? password;
  @HiveField(4)
  final bool? supervisor;
  @HiveField(5)
  final NisisRoleModel? nisisRoleModel;

  AuthTokenModel(
      {this.userId,
      this.username,
      this.firstname,
      this.password,
      this.supervisor,
      this.nisisRoleModel});
}
