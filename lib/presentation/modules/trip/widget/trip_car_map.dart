
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../core/utils/map_style.dart';
import '../../../component/custom_loading_spinner.dart';
import '../../home/home_cubit.dart';
import '../trip_cubit.dart';


class TripCarMap extends StatefulWidget {
  const TripCarMap({Key? key}) : super(key: key);

  @override
  _TripCarMapState createState() => _TripCarMapState();
}

class _TripCarMapState extends State<TripCarMap> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  CameraPosition?  _currentCameraPosition;
  @override
  void initState() {
    super.initState();
    BlocProvider.of<HomeCubit>(context, listen: false).initGoogleMap();
    _currentCameraPosition =  BlocProvider.of<HomeCubit>(context, listen: false).currentCameraPosition;
  }

  @override
  Widget build(BuildContext context) {
    var viewModel = BlocProvider.of<TripCubit>(context, listen: true);
    var mapMarkers = context.watch<TripCubit>().mapMarkers;
    var tripPolyLines = context.watch<TripCubit>().state.usedTripPolyLines;
    return Scaffold(
      key: _scaffoldKey,
      body:  _currentCameraPosition == null
          ? const CustomLoadingSpinner()
          : GoogleMap(
              myLocationEnabled: true,
              compassEnabled: false,
              myLocationButtonEnabled: false,
              mapToolbarEnabled: false,
              rotateGesturesEnabled: false,
              buildingsEnabled: true,
              mapType: MapType.normal,

              markers: mapMarkers,
              polylines: tripPolyLines,
              zoomGesturesEnabled: true,
              zoomControlsEnabled: false,
              // padding: EdgeInsets.only(bottom: (deviceHeight/3)+16),
              initialCameraPosition: _currentCameraPosition!,
              onMapCreated: (GoogleMapController controller) async {
                viewModel.setMapController(controller);
                // controller.setMapStyle(mapStyle);
                // await controller.setMapStyle(await DefaultAssetBundle.of(context).loadString('assets/json/map_style_light.json'),);
              },
            ),
    );
  }
}
