import 'package:equatable/equatable.dart';

import 'country_entity.dart';
import 'driver_state_entity.dart';


class UserEntity extends Equatable {
  final int _id;
  final String _name;
  final String _mobile;
  final String _email;
  final CountryEntity? _country;
  final String _gender;
  final String _deliveryType;
  final String _accessToken;
  final bool _isOnline;
  final String _image;
  final String _status;
  final dynamic _rate ;
  final List<String> _driverLicenseImages;
  final List<String> _nationalIdImages;
  final String _driverLicenseDueDate;
  final String _driverLicenseNumber;

  final DriverStateEntity _driverStateEntity;

  const UserEntity({
    required int id,
    required String name,
    required String image,
    required String mobile,
     dynamic rate ,
    required CountryEntity? country,
    required bool isOnline,
    required String gender,
    required String deliveryType,
    required String driverLicenseDueDate,
    required String driverLicenseNumber,
    required List<String> nationalIdImages,
    required List<String> driverLicenseImages,
    required String email,
    required String accessToken,
    required String status,
    required DriverStateEntity driverStateEntity,
  })  : _id = id,
        _name = name,
        _mobile = mobile,
        _rate = rate,
        _email = email,
        _driverLicenseDueDate = driverLicenseDueDate,
        _driverLicenseNumber = driverLicenseNumber,
        _nationalIdImages = nationalIdImages,
        _driverLicenseImages = driverLicenseImages,
        _country = country,
        _deliveryType = deliveryType,
        _image = image,
        _isOnline = isOnline,
        _gender = gender,
        _driverStateEntity = driverStateEntity,
        _status = status,
        _accessToken = accessToken;

  @override
  List<Object> get props => [
    _id,
    _name,
    _mobile,
    _rate,
    _driverLicenseImages,
    _nationalIdImages,
    _nationalIdImages,
    _driverLicenseDueDate,
    _email,
    _isOnline,
    _image,
    _gender,
    _deliveryType,
    _accessToken,
    _status,
    _driverStateEntity,
  ];

  int get id => _id;
  String get name => _name;
  String get mobile => _mobile;
  dynamic get rate => _rate;
  CountryEntity? get country => _country;
  String get email => _email;
  String get image => _image;
  bool get isOnline => _isOnline;
  String get gender => _gender;
  String get deliveryType => _deliveryType;
  String get status => _status;
  DriverStateEntity get driverStateEntity => _driverStateEntity;
  String get accessToken => _accessToken;
  String get driverLicenseNumber => _driverLicenseNumber;
  String get driverLicenseDueDate => _driverLicenseDueDate;
  List<String> get nationalIdImages => _nationalIdImages;
  List<String> get driverLicenseImages => _driverLicenseImages;
}
