// import 'dart:async';
// import 'dart:convert';
// import 'dart:typed_data';
// import 'dart:ui' as ui;
//
// import 'package:driver/domain/entities/destination_entity.dart';
// import 'package:driver/domain/entities/direction_details_entity.dart';
// import 'package:driver/domain/entities/location_entity.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_polyline_points/flutter_polyline_points.dart';
// import 'package:geocoding/geocoding.dart' as geocoding;
// import 'package:geolocator/geolocator.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:http/http.dart' as http;
// import 'package:location/location.dart' as location;
//
// import '../../../core/set_zoom.dart';
//
// enum MapControllerStage { ERROR, LOADING, DONE }
//
// class MapController extends ChangeNotifier {
//   MapControllerStage? mapControllerStage = null;
//
//
//   // MapController() {
//   //   initGoogleMap();
//   // }
//
//
//   initGoogleMap() async {
//     if (currentUserLocation == null) {
//       getCurrentUserLocation();
//     }
//   }
//
//   Future<void> zoomIn() async {
//     if (mapViewController != null) {
//       await setZoom(mapViewController!, true);
//     }
//   }
//
//   Future<void> zoomOut() async {
//     if (mapViewController != null) {
//       await setZoom(mapViewController!, false);
//     }
//   }
//
//   bool isDestinationSelected = false;
//
//   /// Home Components
//   LatLng? currentUserLocation;
//   LatLng? destinationLocation;
//
//   CameraPosition? currentCameraPosition;
//   addressBody? _userLocationModel;
//   DestinationEntity? _destinationLocationModel;
//   double _zoomCamera = 14.0; // for camera using
//   double _tiltCamera = 50; // for camera using
//   Set<Marker> mapMarkers = {};
//   Marker? userMarker;
//   Marker? destinationMarker;
//   Set<Circle> homeMapControllerCircles = {};
//   Set<Polyline> tripPolyLines = {};
//   GoogleMapController? mapViewController;
//   CameraPosition? initCameraPosition;
//   Marker? userCurrentLocationMarker;
//   Marker? userDestinationLocationMarker;
//   List<LatLng> polyLineCoordinates = [];
//   Set<Polyline> polyLines = {};
//   StreamSubscription? _subscriptionForRealTimeLocation;
//
//
//   DestinationEntity? get destinationLocationModel => _destinationLocationModel;
//   addressBody? get userLocationModel => _userLocationModel; // open map on my location
//
//
//
//   getMapController(GoogleMapController controller) {
//     mapViewController = controller;
//   }
//
//   Future<Uint8List> getBytesFromAsset(String path, int width) async {
//     ByteData data = await rootBundle.load(path);
//     ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetWidth: width);
//     ui.FrameInfo fi = await codec.getNextFrame();
//     return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!.buffer.asUint8List();
//   }
//
//   setDestination(BuildContext context) {
//     drawPolyLine(context);
//     setDestinationMarker();
//     notifyListeners();
//   }
//
//   setUserMarker() async {
//     final userMarker = Marker(
//         markerId: const MarkerId('currentLocation'),
//         position: LatLng(currentUserLocation?.latitude??0.0, currentUserLocation?.longitude??0.0),
//         zIndex: 18,
//         draggable: false,
//         // icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
//         icon: BitmapDescriptor.fromBytes(await getBytesFromAsset('images/currentLocation.png', 100)));
//
//     // mapMarkers.clear();
//     mapMarkers.remove(userCurrentLocationMarker);
//     mapMarkers.add(userMarker);
//     userCurrentLocationMarker = userMarker;
//
//     // print('currenttttttttttt666 ${mapMarkers.length}');
//     notifyListeners();
//   }
//
//   setDestinationMarker() async {
//     print('destinationLocationdestinationLocationzzzzz ${destinationLocation}');
//
//     final destinationMarker = Marker(
//         markerId: const MarkerId('destination1'),
//         position: LatLng(destinationLocation?.latitude??0.0, destinationLocation?.longitude??0.0),
//         zIndex: 18,
//         draggable: false,
//         // icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
//         icon: BitmapDescriptor.fromBytes(await getBytesFromAsset('images/distinationLocation.png', 100)));
//     userDestinationLocationMarker = destinationMarker;
//     mapMarkers.add(destinationMarker);
//     print('currenttttttttttt777 ${mapMarkers.length}');
//     notifyListeners();
//   }
//
//   drawPolyLine(BuildContext context) async {
//     final PolylinePoints polylinePoints = PolylinePoints();
//     // PolylineResult  polylineResult = await polylinePoints.getRouteBetweenCoordinates(
//     //     "AIzaSyBvjoIOOX8uJteEXBRDoYmt_lK2a4tpwok",
//     //     PointLatLng(currentUserLocation.latitude, currentUserLocation.longitude),
//     //     PointLatLng(destinationLocation.latitude, destinationLocation.longitude),
//     // );
//
//     DirectionDetailsEntity? thisDetails = await getDirectionDetails(
//         LatLng(currentUserLocation?.latitude??0.0, currentUserLocation?.longitude??0.0),
//         LatLng(destinationLocation?.latitude??0.0, destinationLocation?.longitude??0.0));
//     if (thisDetails?.encodedPoints==null) {
//       return;
//     }
//     List<PointLatLng> results = polylinePoints.decodePolyline(thisDetails!.encodedPoints!);
//     polyLineCoordinates.clear();
//     if (results.isNotEmpty) {
//       // loop through all PointLatLng points and convert them
//       // to a list of LatLng, required by the Polyline
//       for (var point in results) {
//         polyLineCoordinates.add(LatLng(point.latitude, point.longitude));
//       }
//       tripPolyLines.add(Polyline(
//         polylineId: const PolylineId('tripRoute'),
//         points: polyLineCoordinates,
//         color: Theme.of(context).primaryColor.withOpacity(0.6),
//         width: 4,
//       ));
//     }
//     print('Drawwwwwwwwwwwwww ${currentUserLocation?.latitude??0.0}');
//     print('Drawwwwwwwwwwwwww ${destinationLocation?.latitude??0.0}');
//     mapControllerStage = MapControllerStage.DONE;
//     notifyListeners();
//   }
//
//   Future<DirectionDetailsEntity?> getDirectionDetails(LatLng startPosition, LatLng endPosition) async {
//     String url =
//         'https://maps.googleapis.com/maps/api/directions/json?origin=${startPosition.latitude},${startPosition.longitude}&destination=${endPosition.latitude},${endPosition.longitude}&mode=driving&key=AIzaSyBvjoIOOX8uJteEXBRDoYmt_lK2a4tpwok';
//
//     try {
//       http.Response responseRequest = await http.get(Uri.parse(url));
//       if (responseRequest.statusCode == 200) {
//         String data = responseRequest.body;
//         var response = jsonDecode(data);
//         DirectionDetailsEntity directionDetails = DirectionDetailsEntity();
//         directionDetails.durationText = response['routes'][0]['legs'][0]['duration']['text'] ?? '0';
//         directionDetails.durationValue = response['routes'][0]['legs'][0]['duration']['value'] ?? 0;
//
//         directionDetails.distanceText = response['routes'][0]['legs'][0]['distance']['text'] ?? '0';
//         directionDetails.distanceValue = response['routes'][0]['legs'][0]['distance']['value'] ?? 0;
//
//         directionDetails.encodedPoints = response['routes'][0]['overview_polyline']['points'];
//         return directionDetails;
//       }
//       return null;
//     } catch (e) {
//       print(e);
//       return null;
//     }
//   }
//
//   Future getCurrentUserLocation() async {
//     mapControllerStage = MapControllerStage.LOADING;
//     print('currenttttttttttt111MapController ');
//
//     try {
//       Position currentLocation =
//       await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
//       if (currentLocation != null) {
//         currentUserLocation = LatLng(currentLocation.latitude, currentLocation.longitude);
//         var address =
//         await geocoding.placemarkFromCoordinates(currentLocation.latitude, currentLocation.longitude);
//         print('currenttttttttttt222 ${currentUserLocation} ');
//
//         _userLocationModel = addressBody(
//           placeName: "${address.first.country}, ${address.first.name}, ${address.first.street}",
//           cameraView: currentLocation.heading,
//           latLng: LatLng(currentLocation.latitude, currentLocation.longitude),
//         );
//
//         // change view position
//         currentCameraPosition = CameraPosition(
//           zoom: _zoomCamera,
//           tilt: _tiltCamera,
//           // bearing: currentLocation.heading,
//           target: LatLng(currentLocation.latitude, currentLocation.longitude),
//         );
//
//         initCameraPosition = currentCameraPosition;
//         setUserMarker();
//
//         final location.Location movingLocation = location.Location();
//         movingLocation.onLocationChanged.listen((newLocation) {
//           print('moving location');
//           currentUserLocation = LatLng(newLocation.longitude??0.0, newLocation.longitude??0.0);
//           setUserMarker();
//           // setDestinationMarker();
//         });
//       }
//       mapControllerStage = MapControllerStage.DONE;
//       print('currenttttttttttt333 $initCameraPosition');
//       print('currenttttttttttt444 $currentUserLocation}');
//       print('currenttttttttttt555 ');
//     } catch (e) {
//       print(e);
//       checkLocationPermission();
//       mapControllerStage = MapControllerStage.ERROR;
//       // currentUserLocation();
//     }
//     notifyListeners();
//   }
//
//   Future checkLocationPermission() async {
//     await Geolocator.requestPermission();
//   }
//
//   geRealTimeLocation(BuildContext context) {
//     mapMarkers.remove(userMarker);
//     if (_subscriptionForRealTimeLocation != null) {
//       _subscriptionForRealTimeLocation?.cancel();
//     }
//     int x = 30; //spend 30 second to update location
//     List<geocoding.Placemark> address = [];
//     _subscriptionForRealTimeLocation = Geolocator.getPositionStream().listen((currentLocation) async {
//       try {
//         address =
//         await geocoding.placemarkFromCoordinates(currentLocation.latitude, currentLocation.longitude);
//         currentUserLocation = LatLng(currentLocation.latitude, currentLocation.longitude);
//         _userLocationModel = addressBody(
//             placeName:
//             address.isNotEmpty && address.first != null ? address.first.street : address.first.name,
//             cameraView: currentLocation.heading,
//             latLng: LatLng(currentLocation.latitude, currentLocation.longitude));
//         // change view position
//         currentCameraPosition = CameraPosition(
//           zoom: _zoomCamera - 4,
//           tilt: _tiltCamera,
//           // bearing: currentLocation.heading,
//           target: LatLng(currentLocation.latitude, currentLocation.longitude),
//         );
//         initCameraPosition = currentCameraPosition;
//         Marker marker = Marker(
//             markerId: const MarkerId('currentLocation'),
//             position: LatLng(currentLocation.latitude, currentLocation.longitude),
//             icon: BitmapDescriptor.fromBytes(await getBytesFromAsset('images/currentLocation.png', 100)));
//         print('destttttttt $destinationLocation');
//         if (destinationLocation != null) {
//           drawPolyLine(context);
//         }
//         // setUserMarker();
//         mapMarkers.remove(userMarker);
//         mapMarkers.add(marker);
//         // mapViewController.animateCamera(CameraUpdate.newCameraPosition(currentCameraPosition));
//         // setDestinationMarker();
//
//         notifyListeners();
//       } catch (e) {
//         print(e);
//       }
//     });
//   }
//
//   getRealTimeCurrentLocation() {}
//
//   setCurrentUserLocationToHomeMap() {
//     if (mapViewController != null && currentCameraPosition!=null) {
//       mapViewController?.animateCamera(CameraUpdate.newCameraPosition(currentCameraPosition!));
//     }
//   }
//
//   setCurrentUserLocationToSearchMap() {
//     if (mapViewController != null&& currentCameraPosition!=null) {
//       mapViewController?.animateCamera(CameraUpdate.newCameraPosition(currentCameraPosition!));
//     }
//   }
//
//   Future<void> selectDestinationLocationFromMap(
//       {required LatLng destinationPosition,required BuildContext context, scaffoldKey}) async {
//     print('desssssssssoooooo $destinationLocation');
//     print('desssssssssoooooo');
//     try {
//       var addressesCountryForCurrentLocation = await geocoding.placemarkFromCoordinates(
//           currentUserLocation?.latitude??0.0, currentUserLocation?.longitude??0.0);
//       var firstForCurrentLocation = addressesCountryForCurrentLocation.first;
//
//       // var addressesCountryFromSuggestions = await geocoding.placemarkFromCoordinates(
//       //     res[0].latitude, res[0].longitude);
//       // var firstFromSuggestions = addressesCountryFromSuggestions.first;
//       //
//       // if (firstFromSuggestions.country == firstForCurrentLocation.country) {
//       //
//       // }
//       var addresses = await geocoding.placemarkFromCoordinates(
//           destinationPosition.latitude, destinationPosition.longitude);
//       var firstFromSuggestions = addresses.first;
//
//       // CameraPosition destinationCameraPosition = CameraPosition(
//       //   zoom: _zoomCamera,
//       //   tilt: _tiltCamera,
//       //   bearing: _userLocationModel.cameraView,
//       //   target: destinationPosition,
//       // );
//       // print("destinationCameraPosition $destinationCameraPosition");
//       // mapViewController.animateCamera(
//       //     CameraUpdate.newCameraPosition(destinationCameraPosition));
//       if (firstFromSuggestions.country == firstForCurrentLocation.country) {
//         _destinationLocationModel = DestinationEntity(
//             latLng: LatLng(destinationPosition.latitude, destinationPosition.longitude),
//             destinationName: addresses.first.street == null || (addresses.first.street??'').isEmpty
//                 ? addresses.first.name
//                 : addresses.first.street);
//         destinationLocation = LatLng(destinationPosition.latitude, destinationPosition.longitude);
//         isDestinationSelected = true;
//         setDestinationMarker();
//         drawPolyLine(context);
//         _zoomCamera = 10;
//         print("destinationPosition.longitude");
//         print(destinationPosition.longitude);
//         print(destinationPosition.latitude);
//         print(currentUserLocation?.longitude??0.0);
//         print(currentUserLocation?.latitude??0.0);
//         ///TODO nav to screen choose car
//         // Get.to(() => ChooseCar());
//       } else {
//         showSnack(
//             context: context,
//             msg: "خارج النطاق",
//             fullHeight: 30.0,
//             marginBottom: 80.0,
//             color: Theme.of(context).primaryColor,
//             isFloating: true,
//             scaffoldKey: scaffoldKey);
//
//         print('outtttttttttttt2');
//       }
//
//       notifyListeners();
//     } catch (e) {
//       print(e);
//     }
//   }
//
//   double radius = 1000;
//   String selectedLocation = '';
//   List<dynamic> placePredictions = [];
//
//   void searchForPlaces(String input, language) async {
//     if (input.isNotEmpty && input != selectedLocation) {
//       selectedLocation = input;
//       String url =
//           "https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$input&key=AIzaSyBvjoIOOX8uJteEXBRDoYmt_lK2a4tpwok&language=$language";
//       if (initCameraPosition?.target != null && radius != null) {
//         url +=
//         "&location=${initCameraPosition?.target.latitude},${initCameraPosition?.target.longitude}&radius=$radius";
//       }
//       final response = await http.get(Uri.parse(url));
//       final json = jsonDecode(response.body);
//
//       if (json["error_message"] != null) {
//         var error = json["error_message"];
//         if (error == "This API project is not authorized to use this API.")
//           error += " Make sure the Places API is activated on your Google Cloud Platform";
//         throw Exception(error);
//       } else {
//         final predictions = json["predictions"];
//         placePredictions = predictions;
//         print('huhuhuhuhuhuhuhuhuhu ${placePredictions.first}');
//         // destinationLocation = LatLng(latitude, longitude);
//
//         notifyListeners();
//         print(placePredictions);
//       }
//     } else {
//       placePredictions = [];
//       notifyListeners();
//     }
//   }
//
//   bool showConfirmDestination = false;
//
//   Future selectPlaceFromSuggestion({required String input, index,required BuildContext context, media, scaffoldKey}) async {
//     print('inputinputinput ${input}');
//     try {
//       selectedLocation = input;
//       placePredictions.clear();
//       geocoding.locationFromAddress(input).then((res) async {
//         print('inputinputinputresreslatitude ${res[0].latitude}');
//         print('inputinputinputresreslongitude ${res[0].longitude}');
//
//         // Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
//         // debugPrint('location: ${position.latitude}');
//
//         var addressesCountryForCurrentLocation = await geocoding.placemarkFromCoordinates(
//             currentUserLocation?.latitude??0.0, currentUserLocation?.longitude??0.0);
//         var firstForCurrentLocation = addressesCountryForCurrentLocation.first;
//
//         var addressesCountryFromSuggestions =
//         await geocoding.placemarkFromCoordinates(res[0].latitude, res[0].longitude);
//         var firstFromSuggestions = addressesCountryFromSuggestions.first;
//
//         if (firstFromSuggestions.country == firstForCurrentLocation.country) {
//           showConfirmDestination = true;
//           _destinationLocationModel = DestinationEntity(
//             destinationName: input,
//             latLng: LatLng(res[0].latitude, res[0].longitude),
//           );
//           destinationLocation = LatLng(res[0].latitude, res[0].longitude);
//           print('destinationLocationdestinationLocation ${destinationLocation}');
//
//           // mapViewController.animateCamera(CameraUpdate.newCameraPosition(
//           //     CameraPosition(
//           //         target: LatLng(res[0].latitude, res[0].longitude),
//           //         bearing: userLocationModel.cameraView,
//           //         zoom: _zoomCamera-4,
//           //         tilt: _tiltCamera)));
//           _zoomCamera = 10;
//           initCameraPosition = CameraPosition(
//               target: LatLng(res[0].latitude, res[0].longitude),
//               // bearing: userLocationModel.cameraView,
//               zoom: _zoomCamera,
//               tilt: _tiltCamera);
//           isDestinationSelected = true;
//           setDestinationMarker();
//           drawPolyLine(context);
//           //TODO open ChooseCar screen
//           // Get.to(() => ChooseCar());
//         } else {
//           print('outttttttttttttttt');
//           // Fluttertoast.showToast(
//           //   msg: "خارج النطاق",
//           //   gravity: ToastGravity.CENTER,
//           //   timeInSecForIosWeb: 4,
//           //   backgroundColor: Theme.of(context).primaryColor,
//           //   textColor: Colors.white,
//           //   fontSize: 16.0,
//           // );
//
//
//         }
//       });
//     } catch (e) {
//       print(e);
//     }
//     notifyListeners();
//   }
//
//   Future resetDestinationLocation() async {
//     isDestinationSelected = false;
//     _destinationLocationModel = DestinationEntity();
//     mapMarkers.clear();
//
//     destinationMarker = null;
//     mapViewController?.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
//         target: LatLng(currentUserLocation?.latitude??0.0, currentUserLocation?.longitude??0.0),
//         bearing: userLocationModel?.cameraView??20,
//         zoom: _zoomCamera,
//         tilt: _tiltCamera)));
//     if (showConfirmDestination == true) {
//       showConfirmDestination = false;
//     }
//     // if (tripPolyLines.isNotEmpty) {
//
//     homeMapControllerCircles.clear();
//     tripPolyLines.clear();
//     polyLineCoordinates.clear();
//     setUserMarker();
//     print("pollllllllllll111 $polyLineCoordinates");
//     print("pollllllllllll222 $tripPolyLines");
//     // }
//     notifyListeners();
//   }
//
//   void showSnack({
//     msg,
//   required  BuildContext context,
//     var scaffoldKey,
//     fullHeight,
//     marginBottom,
//     isFloating = false,
//     required  Color color,
//   }) {
//     var snackBar = SnackBar(
//       behavior: isFloating ? SnackBarBehavior.floating : SnackBarBehavior.fixed,
//       backgroundColor: color ?? const Color(0xffff1e1e).withOpacity(0.7),
//       margin: EdgeInsets.fromLTRB(4, 0, 4, marginBottom ?? 5),
//       content: SizedBox(
//         height: fullHeight ?? 89,
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Center(
//                 child: Text(
//               "$msg",
//               style: const TextStyle(
//                   color: Colors.white,
//                   fontWeight: FontWeight.w800,
//                   fontFamily: "Almarai-Bold"),
//               maxLines: null,
//             )),
//             fullHeight == null
//                 ? const SizedBox(
//                     height: 60.0,
//                   )
//                 : const SizedBox()
//           ],
//         ),
//       ),
//     );
//
//     scaffoldKey.currentState.showSnackBar(snackBar);
//   }
//
//
// }
