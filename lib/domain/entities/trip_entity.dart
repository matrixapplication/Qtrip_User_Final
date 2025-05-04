
import 'package:equatable/equatable.dart';

import 'driver_vehicle_entity.dart';

class TripEntity extends Equatable{

  final String  _distance;
  final String  _driverId;
  final String  _dropAddress;
  final num  _dropLat;
  final num  _dropLng;
  final String  _expectedTime;
  final String  _pickupAddress;
  final num  _pickupLat;
  final num  _pickupLng;
  final num  _userRate;
  final String  _price;
  final String  _status;
  final String  _driverName;
  final String  _tripId;
  final String  _userImage;
  final String  _driverImage;
  final String  _driverMobile;
  final String  _userName;
  final String  _driverRate;
  final String  _driverAvgYear;
  final String  _driverAvgTrips;
  final String?  _paymentMethod;
  final DriverVehicleEntity?  _vehicle;


  @override
  List<Object?> get props => [_paymentMethod,_distance,_driverAvgTrips,_driverAvgYear,_driverImage,_driverRate,_driverMobile,_pickupLat ,_userRate ,_price, _dropAddress, _dropLat,_dropLng, _expectedTime, _pickupAddress, _pickupLng,_status, _userImage, _userName];


  const TripEntity({
    required String distance,
    required String driverId,
    required String dropAddress,
    required num dropLat,
    required num dropLng,
    required String expectedTime,
    required String pickupAddress,
    required num pickupLat,
    required num pickupLng,
    required num userRate,
    required String price,
    required String status,
    required String tripId,
    required String userImage,
    required String driverImage,
    required String driverAvgTrips,
    required String driverName,
    required String driverMobile,
    required String userName,
    required String driverAvgYear,
    required String driverRate,
     String? paymentMethod,
    required DriverVehicleEntity? vehicle,
  })  : _distance = distance,
        _driverId = driverId,
        _dropAddress = dropAddress,
        _paymentMethod = paymentMethod,
        _dropLat = dropLat,
        _driverAvgTrips = driverAvgTrips,
        _dropLng = dropLng,
        _driverAvgYear = driverAvgYear,
        _userRate = userRate,
        _expectedTime = expectedTime,
        _pickupAddress = pickupAddress,
        _pickupLat = pickupLat,
        _driverImage = driverImage,
        _pickupLng = pickupLng,
        _price = price,
        _driverName = driverName,
        _status = status,
        _tripId = tripId,
        _userImage = userImage,
        _vehicle = vehicle,
        _driverMobile = driverMobile,
        _driverRate = driverRate,
        _userName = userName;

  String get driverRate => _driverRate;
  String get userName => _userName;
  String get driverName => _driverName;
  String? get paymentMethod => _paymentMethod;

  String get userImage => _userImage;
  String get driverImage => _driverImage;
  String get driverAvgTrips => _driverAvgTrips;
  String get driverAvgYear => _driverAvgYear;

  String get tripId => _tripId;

  String get status => _status;

  String get price => _price;
  String get driverMobile => _driverMobile;

  num get pickupLng => _pickupLng;
  num get userRate => _userRate;

  num get pickupLat => _pickupLat;

  String get pickupAddress => _pickupAddress;

  String get expectedTime => _expectedTime;

  num get dropLng => _dropLng;

  num get dropLat => _dropLat;

  String get dropAddress => _dropAddress;

  String get driverId => _driverId;

  String get distance => _distance;

  DriverVehicleEntity? get vehicle => _vehicle;
}
