import 'package:vlr/services/constants.dart';

class PackageModel {
  final String? id;
  final String? listingId;
  final dynamic roomId;
  final String? name;
  final String? occupancyType;
  final String? durationDays;
  final String? price;
  final String? type;
  final List<String>? features;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final dynamic deletedAt;
  final dynamic room;

  PackageModel({
    this.id,
    this.listingId,
    this.roomId,
    this.name,
    this.occupancyType,
    this.durationDays,
    this.price,
    this.type,
    this.features,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.room,
  });

    factory PackageModel.fromJson(Map<String, dynamic> json) => PackageModel(
        id: json["id"]?.toString(),
        listingId: json["listing_id"]?.toString(),
        roomId: json["room_id"]?.toString(),
        name: json["name"]?.toString(),
        occupancyType: json["occupancy_type"]?.toString(),
        durationDays: json["duration_days"]?.toString(),
        price: json["price"]?.toString(),
        type: json["type"]?.toString(),
        features: json["features"] == null
            ? []
            : List<String>.from(json["features"]!.map((x) => x.toString())),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
        room: json["room"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "listing_id": listingId,
        "room_id": roomId,
        "name": name,
        "occupancy_type": occupancyType,
        "duration_days": durationDays,
        "price": price,
        "type": type,
        "features":
            features == null ? [] : List<dynamic>.from(features!.map((x) => x)),
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "deleted_at": deletedAt,
        "room": room,
      };

  String get priceFormat =>
      PriceConverter.convertToNumberFormat(double.tryParse(price ?? "") ?? 0.0);
}
