import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:meta/meta.dart';

import 'package:flutter_polyline_points/flutter_polyline_points.dart';

import 'package:bloc/bloc.dart';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../core/utils/map_helper.dart';
import '../../../data/datasource/remote/exception/error_widget.dart';
import '../../../data/model/base/response_model.dart';
import '../../../domain/entities/direction_details_entity.dart';
import '../../../domain/entities/promo_code_entity.dart';
import '../../../domain/entities/vehicle_entity.dart';
import '../../../domain/request_body/address_body.dart';
import '../../../domain/request_body/request_body.dart';
import '../../../domain/request_body/vehicle_body.dart';
import '../../../domain/usecase/google/get_direction_usecase.dart';
import '../../../domain/usecase/trip/get_vehicles_usecase.dart';
import '../../../domain/usecase/trip/store_trip_usecase.dart';
import '../../../generated/assets.dart';

part 'select_car_state.dart';

class SelectCarCubit extends Cubit<SelectCarState> {
  final GetDirectionUseCase _getDirectionUseCase;
  final GetVehiclesUseCase _getVehiclesUseCase;
  final StoreTripUseCase _storeTripUseCase;

  SelectCarCubit({
    required GetDirectionUseCase getDirectionUseCase,
    required GetVehiclesUseCase getVehiclesUseCase,
    required StoreTripUseCase storeTripUseCase,
  })  : _getDirectionUseCase = getDirectionUseCase,
        _getVehiclesUseCase = getVehiclesUseCase,
        _storeTripUseCase = storeTripUseCase,
        super(SelectCarInitial());

  static const double _zoomCamera = 140.0;

  ///variables
  AddressBody? _pickupBody;
  AddressBody? _dropOffBody;
  Set<Marker> mapMarkers = {};
  GoogleMapController? _mapViewController;
  final Set<Polyline> _tripPolyLines = {};
  final List<LatLng> _polyLineCoordinates = [];
  late RequestBody _body;
  DirectionDetailsEntity? _detailsEntity;

  bool isMale = true;


  ///getters
  AddressBody? get dropOffBody => _dropOffBody;
  AddressBody? get pickupBody => _pickupBody;
  Set<Polyline> get tripPolyLines => _tripPolyLines;
  List<LatLng> get polyLineCoordinates => _polyLineCoordinates;
  RequestBody get body => _body;
  // VehicleBody get _vehicleBody =>  VehicleBody(from:LatLng(_pickupBody?.latLng?.latitude??0.0, _pickupBody?.latLng?.longitude??0.0), to: LatLng(_dropOffBody?.latLng?.latitude??0.0, _dropOffBody?.latLng?.longitude??0.0));
 late VehicleBody _vehicleBody ;
  DirectionDetailsEntity? get detailsEntity => _detailsEntity;


  setPromoCode(PromoCodeEntity? entity){
    _body.setPromoCode(entity);
    _vehicleBody.setPromoCode(entity);
    _getVehicles();
  }

  selectGender(String gender){
    _body.selectGender(gender);
    // emit(SelectCarInitial());

  }
  String radioValue='0';

  selectPaymentMethod(String payment){
    _body.selectPaymentMethod(payment);
    // emit(SelectCarInitial());
  }
  onUpdateCar(VehicleEntity vehicleEntity){
    _body.updateVehicleType(vehicleEntity.id);
    _body.updateAmount(vehicleEntity.priceAfterDiscount.toString());

    emit(SelectCarInitial());
    // if(state is SelectCarSuccessfully){
    //   (state as SelectCarSuccessfully).body!.updateVehicleType(vehicleEntity.id) ;
    //   emit((state as SelectCarSuccessfully).copyWith(body: (state as SelectCarSuccessfully).body));
    // }
  }
   bool isCar =true;
  getVehicles(AddressBody from , AddressBody to,String type){
    _vehicleBody = VehicleBody(from:LatLng(_pickupBody?.latLng?.latitude??0.0, _pickupBody?.latLng?.longitude??0.0), to: LatLng(_dropOffBody?.latLng?.latitude??0.0, _dropOffBody?.latLng?.longitude??0.0), type: type);
    _getVehicles();
  }
  init(BuildContext context,AddressBody from , AddressBody to,String type){
   _body = RequestBody(from: from.latLng!,to: to.latLng!);

    _pickupBody=from;
    _dropOffBody=to;
    _vehicleBody = VehicleBody(from:LatLng(_pickupBody?.latLng?.latitude??0.0, _pickupBody?.latLng?.longitude??0.0), to: LatLng(_dropOffBody?.latLng?.latitude??0.0, _dropOffBody?.latLng?.longitude??0.0), type: type);
     isCar=true;
    _getVehicles();


    if(from.latLng?.latitude!=null)_setUserMarker(from,'from',Assets.imagesCurrentLocationMarker);
    if(to.latLng?.latitude!=null)_setUserMarker(to,'to',Assets.imagesDestinationLocationMarker);

    if(from.latLng?.latitude!=null && to.latLng?.latitude!=null){
      _drawPolyLine(context);
    if(_mapViewController!=null){
        try {
          _mapViewController!.moveCamera(
            CameraUpdate.newLatLngBounds(
              LatLngBounds(southwest: _vehicleBody.from, northeast: _vehicleBody.to,),
              _zoomCamera,
            ),
          );
        } catch (e) {}
      }
    }
  }

