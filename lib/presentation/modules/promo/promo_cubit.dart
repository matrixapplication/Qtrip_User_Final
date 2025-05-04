import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import '../../../data/model/base/response_model.dart';
import '../../../domain/entities/promo_code_entity.dart';
import '../../../domain/usecase/payment/check_promo_code_usecase.dart';
import '../../../domain/usecase/payment/get_promo_codes_usecase.dart';

part 'promo_state.dart';

class PromoCubit extends Cubit<PromoState> {

  final GetPromoCodesUseCase _getPromoCodesUseCase;
  final CheckPromoCodeUseCase _checkPromoCodeUseCase;

  PromoCubit({
    required GetPromoCodesUseCase getPromoCodesUseCase,
    required CheckPromoCodeUseCase checkPromoCodeUseCase,
  })  : _getPromoCodesUseCase = getPromoCodesUseCase,
        _checkPromoCodeUseCase = checkPromoCodeUseCase, super(PromoInitial());

  ///variables
  ResponseModel<List<PromoCodeEntity>>? _responseModel;
  PromoCodeEntity? _selectedPromoCode;


  ///getters
  PromoCodeEntity? get selectedPromoCode => _selectedPromoCode;

  init(PromoCodeEntity? entity) { _selectedPromoCode = entity; getPromoCodes(reload: true);}

  TextEditingController promoController = TextEditingController();

  setPromoCode(PromoCodeEntity entity){
    if (_selectedPromoCode == entity) {
      _selectedPromoCode = null;
    } else {
      _selectedPromoCode = entity;
    }
    promoController.text=_selectedPromoCode?.promoCode??'';
    emit(PromoInitial());
  }
  ///colling api functions

  //get list of promos
  void getPromoCodes({bool reload = false}) async {
    _responseModel = null;
    if (reload) emit(PromoLoading());
    emit(PromosGotSuccessfully(responseModel: await _getPromoCodesUseCase.call()));
  }

  //Check promo code
  Future< ResponseModel<PromoCodeEntity?>> checkPromoCode({required String  promoCode}) async {
     emit(PromoAppleLoading());
    ResponseModel<PromoCodeEntity?> responseModel = await _checkPromoCodeUseCase.call(promoCode: promoCode);
    if (responseModel.isSuccess && responseModel.data != null) {
      _selectedPromoCode = responseModel.data;
    }
     emit(PromoInitial());
    return responseModel;
  }

/*  //get address location
  Future selectPlaceFromSuggestion({required AddressBody addressBody}) async {
    try {
      _placePredictions.clear();
      List<Location> locations =await locationFromAddress(addressBody.title!);
      _body = AddressBody(title: addressBody.title! ,address: addressBody.address!, latLng: LatLng(locations[0].latitude, locations[0].longitude),addressType:_addressType);
      if (_body!=null ) {
        NavigationService.push(RoutesDriver.driverStoreAddressScreen,arguments: {'addressBody':_body});
      }

    } catch (e) {
      log('StoreSearchAddressViewModel', '$e');
    }
  }*/

}
