part of 'promo_cubit.dart';

@immutable
abstract class PromoState {}

class PromoInitial extends PromoState {}
class PromoAppleLoading extends PromoState {}
class PromoLoading extends PromoState {}

class PromosGotSuccessfully extends PromoState {
  final ResponseModel<List<PromoCodeEntity>> _responseModel;


  ResponseModel<List<PromoCodeEntity>> get responseModel => _responseModel;


   PromosGotSuccessfully({
    required ResponseModel<List<PromoCodeEntity>> responseModel,
  }) : _responseModel = responseModel;
}
