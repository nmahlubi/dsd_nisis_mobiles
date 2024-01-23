import 'package:hive/hive.dart';

part 'nisis_role.model.g.dart';

@HiveType(typeId: 2)
class NisisRoleModel {
  @HiveField(0)
  final bool? dataCapture;
  @HiveField(1)
  final bool? manager;

  NisisRoleModel({this.dataCapture, this.manager});
}
