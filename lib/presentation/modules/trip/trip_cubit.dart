import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:meta/meta.dart';
import 'package:q_trip_user/core/assets_constant/images.dart';
import 'package:q_trip_user/domain/logger.dart';
import '../../../core/resources/color.dart';
import '../../../core/routing/navigation_services.dart';
import '../../../core/routing/routes.dart';
import '../../../core/utils/globals.dart';
import '../../../core/utils/location/location_helper.dart';
import '../../../core/utils/map_helper.dart';
import '../../../data/model/base/response_model.dart';
import '../../../data/model/response/distance_trip_model.dart';
import '../../../data/model/response/driver_model.dart';
import '../../../data/model/response/offer_trip_model.dart';
import '../../../data/model/response/trip_model.dart';
import '../../../domain/entities/direction_details_entity.dart';
import '../../../domain/entities/driver_entity.dart';
import '../../../domain/entities/trip_entity.dart';
import '../../../domain/request_body/vehicle_body.dart';
import '../../../domain/usecase/google/get_direction_usecase.dart';
import '../../../domain/usecase/trip/accept_trip_usecase.dart';
import '../../../domain/usecase/trip/get_distance_trip_usecase.dart';
import '../../../domain/usecase/trip/get_my_live_driver_usecase.dart';
import '../../../domain/usecase/trip/get_my_live_trip_usecase.dart';
import '../../../domain/usecase/trip/get_my_offers_trip_usecase.dart';
import '../../../generated/assets.dart';

part 'trip_state.dart';

class TripCubit extends Cubit<TripState> {
  final _tag ='TripCubit';
  final GetDirectionUseCase _getDirectionUseCase;
  final GetMyLiveTripUseCase _getMyLiveTripUseCase;
  final GeMyOffersTripUseCase _geMyOffersTripUseCase;
  final GetMyLiveDriverUseCase _getMyLiveDriverUseCase;
  final GetDistanceTripUseCase _getDistanceTripUseCase;
  final AcceptTripUseCase _acceptTripUseCase;
  final LocationHelper _locationHelper;

  TripCubit({
    required GetMyLiveTripUseCase getMyLiveTripUseCase,
    required GetDirectionUseCase getDirectionUseCase,
    required GeMyOffersTripUseCase geMyOffersTripUseCase,
    required AcceptTripUseCase acceptTripUseCase,
    required GetMyLiveDriverUseCase getMyLiveDriverUseCase,
    required GetDistanceTripUseCase getDistanceTripUseCase,
    required LocationHelper locationHelper,
  })  : _getMyLiveTripUseCase = getMyLiveTripUseCase,
        _getMyLiveDriverUseCase = getMyLiveDriverUseCase,
        _getDistanceTripUseCase = getDistanceTripUseCase,
        _acceptTripUseCase = acceptTripUseCase,
        _geMyOffersTripUseCase = geMyOffersTripUseCase,
        _getDirectionUseCase = getDirectionUseCase,
        _locationHelper = locationHelper,
        super(TripState());

  ///variables
  StreamSubscription? _streamTripSubscription;
  StreamSubscription? _streamDriverSubscription;
  StreamSubscription? _streamOffersDriverSubscription;
  Set<Marker> mapMarkers = {};
  GoogleMapController? _mapViewController;
  final List<LatLng> _polyLineCoordinates = [];
  LatLng? _pickupBody;
  LatLng? _dropOffBody;
  LatLng? _driverBody;

  ///getters
  TripEntity? currentTripEntity;
  init(BuildContext context, String tripId,{TripEntity ? tripEntity}) {
    print('initdddd $tripId');
    currentTripEntity = tripEntity;
    emit(TripState());

    _pickupBody = null;
    _dropOffBody = null;
    _driverBody = null;

    mapMarkers={};
    _getOffersTrip(context, tripId);
    _getTrip(context, tripId);
    getTimeArrived();

  }

