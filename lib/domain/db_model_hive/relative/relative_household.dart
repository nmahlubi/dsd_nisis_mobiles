import 'package:hive/hive.dart';

part 'relative_household.g.dart';

@HiveType(typeId: 77)
class RelativeMember extends HiveObject {
  @HiveField(0)
  int relationshipTypeId;

  @HiveField(1)
  String description;

  @HiveField(2)
  String source;

  @HiveField(3)
  String definition;

  RelativeMember({
    required this.relationshipTypeId,
    required this.description,
    required this.source,
    required this.definition,
  });
}