  setMapController(GoogleMapController controller) {
    _mapViewController = controller;
    _moveCamera();
  }

  _moveCamera(){
    if(_mapViewController == null || _pickupBody==null || _dropOffBody==null)return;
    LatLngBounds? latLngBounds= MapHelper.moveCamera(from: _pickupBody!.latLng, to: _dropOffBody!.latLng);
    if(latLngBounds!=null){_mapViewController!.animateCamera(   CameraUpdate.newLatLngBounds(latLngBounds,76.0));}
  }

/*  _moveCamera(){
    try{
      if(_pickupBody?.latLng!=null &&_dropOffBody?.latLng!=null && _mapViewController!=null){
        LatLngBounds latLngBounds;
        if(_pickupBody!.latLng!.latitude>_dropOffBody!.latLng!.latitude && _pickupBody!.latLng!.longitude>_dropOffBody!.latLng!.longitude){
          latLngBounds= LatLngBounds(southwest: _dropOffBody!.latLng!, northeast: _pickupBody!.latLng!);
        }else if(_pickupBody!.latLng!.longitude>_dropOffBody!.latLng!.longitude ){
          latLngBounds= LatLngBounds(southwest: LatLng(_pickupBody !.latLng!.latitude,_dropOffBody!.latLng!.longitude), northeast: LatLng(_dropOffBody!.latLng!.latitude,_pickupBody!.latLng!.longitude));
        }else if(_pickupBody!.latLng!.latitude>_dropOffBody!.latLng!.latitude){
          latLngBounds= LatLngBounds(southwest: LatLng(_dropOffBody!.latLng!.latitude,_pickupBody!.latLng!.longitude), northeast: LatLng(_pickupBody!.latLng!.latitude,_dropOffBody!.latLng!.longitude));
        }else{
          latLngBounds= LatLngBounds(southwest: _pickupBody!.latLng!, northeast: _dropOffBody!.latLng!);
        }

        _mapViewController!.animateCamera(   CameraUpdate.newLatLngBounds(latLngBounds,_zoomCamera));

          // _mapViewController!.moveCamera(
          //   CameraUpdate.newLatLngBounds(
          //     LatLngBounds(southwest: _pickupBody!.latLng!, northeast: _dropOffBody!.latLng!), _zoomCamera,),
          // );

      }
    }catch(e){

    }
  }*/
  _setUserMarker(AddressBody body,String key,String image) async {
    final marker = Marker(
        markerId: MarkerId(key),
        position: body.latLng!,
        zIndex: 18,
        draggable: false,
        icon: BitmapDescriptor.fromBytes(await MapHelper.getBytesFromAsset(image, 100)));

    mapMarkers.removeWhere((element) => element.markerId.value == key);
    mapMarkers.add(marker);

    SelectCarState selectCarState = state;
    emit(selectCarState);


  }

