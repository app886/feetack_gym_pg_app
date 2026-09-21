import 'package:vlr/data/models/category_model/image_model.dart';
import 'package:vlr/data/models/category_model/package_model.dart';
import 'package:vlr/services/constants.dart';

import 'category_model.dart';

class ListingModel {
  final String? id;
  final String? partnerId;
  final String? categoryId;
  final String? title;
  final String? description;
  final String? address;
  final dynamic phone;
  final String? lat;
  final String? lng;
  final String? status;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final dynamic deletedAt;
  final String? packagesMinPrice;
  final double? distanceKm;
  final int? availableRoomsCount;
  final int? availableBedsCount;
  final bool? fullyBooked;
  final int? startingPrice;
  final List<PackageModel>? packages;
  final CategoryModel? category;
  final String? about;
  final String? image;
  final List<ImageMode>? images;
  final String? landmark;
  final String? openingTime;
  final String? closingTime;
  final Map<String, dynamic>? partner;
  final ListingRating? rating;
  final String? reviewsAvgRating;
  final String? reviewsCount;
  final String? genderType;
  final String? securityDeposit;

  /// Client-side calculated distance (set via Haversine formula)
  double? calculatedDistanceKm;

  /// Returns API distance_km if available, otherwise returns client-calculated distance
  double? get effectiveDistanceKm => distanceKm ?? calculatedDistanceKm;

  ListingModel({
    this.id,
    this.partnerId,
    this.categoryId,
    this.title,
    this.description,
    this.address,
    this.phone,
    this.lat,
    this.lng,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.packagesMinPrice,
    this.distanceKm,
    this.availableRoomsCount,
    this.availableBedsCount,
    this.fullyBooked,
    this.startingPrice,
    this.packages,
    this.category,
    this.about,
    this.image,
    this.images,
    this.landmark,
    this.openingTime,
    this.closingTime,
    this.partner,
    this.rating,
    this.reviewsAvgRating,
    this.reviewsCount,
    this.genderType,
    this.securityDeposit,
  });

  factory ListingModel.fromJson(Map<String, dynamic> json) {
    // print("ListingModel.fromJson: parsing data for ID: ${json["id"]}");
    return ListingModel(
        id: json["id"]?.toString(),
        partnerId: json["partner_id"]?.toString(),
        categoryId: json["category_id"]?.toString(),
        title: json["title"]?.toString(),
        description: json["description"]?.toString(),
        address: json["address"]?.toString(),
        phone: json["phone"],
        lat: json["lat"]?.toString(),
        lng: json["lng"]?.toString(),
        status: json["status"]?.toString(),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
        packagesMinPrice: json["packages_min_price"]?.toString(),
        distanceKm: json["distance_km"] == null ? null : double.tryParse(json["distance_km"].toString()),
        availableRoomsCount: json["available_rooms_count"] == null ? null : double.tryParse(json["available_rooms_count"].toString())?.toInt(),
        availableBedsCount: json["available_beds_count"] == null ? null : double.tryParse(json["available_beds_count"].toString())?.toInt(),
        fullyBooked: json["fully_booked"] is bool ? json["fully_booked"] : (json["fully_booked"] == 1 || json["fully_booked"] == "1"),
        startingPrice: json["starting_price"] == null ? null : double.tryParse(json["starting_price"].toString())?.toInt(),
        packages: json["packages"] == null
            ? []
            : List<PackageModel>.from(
                json["packages"]!.map((x) => PackageModel.fromJson(x))),
        category: json["category"] == null
            ? null
            : CategoryModel.fromJson(json["category"]),
        about: json["about"]?.toString(),
        image: (json["image"] ?? json["image_url"] ?? json["image_path"])?.toString(),
        images: json["images"] == null
            ? []
            : List<ImageMode>.from(
                json["images"]!.map((x) => ImageMode.fromJson(x))),
        landmark: json["landmark"]?.toString(),
        openingTime: json["opening_time"]?.toString(),
        closingTime: json["closing_time"]?.toString(),
        partner: json["partner"],
        rating: json["rating"] == null
            ? null
            : ListingRating.fromJson(json["rating"]),
        reviewsAvgRating: json["reviews_avg_rating"]?.toString(),
        reviewsCount: json["reviews_count"]?.toString(),
        genderType: json["gender_type"]?.toString(),
        securityDeposit: json["security_deposit"]?.toString(),
      );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "partner_id": partnerId,
        "category_id": categoryId,
        "title": title,
        "description": description,
        "address": address,
        "phone": phone,
        "lat": lat,
        "lng": lng,
        "status": status,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "deleted_at": deletedAt,
        "packages_min_price": packagesMinPrice,
        "distance_km": distanceKm,
        "available_rooms_count": availableRoomsCount,
        "available_beds_count": availableBedsCount,
        "fully_booked": fullyBooked,
        "starting_price": startingPrice,
        "packages": packages == null
            ? []
            : List<dynamic>.from(packages!.map((x) => x.toJson())),
        "category": category?.toJson(),
        "about": about,
        "image": image,
        "images": images == null
            ? []
            : List<dynamic>.from(images!.map((x) => x.toJson())),
        "landmark": landmark,
        "opening_time": openingTime,
        "closing_time": closingTime,
        "partner": partner,
        "rating": rating?.toJson(),
        "reviews_avg_rating": reviewsAvgRating,
        "reviews_count": reviewsCount,
        "gender_type": genderType,
        "security_deposit": securityDeposit,
      };

  String get priceFormat =>
      PriceConverter.convertToNumberFormat(startingPrice ?? 0.0);
}

class ListingRating {
  final double? average;
  final int? count;

  ListingRating({this.average, this.count});

  factory ListingRating.fromJson(Map<String, dynamic> json) => ListingRating(
        average: json["average"] == null ? null : double.tryParse(json["average"].toString()),
        count: json["count"] is int ? json["count"] : int.tryParse(json["count"]?.toString() ?? ""),
      );

  Map<String, dynamic> toJson() => {
        "average": average,
        "count": count,
      };
}
