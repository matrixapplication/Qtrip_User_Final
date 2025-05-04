

import '../../../domain/entities/trip_vehicle_entity.dart';
import 'drop_down_model.dart';

class TripVehicleModel extends TripVehicleEntity{
  const TripVehicleModel({
    required super.id,
    required super.brand,
    required super.model,
    required super.color,
    required super.licensePlate,
    required super.vehicleType,
    required super.manufacturingYear,
    required super.carInsurance,
    required super.carLicense,
    required super.approvedByAdmin,
    required super.status,
    required super.images,
  });




  factory TripVehicleModel.fromJson(Map<String, dynamic> json) => TripVehicleModel(
    id: json["id"]??0,
    brand: DropDownModel.fromJson(json["brand"]),
    model: DropDownModel.fromJson(json["model"]),
    color: DropDownModel.fromJson(json["color"]),
    licensePlate: json["car_number"]??'',
    // vehicleTypes: json["vehicle_type"] == null ? [] : List<DropDownModel>.from(json["vehicle_type"].map((x) => DropDownModel.fromJson(x))),
    // vehicleTypes: json["vehicle_type"] == null ? [] : List<DropDownModel>.from(json["vehicle_type"].map((x) => DropDownModel.fromJson(x))),
    manufacturingYear: json["manufacturing_year"]??0,
    carInsurance: CarSettingModel.fromJson(json["car_insurance"]),
    carLicense: CarSettingModel.fromJson(json["car_license"]),
    vehicleType: DropDownModel.fromJson(json["vehicle_type"]),
    approvedByAdmin: json["approved_by_admin"]??false,
    status: json["status"]??false,
    // images: json["images"]??'',
    // images: json["images"] == null ? [''] : List<ImageModel>.from(json["images"].map((x) => x)),
    images: json["images"] == null ? [] : List<ImageModel>.from(json["images"].map((x) => ImageModel.fromJson(x))),

  );


}


class ImageModel extends ImageEntity{

  const ImageModel({
    required super.image,
    required super.id,
  });


  factory ImageModel.fromJson(Map<String, dynamic> json) => ImageModel(
    image: json["image"]??'',
    id: json["id"]??0,
  );

}
class CarSettingModel extends CarSettingEntity{
  const CarSettingModel({
    required super.image,
    required super.expireDate,
  });


  factory CarSettingModel.fromJson(Map<String, dynamic>? json) => CarSettingModel(
    image: json?["image"]??'',
    expireDate: json?["expire_date"]??'',
  );


}


