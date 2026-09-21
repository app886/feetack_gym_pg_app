class UserModel {
  final String? id;
  final String? name;
  final String? email;
  final String? mobile;
  final String? role;
  final String? image;
  final String? status;
  final String? walletBalance;
  final bool? emailVerifiedAt;
  final bool? mobileVerifiedAt;
  final dynamic fcmToken;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final dynamic deletedAt;

  UserModel({
    this.id,
    this.name,
    this.email,
    this.mobile,
    this.role,
    this.image,
    this.status,
    this.walletBalance,
    this.emailVerifiedAt,
    this.mobileVerifiedAt,
    this.fcmToken,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        mobile: json["mobile"],
        role: json["role"],
        image: json["profile_image"] ?? json["image"] ?? json["photo"],
        status: json["status"],
        walletBalance: json["wallet_balance"]?.toString(),
        emailVerifiedAt: json["email_verified_at"] is bool
            ? json["email_verified_at"]
            : json["email_verified_at"] != null,
        mobileVerifiedAt: json["mobile_verified_at"] is bool
            ? json["mobile_verified_at"]
            : json["mobile_verified_at"] != null,
        fcmToken: json["fcm_token"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "mobile": mobile,
        "role": role,
        "image": image,
        "status": status,
        "wallet_balance": walletBalance,
        "email_verified_at": emailVerifiedAt,
        "mobile_verified_at": mobileVerifiedAt,
        "fcm_token": fcmToken,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "deleted_at": deletedAt,
      };
}
