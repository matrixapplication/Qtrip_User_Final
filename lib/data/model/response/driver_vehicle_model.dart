


import 'package:firebase_database/firebase_database.dart';

import '../../../domain/entities/driver_vehicle_entity.dart';


class DriverVehicleModel extends DriverVehicleEntity{
  const DriverVehicleModel({
    required super.id,
    required super.brand,
    required super.model,
    required super.color,
    required super.colorName,
    required super.licensePlate,
    required super.vehicleType,
    required super.manufacturingYear,
    required super.image, required super.vehicleTypeCategory,
  });

/*

  factory DriverVehicleModel.fromJson(Map<String, dynamic> json) => DriverVehicleModel(
    id: json["id"],
    brand: DropDownModel.fromJson(json["brand"]),
    model: DropDownModel.fromJson(json["model"]),
    color: DropDownModel.fromJson(json["color"]),
    licensePlate: json["car_number"]??'',
    manufacturingYear: json["manufacturing_year"]??'',
    vehicleType: DropDownModel.fromJson(json["vehicle_type"]),


    image: json["images"] == null ? [] : List<ImageModel>.from(json["images"].map((x) => ImageModel.fromJson(x))),

  );
*/



  factory DriverVehicleModel.fromSnapshot(DataSnapshot snapshot) => DriverVehicleModel(
      id: int.tryParse((snapshot.child("id").value ?? 0).toString())??-1,
      licensePlate: (snapshot.child("car_number").value ?? '').toString(),
      manufacturingYear: (snapshot.child("manufacturing_year").value ?? '').toString(),
      brand: (snapshot.child("brand").child('name').value ?? '').toString(),
      model: (snapshot.child("model").child('name').value ?? '').toString(),
      colorName: (snapshot.child("color").child('name').value ?? '').toString(),
      color: (snapshot.child("color").child('color').value ?? '').toString(),
      vehicleType: (snapshot.child("vehicle_type").child('name').value ?? '').toString(),
      image: (snapshot.child("images").child("0").child('image').value?? '').toString(),
      vehicleTypeCategory: (snapshot.child("vehicle_type").child('category').value ?? '').toString(),
  // image: ((snapshot.child("images").children??[]).first.child('image').value ?? '').toString(),
    );

}