  DestanceTripModel? getDistanceTripModel;
  Future<dynamic> getDistanceTrip(String tripId,String captainId) async{
    try{
      emit(TripState());
      final res =await _getDistanceTripUseCase.call(tripId: tripId, captainId: captainId);
      if(res.isSuccess){
        getDistanceTripModel=res.data;
        emit(TripState());
      }else{
        emit(TripState());
      }
  }catch(e){

    }
  }
  List<TripOfferModel> driversOffers = [];
  void _getOffersTrip(BuildContext context, String tripId) {
    driversOffers.clear(); // تفريغ القائمة عند بدء الاستماع

    DatabaseReference tripOffersRef = FirebaseDatabase.instance
        .ref("trip_offers") // Using ref() instead of reference()
        .child(tripId);

    // ✅ الاستماع إلى التغييرات العامة
    _streamOffersDriverSubscription = tripOffersRef.onValue.listen((event) {
      if (event.snapshot.exists)  {
        driversOffers.clear(); // إعادة تحميل القائمة لتجنب التكرار
        event.snapshot.children.forEach((offer)async {
          var driverId = offer.child('driver_id').value?.toString() ?? '';
          await getDistanceTrip(tripId, driverId).then((value) {
            TripOfferModel newOffer = TripOfferModel.fromSnapshot(offer);
            bool alreadyExists = driversOffers.any((existingOffer) =>
            existingOffer.driverId == newOffer.driverId);
            if (!alreadyExists) {
              newOffer.timeCaptainUser = getDistanceTripModel?.duration?.toString() ?? '';
              newOffer.distanceCaptainUser = getDistanceTripModel?.distance?.toString() ?? '';
              driversOffers.add(newOffer);
            }
          });

        });

        emit(state.copyWith(refish: true));

        if (driversOffers.isEmpty) {
          _removeMarker('driver');
          _setLocations(context);
        }
      }
    });

    // ✅ تحديث العرض عند تعديله مباشرةً
    tripOffersRef.onChildChanged.listen((event) {
      var updatedOffer = TripOfferModel.fromSnapshot(event.snapshot);
      int index = driversOffers.indexWhere((element) => element.driverId == updatedOffer.driverId);
      if (index != -1) {
        driversOffers[index] = updatedOffer;
        emit(state.copyWith(refish: true));
      }
    });

    // ✅ حذف العرض عند إزالته من Firebase
    tripOffersRef.onChildRemoved.listen((event) {
      var removedOfferId = event.snapshot.child('driver_id').value?.toString() ?? '';
      driversOffers.removeWhere((element) => element.driverId == removedOfferId);
      emit(state.copyWith(refish: true));

      if (driversOffers.isEmpty) {
        _removeMarker('driver');
        _setLocations(context);
      }
    });

    emit(state.copyWith(refish: true));
  }


removeOffer(TripOfferModel trip){
  driversOffers.remove(trip);
  emit(state.copyWith(refish: true));
}

  Future<String> acceptOffer({required String tripId,required String driverId,required String price,}) async {
    try{
      emit(state.copyWith(isLoading:true));

      final res = await _acceptTripUseCase.call(tripId: tripId,driverId:driverId,price:price);
      if(res.isSuccess &&res.data!=null){
        return res.data??'';
      }else{
        emit(state.copyWith(isLoading:false));
        return '';
      }
    }catch(e){
      emit(state.copyWith(isLoading:false));
      return '';
    }
  }

  final  DatabaseReference _reference = FirebaseDatabase.instance.ref().child('trips');
  int countMessageUnRead = 0;

