
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:equatable/equatable.dart';

class PromoCodeEntity extends Equatable{
  final int _id;
  final String _promoCode;
  final String _startDate;
  final String _expiredDate;
  final String _discountType;
  final String _discount;
  final int _usedNumber;
  final int _ordersCount;

  @override
  List<Object> get props => [_id, _promoCode, _startDate, _expiredDate,_discountType, _discount,_usedNumber,_ordersCount];

  const PromoCodeEntity({
    required int id,
    required String promoCode,
    required String startDate,
    required String expiredDate,
    required String discountType,
    required String discount,
    required int usedNumber,
    required int ordersCount,
  })  : _id = id,
        _promoCode = promoCode,
        _startDate = startDate,
        _expiredDate = expiredDate,
        _discountType = discountType,
        _discount = discount,
        _usedNumber = usedNumber,
        _ordersCount = ordersCount;

  int get ordersCount => _ordersCount;

  int get usedNumber => _usedNumber;

  String get discount => _discount;

  String get discountType => _discountType;

  String get expiredDate => _expiredDate;

  String get startDate => _startDate;

  String get promoCode => _promoCode;

  int get id => _id;
}
