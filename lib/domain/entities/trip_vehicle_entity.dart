
import 'package:equatable/equatable.dart';

import 'drop_down_entity.dart';

class TripVehicleEntity extends Equatable{

  final int _id;
  final DropDownEntity _brand;
  final DropDownEntity _model;
  final DropDownEntity _color;
  final String _licensePlate;
  final DropDownEntity  _vehicleType;
  final int _manufacturingYear;
  final CarSettingEntity _carInsurance;
  final CarSettingEntity _carLicense;
  final bool _approvedByAdmin;
  final bool _status;
  final List<ImageEntity> _images;

  const TripVehicleEntity({
    required int id,
    required DropDownEntity brand,
    required DropDownEntity model,
    required DropDownEntity color,
    required String licensePlate,
    required DropDownEntity vehicleType,
    required int manufacturingYear,
    required CarSettingEntity carInsurance,
    required CarSettingEntity carLicense,
    required bool approvedByAdmin,
    required bool status,
    required List<ImageEntity> images,
  })  : _id = id,
        _brand = brand,
        _model = model,
        _color = color,
        _licensePlate = licensePlate,
        _vehicleType = vehicleType,
        _manufacturingYear = manufacturingYear,
        _carInsurance = carInsurance,
        _carLicense = carLicense,
        _approvedByAdmin = approvedByAdmin,
        _status = status,
        _images = images;

  @override
  List<Object?> get props => [_id,_brand,_model,_color,_licensePlate,_vehicleType,_manufacturingYear,_carInsurance,_carLicense,_approvedByAdmin,_status,_images];

  List<ImageEntity> get images => _images;

  bool get status => _status;

  bool get approvedByAdmin => _approvedByAdmin;

  CarSettingEntity get carLicense => _carLicense;

  CarSettingEntity get carInsurance => _carInsurance;

  int get manufacturingYear => _manufacturingYear;

  DropDownEntity  get vehicleType => _vehicleType;

  String get licensePlate => _licensePlate;

  DropDownEntity get color => _color;

  DropDownEntity get model => _model;

  DropDownEntity get brand => _brand;

  int get id => _id;
}



class CarSettingEntity  extends Equatable{

  final String _image;
  final String _expireDate;

  const CarSettingEntity({
    required String image,
    required String expireDate,
  })  : _image = image,
        _expireDate = expireDate;


  @override
  List<Object?> get props => [_image,_expireDate];

  String get expireDate => _expireDate;
  String get image => _image;

}

class ImageEntity extends Equatable{



  final String _image;
  final int _id;


  @override
  List<Object?> get props => [_image,_id];

  int get id => _id;
  String get image => _image;

  const ImageEntity({
    required String image,
    required int id,
  })
      : _image = image,
        _id = id;
}