  _drawPolyLine(BuildContext context) async {
    final PolylinePoints polylinePoints = PolylinePoints();
    _detailsEntity = await _getDirectionDetails();
    print('detailsEntity_drawPolyLine ${_detailsEntity?.durationText}');
    if(_detailsEntity?.encodedPoints==null) return;
    List<PointLatLng> results = polylinePoints.decodePolyline(_detailsEntity!.encodedPoints!);
    _polyLineCoordinates.clear();
    if (results.isNotEmpty) {
      // loop through all PointLatLng points and convert them
      // to a list of LatLng, required by the Polyline
      for (var point in results) {_polyLineCoordinates.add(LatLng(point.latitude, point.longitude));}
      _tripPolyLines.add(
        Polyline(
          polylineId: const PolylineId('tripRoute'),
          points: _polyLineCoordinates,
          color: Colors.blue,
          geodesic: true,
          jointType: JointType.round,
          width: 2,
          endCap: Cap.roundCap,
          startCap: Cap.roundCap,
        ),
      );
      _moveCamera();
    }


    SelectCarState selectCarState = state;
    emit(selectCarState);
  }
  Future<DirectionDetailsEntity?> _getDirectionDetails() async {
    ResponseModel<DirectionDetailsEntity> responseModel = await _getDirectionUseCase.call(body: _vehicleBody);
    return responseModel.data;
    // String url =
    //     'https://maps.googleapis.com/maps/api/directions/json?origin=${startPosition.latitude},${startPosition.longitude}&destination=${endPosition.latitude},${endPosition.longitude}&mode=driving&key=AIzaSyBvjoIOOX8uJteEXBRDoYmt_lK2a4tpwok';
    //
    // try {
    //   http.Response responseRequest = await http.get(Uri.parse(url));
    //   if (responseRequest.statusCode == 200) {
    //     String data = responseRequest.body;
    //     var response = jsonDecode(data);
    //     DirectionDetailsEntity directionDetails = DirectionDetailsEntity();
    //     directionDetails.durationText = response['routes'][0]['legs'][0]['duration']['text'] ?? '0';
    //     directionDetails.durationValue = response['routes'][0]['legs'][0]['duration']['value'] ?? 0;
    //
    //     directionDetails.distanceText = response['routes'][0]['legs'][0]['distance']['text'] ?? '0';
    //     directionDetails.distanceValue = response['routes'][0]['legs'][0]['distance']['value'] ?? 0;
    //
    //     directionDetails.encodedPoints = response['routes'][0]['overview_polyline']['points'];
    //     return directionDetails;
    //   }
    //   return null;
    // } catch (e) {
    //   print(e);
    //   return null;
    // }
  }
  bool isLoading =false;
  //get vehicles list
  _getVehicles() async {
    isLoading=true;
    emit(SelectCarLoading());

    ResponseModel<List<VehicleEntity>> responseModel = await _getVehiclesUseCase.call(body: _vehicleBody);
    if(responseModel.isSuccess){
      isLoading=false;

      emit(SelectCarSuccessfully(list: responseModel.data!));
      // emit(SelectCarSuccessfully().copyWith(list: responseModel.data!));
      if ((responseModel.data ?? []).isNotEmpty) {
        onUpdateCar(responseModel.data!.first);
      }
    }else{
      isLoading=false;

      emit(SelectCarError(error: responseModel.error!));
    }
  }
  //Store Trip
  Future<String>storeTrip() async {
    try{
      emit(SelectCarStoreRequest());
      final res = await _storeTripUseCase.call(body: _body);
      if(res.isSuccess &&res.data!=null){
        return res.data??'';
      }else{
        emit(SelectCarStoreError());
        return '';
      }
    }catch(e){
      emit(SelectCarStoreError());
      return '';
    }
  }

  //Paymentadd money
  // Future<dynamic>pay({required PaymentParams paymentParams ,required BuildContext context})async{
  //   try {
  //     emit(PaymentLoadingState());
  //     ResponseModel<String> responseModel = await _paymentUseCase.call(amount: amount);
  //     if(responseModel.isSuccess){
  //       String paymentUrl = responseModel.data??'';
  //      if(paymentUrl.isNotEmpty){
  //        Navigator.push(
  //          context,
  //          MaterialPageRoute(
  //            builder: (context) => PaymentPage(paymentUrl: paymentUrl),
  //          ),
  //        ).then((result) {
  //          if (result == true) {
  //            print("تم الدفع بنجاح");
  //          } else {
  //            print("فشلت عملية الدفع");
  //          }
  //        });
  //      }
  //       emit(PaymentSuccessfulState());
  //     }else{
  //       emit(PaymentErrorState());
  //       return responseModel.error;
  //     }
  //   }catch(e){
  //     emit(PaymentErrorState());
  //     return e;
  //   }
  // }


}
