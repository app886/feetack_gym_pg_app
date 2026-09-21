class PgFloorModel {
  final dynamic id;
  final String? floorNumber;
  final String? name;
  bool isSelect;

  PgFloorModel({
    required this.id,
    required this.floorNumber,
    required this.name,
    this.isSelect = false,
  });

  // Keep old field names as getters for backward compatibility
  String? get floorNo => floorNumber;
  String? get floorName => name;

  factory PgFloorModel.fromJson(Map<String, dynamic> json) {
    return PgFloorModel(
      id: json['id'],
      floorNumber: json['floor_number']?.toString(),
      name: json['name'],
    );
  }
}
