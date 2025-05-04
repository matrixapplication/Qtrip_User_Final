import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../domain/entities/address_entity.dart';


class AddressModel extends AddressEntity{
  AddressModel({
    required super.id,
    required super.name,
    required super.address,
    required super.location,
    required super.addressType,
  });



  factory AddressModel.fromJson(Map<String, dynamic> json) => AddressModel(
    id: json["id"]??0,
    name: json["name"]??'',

    address: json["address"]??'',

    location: LatLng(double.parse(json["lat"]??'0.0'),double.parse(json["lng"]??'0.0').toDouble()) ,
    addressType: json["address_type"]??'',
    // phone: json["phone"],
    // regionId: json["region_id"],
    // regionName: json["region_name"],
    // active: json["active"],
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

