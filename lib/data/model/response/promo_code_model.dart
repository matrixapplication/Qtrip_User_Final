import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../domain/entities/promo_code_entity.dart';


class PromoCodeModel extends PromoCodeEntity{
  PromoCodeModel({
    required super.id,
    required super.promoCode,
    required super.startDate,
    required super.expiredDate,
    required super.discountType,
    required super.discount,
    required super.usedNumber,
    required super.ordersCount,
  });

  factory PromoCodeModel.fromJson(Map<String, dynamic> json) => PromoCodeModel(
        id: json["id"]??-1,
        promoCode: json["promo_code"]??'',
        startDate: json["start_date"] ?? '',
        expiredDate: json["expired_date"] ?? '',
        discountType: json["discount_type"]??'',
        discount: json["discount"]??'',
        usedNumber: json["used_number"]??0,
        ordersCount: json["orders_count"]??0,
      );

  // Map<String, dynamic> toJson() => {
  //   "id": id,
  //   "name": name,
  //   "phone": phone,
  //   "address": address,
  //   "region_id": regionId,
  //   "region_name": regionName,
  //   "active": active,
  //   "lat": lat,
  //   "lng": lng,
  //   "address_type": addressType,
  // };
}

