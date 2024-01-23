class RelativeMemberDto {
  int relationshipTypeId;
  String description;
  String source;
  String definition;

  RelativeMemberDto({
    required this.relationshipTypeId,
    required this.description,
    required this.source,
    required this.definition,
  });

  factory RelativeMemberDto.fromJson(Map<String, dynamic> json) {
    return RelativeMemberDto(
      relationshipTypeId: json['relationship_Type_Id'] as int,
      description: json['description'] as String,
      source: json['source'] as String? ?? '', // Handle null by providing a default value
      definition: json['definition'] as String? ?? '', // Handle null by providing a default value
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'relationship_Type_Id': relationshipTypeId,
      'description': description,
      'source': source,
      'definition': definition,
    };
  }
}