  Stream<int> getUnReadMessageCount(String tripId) {
    final StreamController<int> controller = StreamController<int>();
    int countMessageUnRead = 0;

    // الاستماع إلى كل الرسائل الموجودة وحساب الرسائل غير المقروءة
    _reference.child(tripId).child('chat').onValue.listen((event) {
      countMessageUnRead = 0; // إعادة الحساب من الصفر
      if (event.snapshot.exists && event.snapshot.value != null) {
        for (var element in event.snapshot.children) {
          var senderId = element.child('sender_id').value.toString();
          var isRead = element.child('isRead').value;

          if (senderId != 'user-${kUser!.id.toString()}') {
            if (isRead == null || isRead == false) {
              countMessageUnRead++;
            }
          }
        }
      }
      controller.add(countMessageUnRead); // إرسال العدد الجديد للـ Stream
    });

    return controller.stream;
  }
  TripEntity? tripEntityCubit;
  _getTrip(BuildContext context,String tripId) {
    _streamTripSubscription = _getMyLiveTripUseCase.call(tripId).listen((event) {
      log('TripBloc', 'getData ${event.snapshot.child('tripId').value.toString()}');

      if(event.snapshot.exists){

        emit(state.copyWith( tripEntity: TripModel.fromSnapshot(event.snapshot)));
        tripEntityCubit =TripModel.fromSnapshot(event.snapshot);
          if(event.snapshot.child('driver_id').value.toString()=='0'){
            _removeMarker('driver');
            _setLocations(context);

        }else{
            _getDriver(context, event.snapshot.child('driver_id').value.toString());
           if(state.tripEntity?.status != 'accepted'){
             emit(state.copyWith(usedTripPolyLines: {}));
           }
          }
      }else{
        NavigationService.pushNamedAndRemoveUntil(Routes.driverHomeScreen);
      }
    });
  }

  _getDriver(BuildContext context,String driverId)async {
    _streamDriverSubscription = _getMyLiveDriverUseCase.call(driverId).listen((event) {
      if(event.snapshot.exists) {
        var driver = DriverModel.fromJson(event.snapshot);
        emit(state.copyWith(driver:driver));
        _driverBody = driver.location;
        _setDriverLocations(context);
        _getTimeDriver();
        _getDistanceDriver();
        _setLocations(context);
      }
    });
  }

  _getTimeDriver()async{
    if(_driverBody!=null&&_pickupBody!=null){
     int duration= _locationHelper.calculateDuration(_driverBody!, _pickupBody!);
      emit(state.copyWith(driverArriveDuration: duration));
    }else{

    }
  }

