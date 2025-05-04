import 'package:bloc/bloc.dart';

import 'package:meta/meta.dart';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart' as geocoding;
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as location;


import '../../../core/utils/constants.dart';
import '../../../core/utils/location/location_helper.dart';
import '../../../domain/request_body/address_body.dart';
import '../../../domain/usecase/trip/get_last_trip_usecase.dart';
import '../../sheet/rate_sheet/rate_sheet.dart';

part 'home_state.dart';


enum MapControllerStage { error, loading, done }
class HomeCubit extends Cubit<HomeState> with WidgetsBindingObserver {
  final _tag = 'MapCubit';
  final GetLastTripUseCase _getLastTripUseCase;

  HomeCubit(
      {required LocationHelper locationHelper,
      required GetLastTripUseCase getLastTripUseCase})
      : _locationHelper = locationHelper,
        _getLastTripUseCase = getLastTripUseCase,
        super(HomeInitial()){    WidgetsBinding.instance.addObserver(this);
  }

  MapControllerStage? mapControllerStage;
  @override
  Future<void> close() {
    WidgetsBinding.instance.removeObserver(this);
    return super.close();
  }
  Timer? _locationUpdateTimer;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // requestPermissions();
    // print('didChangeAppLifecycleState $state');
    //  if (state == AppLifecycleState.paused) {
    //   print('sadasddasdsadsadad AppLifecycleState.paused');
    //
    //   _locationUpdateTimer?.cancel(); // Cancel any existing timer
    //   _locationUpdateTimer=  Timer.periodic(Duration(seconds: 1), (Timer timer) {
    //
    //     print('locationUpdateTimer Driver ${timer.tick.toString()}');
    //     getCurrentUserLocation();
    //   });
    // }
  }



  LatLng? _currentUserLocation;
  CameraPosition? _currentCameraPosition;
  AddressBody? _userLocationModel;
  final LocationHelper _locationHelper;

  GoogleMapController? _mapViewController;


  LatLng? get currentUserLocation => _currentUserLocation;
  CameraPosition? get currentCameraPosition => _currentCameraPosition;
  AddressBody? get userLocationModel => _userLocationModel;
  GoogleMapController? get mapViewController => _mapViewController;


  ///update map functions
  initGoogleMap() async { if (currentUserLocation == null) {getCurrentUserLocation();} }



  _moveCamera(){
    if (_mapViewController != null && _currentCameraPosition != null) {
      _mapViewController!.animateCamera(CameraUpdate.newCameraPosition(_currentCameraPosition!));
    } else {
    }
  }

  setMapController(GoogleMapController controller) {
    _mapViewController = controller;
  }


  //get current location
/*  Future getCurrentUserLocation() async {
    LatLng? currentLocation = await _locationHelper.gpsLastLocation();
    if (currentLocation == null) return;
    _userLocationModel = AddressBody(
      title: "${address.first.country}, ${address.first.name}, ${address.first.street}",
      address: "${address.first.country}, ${address.first.name}, ${address.first.street}",
      cameraView: currentLocation.heading,
      latLng: LatLng(currentLocation.latitude, currentLocation.longitude),
    );
    // change view position

    emit(
      state.copyWith(
        currentCameraPosition: CameraPosition(
          zoom: _zoomCamera,
          tilt: _tiltCamera,
          target: LatLng(currentLocation.latitude, currentLocation.longitude),
        ),
      ),
    );
    log(_tag, 'location ');
    _moveCamera();
  }*/
  Future getCurrentUserLocation() async {
    mapControllerStage = MapControllerStage.loading;

    try {
      LatLng? currentLocation = await _locationHelper.gpsLastLocation();
      print('getCurrentUserLocation ${currentLocation?.longitude}');

      if (currentLocation != null) {
        _currentUserLocation = LatLng(currentLocation.latitude, currentLocation.longitude);
        var address = await geocoding.placemarkFromCoordinates(currentLocation.latitude, currentLocation.longitude);


        _userLocationModel = AddressBody(
          title: "${address.first.country}, ${address.first.name}, ${address.first.street}",
          address: "${address.first.country}, ${address.first.name}, ${address.first.street}",
          // cameraView: currentLocation.heading,
          latLng: LatLng(currentLocation.latitude, currentLocation.longitude),
        );

        // change view position
        _currentCameraPosition = CameraPosition(
          zoom: kZoomCamera,
          tilt: kTiltCamera,
          target: LatLng(currentLocation.latitude, currentLocation.longitude),
        );


        final location.Location movingLocation = location.Location();
        movingLocation.onLocationChanged.listen((newLocation) {
          _currentUserLocation = LatLng(newLocation.longitude??0.0, newLocation.longitude??0.0);

        });
      }
      mapControllerStage = MapControllerStage.done;
      _moveCamera();
    } catch (e) {
      checkLocationPermission();
      mapControllerStage = MapControllerStage.error;
    }
    emit(HomeInitial());
  }

/*
  Future getCurrentUserLocation() async {
    mapControllerStage = MapControllerStage.loading;
    try {
      Position currentLocation = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      if (currentLocation != null) {
        _currentUserLocation = LatLng(currentLocation.latitude, currentLocation.longitude);
        var address = await geocoding.placemarkFromCoordinates(currentLocation.latitude, currentLocation.longitude);

        log(_tag, 'getCurrentUserLocation :: $_currentUserLocation');

        _userLocationModel = AddressBody(
          title: "${address.first.country}, ${address.first.name}, ${address.first.street}",
          address: "${address.first.country}, ${address.first.name}, ${address.first.street}",
          cameraView: currentLocation.heading,
          latLng: LatLng(currentLocation.latitude, currentLocation.longitude),
        );

        // change view position
        _currentCameraPosition = CameraPosition(
          zoom: kZoomCamera,
          tilt: kTiltCamera,
          target: LatLng(currentLocation.latitude, currentLocation.longitude),
        );


        final location.Location movingLocation = location.Location();
        movingLocation.onLocationChanged.listen((newLocation) {
          _currentUserLocation = LatLng(newLocation.longitude??0.0, newLocation.longitude??0.0);

        });
      }
      mapControllerStage = MapControllerStage.done;
      log(_tag, 'getCurrentUserLocation :: moving moving camera to $_currentUserLocation');

      _moveCamera();
    } catch (e) {
      log(_tag, 'getCurrentUserLocation :: Error => $e');
      checkLocationPermission();
      mapControllerStage = MapControllerStage.error;
    }
    emit(HomeInitial());
  }*/

  Future checkLocationPermission() async => await Geolocator.requestPermission();

  getLastTrip(BuildContext context) async {
    await _getLastTripUseCase.call().then((response) {
      if(response.data!=null/* &&response.data?.userRate == 0*/){
        showRate(context,  entity: response.data!);
      }
    });
  }

}
