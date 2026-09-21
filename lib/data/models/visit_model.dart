import 'package:vlr/data/models/category_model/listing_model.dart';
import 'package:vlr/data/models/user_model.dart';

class VisitModel {
  String? id;
  String? customerId;
  String? listingId;
  String? partnerId;
  String? visitDate;
  String? visitTime;
  String? status;
  String? note;
  String? createdAt;
  String? updatedAt;
  ListingModel? listing;
  UserModel? partner;
  UserModel? customer;

  VisitModel({
    this.id,
    this.customerId,
    this.listingId,
    this.partnerId,
    this.visitDate,
    this.visitTime,
    this.status,
    this.note,
    this.createdAt,
    this.updatedAt,
    this.listing,
    this.partner,
    this.customer,
  });

  VisitModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    customerId = json['customer_id'];
    listingId = json['listing_id'];
    partnerId = json['partner_id'];
    visitDate = json['visit_date'];
    visitTime = json['visit_time'];
    status = json['status'];
    note = json['note'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['listing'] != null) {
      listing = ListingModel.fromJson(json['listing']);
    }
    if (json['partner'] != null) {
      partner = UserModel.fromJson(json['partner']);
    }
    if (json['customer'] != null) {
      customer = UserModel.fromJson(json['customer']);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['customer_id'] = customerId;
    data['listing_id'] = listingId;
    data['partner_id'] = partnerId;
    data['visit_date'] = visitDate;
    data['visit_time'] = visitTime;
    data['status'] = status;
    data['note'] = note;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (listing != null) {
      data['listing'] = listing!.toJson();
    }
    if (partner != null) {
      data['partner'] = partner!.toJson();
    }
    if (customer != null) {
      data['customer'] = customer!.toJson();
    }
    return data;
  }
}