  getTimeArrived()async{
    driverDirectionEntity = null;
    emit(state.copyWith(arriveDistance:0));

    LocationData? locationData = await _locationHelper.locationData;
    LatLng dropLocation = LatLng(double.tryParse(currentTripEntity?.dropLat.toString()??'0')??0.0,double.tryParse(currentTripEntity?.dropLng.toString()??'0')??0.0);
    if(locationData?.latitude==null || locationData?.latitude ==0.0)_locationHelper.gpsChangeStream((p0)async {
      LocationData? locationData = p0;
      DirectionDetailsEntity? thisDetails = await _getDirectionDetails(LatLng(double.parse(locationData.latitude?.toString()??'0'),
          double.parse(locationData?.longitude?.toString()??'0')),currentTripEntity!=null?dropLocation: _dropOffBody??_driverBody??LatLng(0,0));
      driverDirectionEntity = thisDetails;
      emit(state.copyWith(arriveDistance:0));

      return;
    });

    print('locationDatalocationData555 ${locationData?.latitude} ${locationData?.longitude}');
    DirectionDetailsEntity? thisDetails = await _getDirectionDetails(LatLng(double.parse(locationData?.latitude?.toString()??'0'),
        double.parse(locationData?.longitude?.toString()??'0')),currentTripEntity!=null?dropLocation: _dropOffBody??_driverBody??LatLng(0,0));
    driverDirectionEntity = thisDetails;
    print('locationDatalocationData555driverDirectionEntity ${driverDirectionEntity?.durationText} ${driverDirectionEntity?.distanceText}');

    emit(state.copyWith(arriveDuration: 0));

    print('getTimeArrived');
    if(_driverBody!=null){
      print('getTimeArrived Start');
      int duration= _locationHelper.calculateDuration(_driverBody!,  LatLng(state.tripEntity?.dropLat.toDouble()??0.0, state.tripEntity?.dropLng.toDouble()??0.0));
      emit(state.copyWith(arriveDuration: duration));
    }else{
    }

  }
  getArrivedDistance()async{
    if(_driverBody!=null&&_dropOffBody!=null){
      double distance= await calculateDeliveryDistance(_driverBody!, _dropOffBody!);
      emit(state.copyWith(arriveDistance: distance));
    }else{

    }
  }
  _getDistanceDriver()async{
    if(_driverBody!=null&&_pickupBody!=null){
      double distance= await calculateDeliveryDistance(_driverBody!, _pickupBody!);
      emit(state.copyWith(driverArriveDistance: distance));
    }else{

    }
  }
  getTimeDriverLive()async{
    if(_driverBody!=null&&_pickupBody!=null&& state.driverDirectionEntity==null){
      DirectionDetailsEntity? thisDetails = await _getDirectionDetails(_driverBody!,_pickupBody!);
      if(thisDetails?.encodedPoints==null) return;
      emit(state.copyWith(driverDirectionEntity: thisDetails));
    }else{

    }
  }
   Future<double> calculateDeliveryDistance(LatLng myPosition, LatLng deliveryPosition) async {

    double? distance = await getDistanceBetween(
      myPosition: myPosition,
      deliveryPosition: deliveryPosition,
    );

    return distance??0.0;
  }
  Future<double?> getDistanceBetween(
      {required LatLng myPosition, required LatLng deliveryPosition}) async {
    try {
      // حساب المسافة بين نقطتين بالكيلومترات
      double distanceInMeters = Geolocator.distanceBetween(
        myPosition.latitude,
        myPosition.longitude,
        deliveryPosition.latitude,
        deliveryPosition.longitude,
      );

      // تحويل المسافة من متر إلى كيلومترات
      double distanceInKm = distanceInMeters / 1000;
      return distanceInKm;
    } catch (e) {
      print('Error calculating distance: $e');
      return null;
    }
  }
  _setLocations(BuildContext context){
    if (state.tripEntity?.pickupLat == null || state.tripEntity?.pickupLng == null || state.tripEntity?.dropLat == null || state.tripEntity?.dropLng == null || _mapViewController == null) return;

    _pickupBody = LatLng(state.tripEntity!.pickupLat.toDouble(), state.tripEntity!.pickupLng.toDouble());
    _dropOffBody = LatLng(state.tripEntity!.dropLat.toDouble(), state.tripEntity!.dropLng.toDouble());

    if(_driverBody!=null){_moveCameraTODriverLocation();}else{_moveCameraToRout();}

    _setUserMarker(_pickupBody!,'from',Assets.imagesCurrentLocationMarker);
    _setUserMarker(_dropOffBody!,'to',Assets.imagesDestinationLocationMarker);

    _drawPolyLine(context);
  }

  _setDriverLocations(BuildContext context){
    if (state.tripEntity?.pickupLat == null || state.tripEntity?.pickupLng == null || _driverBody == null || _mapViewController == null) return;

    _pickupBody = LatLng(state.tripEntity!.pickupLat.toDouble(), state.tripEntity!.pickupLng.toDouble());

    _moveCameraTODriverLocation();

    _setUserMarker(_pickupBody!,'from',Assets.imagesCurrentLocationMarker);
    _setUserMarker(_driverBody!,'driver',AppImages.car);
    // _setUserMarker(_driverBody!,'driver',Assets.imagesCarMarker);

  }

  setMapController(GoogleMapController controller) =>_mapViewController = controller;


