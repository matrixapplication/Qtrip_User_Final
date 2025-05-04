
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../entities/promo_code_entity.dart';
class VehicleBody {
  final LatLng _from;
  final LatLng _to;
   String _type;
  PromoCodeEntity? _promoCodeEntity;

   VehicleBody({
    required LatLng from,
    required LatLng to,
    required String type,
    PromoCodeEntity? promoCodeEntity,
  })  : _from = from, _promoCodeEntity = promoCodeEntity,
         _type = type,
        _to = to;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['from_lat'] = _from.latitude;
    data['from_lng'] = _from.longitude;
    data['to_lat'] = _to.latitude;
    data['to_lng'] = _to.longitude;
    _type.isNotEmpty? data['type'] = _type:null;
    if( _promoCodeEntity?.id!=null)data['promo_code_id'] = _promoCodeEntity?.id;
    return data;
  }
  setPromoCode(PromoCodeEntity? entity)=> _promoCodeEntity=entity;
  selectVehicleType(String type)=> _type=type;

  LatLng get to => _to;

  LatLng get from => _from;
  String get type => _type;

  PromoCodeEntity? get promoCodeEntity => _promoCodeEntity;
}
