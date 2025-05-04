import 'dart:async';

import 'package:bloc/bloc.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meta/meta.dart';

import '../../../../core/routing/navigation_services.dart';
import '../../../../core/routing/routes.dart';
import '../../../../core/utils/constants.dart';
import '../../../../data/model/base/response_model.dart';
import '../../../../domain/entities/address_entity.dart';
import '../../../../domain/entities/addresses_entity.dart';
import '../../../../domain/request_body/address_body.dart';
import '../../../../domain/usecase/google/get_places_usecase.dart';


part 'store_search_address_state.dart';

class StoreSearchAddressCubit extends Cubit<StoreSearchAddressState> {
  final GetPlacesUseCase _getPlacesUseCase;

  ///variables
  AddressBody? _body;
  AddressType _addressType =AddressType.favorite;
  List<AddressBody> _placePredictions = [];
  List<AddressesEntity>? _addressesList ;
  static const double _radius = 1000;

  ///getters
  AddressBody? get body => _body;
  List<AddressBody> get placePredictions => _placePredictions;
  List<AddressesEntity>? get addressesList => _addressesList;


  StoreSearchAddressCubit({
    required GetPlacesUseCase getPlacesUseCase,
  }) : _getPlacesUseCase = getPlacesUseCase, super(StoreSearchAddressStatusInitial());


  //set address
  setAddress(AddressEntity? entity,AddressType type){
    _addressType =type;
    if(entity!=null) {
      _body= AddressBody.setAddress(entity: entity,type: type);
    }else{
      _body = null;
    }
    emit(StoreSearchAddressStatusInitial());
  }


  ///colling api functions

  //get list of places
  void searchForPlaces(BuildContext context,String input) async {
    _placePredictions = [];

    if (input.isNotEmpty) {
      ResponseModel responseModel = await _getPlacesUseCase.call(context, input);

      if (responseModel.isSuccess) {

        _placePredictions = responseModel.data;
      }
      emit(StoreSearchAddressStatusInitial());
    } else {
      _placePredictions = [];
      emit(StoreSearchAddressStatusInitial());
    }
  }

  //get address location
  Future selectPlaceFromSuggestion({required AddressBody addressBody}) async {
    try {
      _placePredictions.clear();
      List<Location> locations =await locationFromAddress(addressBody.title!);
      _body = AddressBody(title: addressBody.title! ,address: addressBody.address!, latLng: LatLng(locations[0].latitude, locations[0].longitude),addressType:_addressType);

      if (_body!=null ) {
        NavigationService.push(Routes.driverStoreAddressScreen,arguments: {'addressBody':_body});
      }

    } catch (e) {
    }
  }
}
