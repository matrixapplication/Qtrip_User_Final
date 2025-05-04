import 'package:equatable/equatable.dart';
import 'package:q_trip_user/domain/entities/trip_vehicle_entity.dart';

class TripHistoryEntity extends Equatable{

  final int _id;
  final String _driverName;
  final String _driverMobile;
  final String _driverImage;
  final dynamic _rate;
  final dynamic _clientRate;
  final String _clientRateNote;
  final String _clientName;
  final String _clientPhone;
  final String _clientPhoneCountryCode;
  final TripVehicleEntity _car;
  final String _vehicleType;
  final String _vehicleDescription;
  final String _fromAddress;
  final String _fromLat;
  final String _fromLng;
  final String _toAddress;
  final String _toLat;
  final String _toLng;
  final String _price;
  final String _paymentMethod;
  final String _promoCode;
  final String _status;
  final String _tripStatus;
  final String _createdAt;
  final String _date;
  final String _expectedTime;
  final String _distance;


  @override
  List<Object> get props => [_id,_date,_distance,_rate,_createdAt,_tripStatus ,_price, _status, _promoCode,_toLng, _expectedTime, _toLat, _fromLng,_status, _fromLat, _fromAddress, _vehicleType, _car, _clientPhoneCountryCode];


  int get id => _id;

  const TripHistoryEntity({
    required int id,
    required String driverName,
    required String driverMobile,
    required String driverImage,
    required dynamic rate,
    required dynamic clientRate,
    required String clientRateNote,
    required String clientName,
    required String clientPhone,
    required String clientPhoneCountryCode,
    required TripVehicleEntity car,
    required String vehicleType,
    required String vehicleDescription,
    required String fromAddress,
    required String fromLat,
    required String fromLng,
    required String toAddress,
    required String toLat,
    required String toLng,
    required String price,
    required String paymentMethod,
    required String promoCode,
    required String status,
    required String tripStatus,
    required String createdAt,
    required String date,
    required String expectedTime,
    required String distance,
  })  : _id = id,
        _driverName = driverName,
        _driverMobile = driverMobile,
        _driverImage = driverImage,
        _rate = rate,
        _clientRate = clientRate,
        _clientRateNote = clientRateNote,
        _clientName = clientName,
        _clientPhone = clientPhone,
        _clientPhoneCountryCode = clientPhoneCountryCode,
        _car = car,
        _vehicleType = vehicleType,
        _vehicleDescription = vehicleDescription,
        _fromAddress = fromAddress,
        _fromLat = fromLat,
        _fromLng = fromLng,
        _toAddress = toAddress,
        _toLat = toLat,
        _toLng = toLng,
        _price = price,
        _paymentMethod = paymentMethod,
        _promoCode = promoCode,
        _status = status,
        _tripStatus = tripStatus,
        _createdAt = createdAt,
        _date = date,
        _expectedTime = expectedTime,
        _distance = distance;

  String get driverName => _driverName;

  String get driverMobile => _driverMobile;

  String get driverImage => _driverImage;

  dynamic get rate => _rate;

  dynamic get clientRate => _clientRate;

  String get clientRateNote => _clientRateNote;

  String get clientName => _clientName;

  String get clientPhone => _clientPhone;

  String get clientPhoneCountryCode => _clientPhoneCountryCode;

  TripVehicleEntity get car => _car;

  String get vehicleType => _vehicleType;

  String get vehicleDescription => _vehicleDescription;

  String get fromAddress => _fromAddress;

  String get fromLat => _fromLat;

  String get fromLng => _fromLng;

  String get toAddress => _toAddress;

  String get toLat => _toLat;

  String get toLng => _toLng;

  String get price => _price;

  String get paymentMethod => _paymentMethod;

  String get promoCode => _promoCode;

  String get status => _status;

  String get tripStatus => _tripStatus;

  String get createdAt => _createdAt;

  String get date => _date;

  String get expectedTime => _expectedTime;

  String get distance => _distance;
}
