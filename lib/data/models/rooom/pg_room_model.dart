import 'package:vlr/data/models/category_model/listing_model.dart';

class PgRoomModel {
  final String? id;
  final String? floorId;
  final String? roomNumber;
  final String? roomType;
  final int? capacity;
  final int? availableBeds;
  final dynamic securityDeposit;
  final dynamic startingPrice;
  final List<RoomImage>? images;
  final List<RoomPackage>? packages;
  final ListingModel? listing;
  final PartnerModel? partner;
  bool isSelect;

  PgRoomModel({
    this.id,
    this.floorId,
    this.roomNumber,
    this.roomType,
    this.capacity,
    this.availableBeds,
    this.securityDeposit,
    this.startingPrice,
    this.images,
    this.packages,
    this.listing,
    this.partner,
    this.isSelect = false,
  });

  // Keep old field names as getters/aliases for backward compatibility
  String? get roomNo => roomNumber;
  int? get bedLeftNo => availableBeds;
  int? get shareType => capacity; // Assuming shareType was capacity in old model

  factory PgRoomModel.fromJson(Map<String, dynamic> json) {
    return PgRoomModel(
      id: json['id']?.toString(),
      floorId: json['floor_id']?.toString(),
      roomNumber: json['room_number']?.toString(),
      roomType: json['room_type']?.toString(),
      capacity: json['capacity'] != null ? int.tryParse(json['capacity'].toString()) : null,
      availableBeds: json['available_beds'] != null ? int.tryParse(json['available_beds'].toString()) : null,
      securityDeposit: json['security_deposit'],
      startingPrice: json['starting_price'],
      images: json['images'] != null
          ? (json['images'] as List).map((i) => RoomImage.fromJson(i)).toList()
          : null,
      packages: json['packages'] != null
          ? (json['packages'] as List)
              .map((i) => RoomPackage.fromJson(i))
              .toList()
          : null,
      listing: json['listing'] != null ? ListingModel.fromJson(json['listing']) : null,
      partner: json['partner'] != null ? PartnerModel.fromJson(json['partner']) : null,
    );
  }
}

class PartnerModel {
  final String? name;
  final String? mobile;
  final String? profilePhotoUrl;

  PartnerModel({this.name, this.mobile, this.profilePhotoUrl});

  factory PartnerModel.fromJson(Map<String, dynamic> json) {
    return PartnerModel(
      name: json['name'],
      mobile: json['mobile'],
      profilePhotoUrl: json['profile_photo_url'],
    );
  }
}

class RoomImage {
  final int? id;
  final String? url;

  RoomImage({this.id, this.url});

  factory RoomImage.fromJson(Map<String, dynamic> json) {
    return RoomImage(
      id: json['id'] != null ? int.tryParse(json['id'].toString()) : null,
      url: json['url']?.toString(),
    );
  }
}

class RoomPackage {
  final String? id;
  final String? name;
  final String? type;
  final String? durationLabel;
  final int? durationDays;
  final dynamic price;
  final List<String>? features;
  final String? occupancyType;
  final MealPlans? mealPlans;
  final String? roomType;
  final String? roomId;

  RoomPackage({
    this.id,
    this.name,
    this.type,
    this.durationLabel,
    this.durationDays,
    this.price,
    this.features,
    this.occupancyType,
    this.mealPlans,
    this.roomType,
    this.roomId,
  });

  factory RoomPackage.fromJson(Map<String, dynamic> json) {
    return RoomPackage(
      id: json['id']?.toString(),
      name: json['name']?.toString(),
      type: json['type']?.toString(),
      durationLabel: json['duration_label']?.toString(),
      durationDays: json['duration_days'] != null ? int.tryParse(json['duration_days'].toString()) : null,
      price: json['price'],
      features: json['features'] != null ? List<String>.from(json['features'].map((e) => e.toString())) : null,
      occupancyType: json['occupancy_type']?.toString(),
      mealPlans: json['meal_plans'] != null ? MealPlans.fromJson(json['meal_plans']) : null,
      roomType: json['room_type']?.toString(),
      roomId: json['room_id']?.toString(),
    );
  }
}

class MealPlans {
  final bool? hasBreakfast;
  final bool? hasLunch;
  final bool? hasDinner;
  final String? mealType;

  MealPlans({this.hasBreakfast, this.hasLunch, this.hasDinner, this.mealType});

  factory MealPlans.fromJson(Map<String, dynamic> json) {
    bool parseBool(dynamic value) {
      if (value is bool) return value;
      if (value is int) return value == 1;
      if (value is String) return value.toLowerCase() == 'true' || value == '1';
      return false;
    }

    return MealPlans(
      hasBreakfast: parseBool(json['has_breakfast']),
      hasLunch: parseBool(json['has_lunch']),
      hasDinner: parseBool(json['has_dinner']),
      mealType: json['meal_type']?.toString(),
    );
  }
}
