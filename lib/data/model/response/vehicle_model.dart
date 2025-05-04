

import '../../../domain/entities/vehicle_entity.dart';

class VehicleModel extends VehicleEntity{
  VehicleModel({
    required super.id,
    required super.name,
    required super.description,
    required super.price,
    required super.priceAfterDiscount,
    required super.image,
  });


  factory VehicleModel.fromJson(Map<String, dynamic>? json) => VehicleModel(
    id: json?["id"]??0,
    name: json?["name"]??'',
    description: json?["description"]??'',
    price: json?["price"]??0,
    priceAfterDiscount: json?["price_after_discount"]??json?["price"]??0,
    image: json?["image"]??'',
  );

}
