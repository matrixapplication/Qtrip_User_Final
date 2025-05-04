
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../core/utils/map_style.dart';
import '../../../component/custom_loading_spinner.dart';
import '../../home/home_cubit.dart';
import '../select_car_cubit.dart';

class SelectCarMap extends StatefulWidget {
  const SelectCarMap({Key? key}) : super(key: key);

  @override
  _SelectCarMapState createState() => _SelectCarMapState();
}

class _SelectCarMapState extends State<SelectCarMap> {
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
    var viewModel = BlocProvider.of<SelectCarCubit>(context, listen: true);
    var mapMarkers = context.watch<SelectCarCubit>().mapMarkers;
    var tripPolyLines = context.watch<SelectCarCubit>().tripPolyLines;
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
              padding: const EdgeInsets.symmetric(vertical: 40),
              initialCameraPosition: _currentCameraPosition!,
              onMapCreated: (GoogleMapController controller) async {
                viewModel.setMapController(controller);
                controller.setMapStyle(mapStyle);
                await controller.setMapStyle(await DefaultAssetBundle.of(context).loadString('assets/json/map_style_light.json'),);
              },
            ),
    );
  }
}
