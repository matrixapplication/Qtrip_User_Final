// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:weltweit/generated/assets.dart';
// import 'package:weltweit/presentation/component/component.dart';
// import '../../../../core/map_styles.dart/map_style.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'map_view_model_cubit.dart';
//
// class GeneralMap extends StatefulWidget {
//   const GeneralMap({Key? key}) : super(key: key);
//   @override
//   _GeneralMapState createState() => _GeneralMapState();
// }
//
// class _GeneralMapState extends State<GeneralMap> {
//
//   final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
//
//
//   @override
//   void initState() {
//     super.initState();
//     BlocProvider.of<MapViewModelCubit>(context, listen: false).initGoogleMap();
//     // BlocProvider.of<MapViewModelCubit>(context,listen: false).getCurrentUserLocation();
//   }
//   @override
//   Widget build(BuildContext context) {
//     var viewModel = BlocProvider.of<MapViewModelCubit>(context, listen: true);
//    var currentCameraPosition = context.watch<MapViewModelCubit>().currentCameraPosition;
//    var mapControllerStage = context.watch<MapViewModelCubit>().mapControllerStage;
//    // var mapMarkers = context.watch<MapViewModelCubit>().mapMarkers;
//     // if (_controller != null && initCameraPosition != null) {
//     //   log('GeneralMap', 'moveCamera');
//     //   _controller!.animateCamera(CameraUpdate.newCameraPosition(initCameraPosition));
//     // } else {
//     //   log('GeneralMap', '_controller == $_controller ,initCameraPosition == $initCameraPosition');
//     // }
//
//     return Scaffold(
//         key: _scaffoldKey,
//         body:
//         mapControllerStage == MapControllerStage.loading && currentCameraPosition==null
//           ? const CustomLoadingSpinner()
//           : GoogleMap(
//               myLocationEnabled: true,
//               compassEnabled: false,
//               myLocationButtonEnabled: false,
//               mapToolbarEnabled: false,
//               rotateGesturesEnabled: false,
//               buildingsEnabled: true,
//               // minMaxZoomPreference: MinMaxZoomPreference(12, 20),
//
//               mapType: MapType.normal,
//               zoomGesturesEnabled: true,
//               zoomControlsEnabled: false,
//
//               padding: const EdgeInsets.symmetric(vertical: 40),
//               initialCameraPosition: currentCameraPosition!,
//               // polylines: polyLines,
//               // markers: mapMarkers,
//               // polylines: mapController.tripPolyLines,
//               onMapCreated: (GoogleMapController controller) async {
//
//                 viewModel.getMapController(controller);
//                 if (viewModel.currentUserLocation == null) {
//                   viewModel.getCurrentUserLocation();
//                 }
//                 // mapController.geRealTimeLocation();
//                 controller.setMapStyle(mapStyle);
//
//                 await controller.setMapStyle(
//                   await DefaultAssetBundle.of(context).loadString(
//                     Assets.jsonMapStyleLight,
//                   ),
//                 );
//               },
//               onTap: (locationPosition) async {
//                 // print("><<<<<<<<<<<<<<<<<<<<<");
//                 // if (mapController.isDestinationSelected == false) {
//                 //   print("><<<<<<<<<<<<<<<<<<<<<");
//                 //   mapController.selectDestinationLocationFromMap(destinationPosition: locationPosition,scaffoldKey: _scaffoldKey,context: context);
//                 // }
//               },
//             ),
//     );
//     // });
//   }
// }