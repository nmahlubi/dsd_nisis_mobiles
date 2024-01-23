class NisisRoleDto {
  NisisRoleDto({
    bool? dataCapture,
    bool? manager,
  }) {
    _dataCapture = dataCapture;
    _manager = manager;
  }

  NisisRoleDto.fromJson(dynamic json) {
    _dataCapture = json['dataCapture'];
    _manager = json['manager'];
  }
  bool? _dataCapture;
  bool? _manager;

  bool? get dataCapture => _dataCapture;
  bool? get manager => _manager;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['dataCapture'] = _dataCapture;
    map['manager'] = _manager;
    return map;
  }
}