  _moveCameraToRout(){
    if(_mapViewController == null || _pickupBody==null || _dropOffBody==null)return;
    LatLngBounds? latLngBounds= MapHelper.moveCamera(from: _pickupBody, to: _dropOffBody);
    if(latLngBounds!=null){_mapViewController!.animateCamera(   CameraUpdate.newLatLngBounds(latLngBounds,76.0));}
  }
  _moveCameraTODriverLocation(){
    if(_mapViewController == null || _pickupBody==null || _driverBody==null)return;
    LatLngBounds? latLngBounds= MapHelper.moveCamera(from: _pickupBody, to: _driverBody);
    if(latLngBounds!=null){_mapViewController!.animateCamera(   CameraUpdate.newLatLngBounds(latLngBounds,76.0));}
  }



  _removeMarker(String key) async {
    mapMarkers.removeWhere((element) => element.markerId.value == key);
    TripState tripState = state;
    emit(tripState);
  }
  _setUserMarker(LatLng latLng,String key,String image) async {
    final marker = Marker(
        markerId: MarkerId(key),
        position: latLng,
        zIndex: 18,
        draggable: false,
        icon: BitmapDescriptor.fromBytes(await MapHelper.getBytesFromAsset(image, 100)));

    mapMarkers.removeWhere((element) => element.markerId.value == key);
    mapMarkers.add(marker);
    TripState tripState = state;
    emit(tripState);
  }

  DirectionDetailsEntity? driverDirectionEntity;

  _drawPolyLine(BuildContext context) async {
    if(_driverBody==null || _pickupBody==null )   return;
    if(state.tripPolyLines.isNotEmpty ){
      emit(state.copyWith(usedTripPolyLines:state._usedTripPolyLines));
      return;
    }

    if(_pickupBody==null || _dropOffBody==null)return;
    final PolylinePoints polylinePoints = PolylinePoints();
    LocationData? locationData = await _locationHelper.locationData;
    print('locationDatalocationData ${locationData?.latitude} ${locationData?.longitude}');
    DirectionDetailsEntity? thisDetails = await _getDirectionDetails(LatLng(double.parse(locationData?.latitude?.toString()??'0'),double.parse(locationData?.longitude?.toString()??'0')), _driverBody!);
    driverDirectionEntity = thisDetails;
    if(thisDetails?.encodedPoints==null) return;
    List<PointLatLng> results = polylinePoints.decodePolyline(thisDetails!.encodedPoints!);
    _polyLineCoordinates.clear();
    if (results.isNotEmpty) {

      // loop through all PointLatLng points and convert them
      // to a list of LatLng, required by the Polyline
      for (var point in results) {_polyLineCoordinates.add(LatLng(point.latitude, point.longitude));}
      if(_polyLineCoordinates.isNotEmpty){
         Set<Polyline>_tripPolyLines={};
        _tripPolyLines.add(
          Polyline(
            polylineId: const PolylineId('tripRoute'),
            points: _polyLineCoordinates,
            color: primaryColor,
            geodesic: true,
            jointType: JointType.round,
            width: 5,
            endCap: Cap.roundCap,
            startCap: Cap.roundCap,
          ),
        );
        if(_tripPolyLines.isNotEmpty){

        emit(state.copyWith(tripPolyLines:_tripPolyLines,usedTripPolyLines: _tripPolyLines,directionDetailsEntity: thisDetails ));

        _moveCameraToRout();
        }
      }
    }

    TripState tripState = state;
    emit(tripState);


  }

  Future<DirectionDetailsEntity?> _getDirectionDetails(LatLng from,LatLng to) async {
    ResponseModel<DirectionDetailsEntity> responseModel =await _getDirectionUseCase.call(body: VehicleBody(from: from, to: to, type: ''));

    return responseModel.data;
  }
/*  Future cancelTrip() async {
    if(state.tripEntity?.tripId==null)return;
    emit(state.copyWith(isLoading: true));
    ResponseModel responseModel =await _cancelTripUseCase.call(tripId: state.tripEntity!.tripId);
    emit(state.copyWith(isLoading: false));
    return responseModel;

  }*/
  @override
  Future<void> close() {_streamTripSubscription?.cancel();return super.close();}
  void dispose() {_streamTripSubscription?.cancel();_streamDriverSubscription?.cancel();}

}
