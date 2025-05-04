import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:meta/meta.dart';
import '../../../core/routing/navigation_services.dart';
import '../../../core/routing/routes.dart';
import '../../../core/utils/constants.dart';
import '../../../data/model/base/response_model.dart';
import '../../../domain/entities/addresses_entity.dart';
import '../../../domain/request_body/address_body.dart';
import '../../../domain/usecase/address/get_addresses_usecase.dart';
import '../../../domain/usecase/google/get_place_details_usecase.dart';
import '../../../domain/usecase/google/get_places_usecase.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  final _tag = 'SearchCubit';
  final GetAddressesUseCase _getAddressesUseCase;
  final GetPlacesUseCase _getPlacesUseCase;
  final GetPlaceDetailsUseCase _getPlaceDetailsUseCase;
  SearchCubit({
    required GetAddressesUseCase getAddressesUseCase,
    required GetPlacesUseCase getPlacesUseCase,
    required GetPlaceDetailsUseCase getPlaceDetailsUseCase,
  })  : _getAddressesUseCase = getAddressesUseCase,
        _getPlacesUseCase = getPlacesUseCase,
        _getPlaceDetailsUseCase = getPlaceDetailsUseCase,
        super(SearchInitial());


  ///variables
  AddressBody? _fromAddressBody;
  AddressBody? _toAddressBody;
  List<AddressBody> _placePredictions = [];
  static const double _radius = 1000;
  UpdatePlace _updatePlace = UpdatePlace.to;
  AddressesEntity? _addressesEntity ;

  ///getters
  AddressBody? get toAddressBody => _toAddressBody;
  AddressBody? get fromAddressBody => _fromAddressBody;
  AddressesEntity? get addressesEntity => _addressesEntity;
  List<AddressBody> get placePredictions => _placePredictions;
  bool get isAddressSelectedSuccessfully => (_fromAddressBody!=null &&_toAddressBody!=null);



  updateLocation(AddressBody? addressBody)async{
    print('asdasdad');
    switch(_updatePlace) {
      case UpdatePlace.from:await setFromLocation(addressBody);break;
      case UpdatePlace.to:await setToLocation(addressBody);break;
    }
    print('555555_fromAddressBody ${_fromAddressBody} : _toAddressBody ${_toAddressBody}');
    print('555555 ${isAddressSelectedSuccessfully}');

    _moveTo();
  }

  _moveTo(){if(isAddressSelectedSuccessfully){

    NavigationService.push(Routes.driverSelectCarScreen,arguments: {'from':_fromAddressBody,'to':_toAddressBody});}}

  Future<AddressBody?> _getPlaceDetails(String placeId)async{
   ResponseModel responseModel =await _getPlaceDetailsUseCase.call(placeId:placeId);
   return responseModel.data;
  }

/*
  setFromLocation(AddressBody? addressBody) async {
    if (addressBody?.address != null && addressBody?.latLng == null) {
      List<Location> locations = await locationFromAddress(addressBody!.address!);

      _fromAddressBody = addressBody.copyWith(latLng: LatLng(locations[0].latitude, locations[0].longitude));
    } else {
      _fromAddressBody = addressBody;
    }
    emit(SearchInitial());
  }*/
  setFromLocation(AddressBody? addressBody) async {
    if (addressBody?.placeId != null && addressBody?.latLng == null) {
      _fromAddressBody = await _getPlaceDetails(addressBody!.placeId!);
    } else {
      _fromAddressBody = addressBody;
    }
    emit(SearchInitial());
  }

  setToLocation(AddressBody? addressBody) async {
    if (addressBody?.placeId != null && addressBody?.latLng == null) {
      _toAddressBody = await _getPlaceDetails(addressBody!.placeId!);
    } else {
      _toAddressBody = addressBody;
    }
    emit(SearchInitial());
  }

/*
  setToLocation(AddressBody? addressBody) async{
    if(addressBody?.address!=null && addressBody?.latLng == null) {
      List<Location> locations =await locationFromAddress(addressBody!.address!);
      _toAddressBody = addressBody.copyWith(latLng: LatLng(locations[0].latitude, locations[0].longitude));
    }else{
      _toAddressBody = addressBody;
    }
    _toAddressBody = addressBody;
    emit(SearchInitial());
  }
*/

  void searchForPlaces(BuildContext context, String input, UpdatePlace updatePlace) async {
    if (_updatePlace != updatePlace) {_placePredictions = [];}
    _updatePlace = updatePlace;
    if (input.isNotEmpty) {
      ResponseModel responseModel = await _getPlacesUseCase.call(context, input);

      if (responseModel.isSuccess) {_placePredictions = responseModel.data;}
      emit(SearchInitial());
    } else {
      _placePredictions = [];
      emit(SearchInitial());
    }
  }

/*
  void searchForPlaces1(BuildContext context,String input,UpdatePlace updatePlace) async {
    if( _updatePlace != updatePlace){_placePredictions = [];}

    _updatePlace = updatePlace;

    if (input.isNotEmpty) {
      String url = "https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$input&key=${Constants.kGoogleMapKey}&language=${context.locale.languageCode}";
      // String url = "https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$input&key=AIzaSyBvjoIOOX8uJteEXBRDoYmt_lK2a4tpwok&language=${context.locale.languageCode}";

      if (_fromAddressBody?.latLng != null && _radius != null) {
        url += "&location=${_fromAddressBody?.latLng?.latitude},${_fromAddressBody?.latLng?.longitude}&radius=$_radius";
      }

      final response = await http.get(Uri.parse(url));
      final json = jsonDecode(response.body);

      if (json["error_message"] != null) {
        var error = json["error_message"];
        if (error == "This API project is not authorized to use this API.") error += " Make sure the Places API is activated on your Google Cloud Platform";
        throw Exception(error);
      } else {
        final predictions = json["predictions"];
        // _placePredictions = predictions;
        // _placePredictions = predictions;

        for(var model in predictions){
          List<Location> locations =await locationFromAddress( model['description']);
          _placePredictions.add(AddressBody(title:  model['description'], latLng: LatLng(locations[0].latitude, locations[0].longitude), address:  model['description']));
        }


        emit(SearchInitial());

      }
    } else {
      _placePredictions = [];
      emit(SearchInitial());

    }
  }





Future selectPlaceFromSuggestion({required String address}) async {
  try {
    placePredictions.clear();
    List<Location> locations =await locationFromAddress(address);
    AddressBody addressBody = AddressBody(address: address,title: address, latLng: LatLng(locations[0].latitude, locations[0].longitude));
    updateLocation(addressBody);

    if (_fromAddressBody!=null && _toAddressBody!=null) {
      NavigationService.push(RoutesDriver.driverSelectCarScreen,arguments: {'from':_fromAddressBody,'to':_toAddressBody});
    }
  } catch (e) {
    print(e);
  }
}
*/


  //get Addresses list
  Future<ResponseModel<AddressesEntity>> getAddresses() async {

    emit(SearchInitial());
    ResponseModel<AddressesEntity> responseModel = await _getAddressesUseCase.call();
    _addressesEntity = responseModel.data;

    emit(SearchInitial());
    return responseModel;
  }


}
