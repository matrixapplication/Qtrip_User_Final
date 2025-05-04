import 'package:equatable/equatable.dart';

class DriverVehicleEntity extends Equatable{

  final int _id;
  final String _brand;
  final String _model;
  final String _color;
  final String _colorName;
  final String _licensePlate;
  final String  _vehicleType;
  final String  _vehicleTypeCategory;

  final String _manufacturingYear;
  final String _image;

  const DriverVehicleEntity({
    required int id,
    required String brand,
    required String model,
    required String vehicleTypeCategory,
    required String color,
    required String colorName,
    required String licensePlate,
    required String vehicleType,
    required String manufacturingYear,
    required String image,
  })  : _id = id,
        _brand = brand,
        _model = model,
        _vehicleTypeCategory = vehicleTypeCategory,
        _color = color,
        _colorName = colorName,
        _licensePlate = licensePlate,
        _vehicleType = vehicleType,
        _manufacturingYear = manufacturingYear,

        _image = image;

  @override
  List<Object?> get props => [_id,_brand,_model,_colorName,_color,_licensePlate,_vehicleType,_manufacturingYear,_image,_vehicleTypeCategory];

  String get image => _image;


  String get manufacturingYear => _manufacturingYear;

  String  get vehicleType => _vehicleType;

  String get licensePlate => _licensePlate;

  String get color => _color;

  String get model => _model;
  String get vehicleTypeCategory => _vehicleTypeCategory;
  String get colorName => _colorName;

  String get brand => _brand;

  int get id => _id;
}




