// from_lat:29.9711931
// from_lng:31.2652474
// to_lat:32.86156089978749
// to_lng:13.098436639514512
// payment_method:cash
// vehicle_type_id:4

import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../entities/promo_code_entity.dart';
class RequestBody {
  final LatLng _from;
  final LatLng _to;
   int? _vehicleTypeId;
   String _paymentMethod;
   String _gender;
   String amount;
  PromoCodeEntity? _promoCodeEntity;

  RequestBody({
    required LatLng from,
    required LatLng to,
    int? vehicleTypeId,
    PromoCodeEntity? promoCodeEntity,
    String paymentMethod = 'cash',
    String gender = 'male',
    String amount = '0',
  })  : _from = from,
        _to = to,
        _gender = gender,
        _promoCodeEntity = promoCodeEntity,
        _vehicleTypeId = vehicleTypeId,
        amount = amount,
        _paymentMethod = paymentMethod;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['from_lat'] = _from.latitude;
    data['from_lng'] = _from.longitude;
    data['to_lat'] = _to.latitude;
    data['to_lng'] = _to.longitude;
    data['vehicle_type_id'] = _vehicleTypeId;
    data['payment_method'] = _paymentMethod;
    data['gender'] = _gender;
    if( _promoCodeEntity?.id!=null)data['promo_code_id'] = _promoCodeEntity?.id;

    return data;
  }

  updateVehicleType(int vehicleTypeId)=> _vehicleTypeId=vehicleTypeId;
  updateAmount(String price)=> amount=price;
  selectGender(String gender)=> _gender=gender;
  setPromoCode(PromoCodeEntity? entity)=> _promoCodeEntity=entity;
  selectPaymentMethod(String payment)=> _paymentMethod=payment;

  LatLng get to => _to;

  LatLng get from => _from;

  String get paymentMethod => _paymentMethod;
  String get gender => _gender;

  int? get vehicleTypeId => _vehicleTypeId;

  PromoCodeEntity? get promoCodeEntity => _promoCodeEntity;
}
