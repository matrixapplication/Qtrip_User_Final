import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../core/utils/map_style.dart';
import '../../../component/custom_loading_spinner.dart';
import '../home_cubit.dart';


class HomeMap extends StatefulWidget {
  const HomeMap({Key? key}) : super(key: key);

  @override
  _HomeMapState createState() => _HomeMapState();
}

class _HomeMapState extends State<HomeMap> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    BlocProvider.of<HomeCubit>(context, listen: false).initGoogleMap();
  }

  @override
  Widget build(BuildContext context) {
    var viewModel = BlocProvider.of<HomeCubit>(context, listen: true);
    var currentCameraPosition = context.watch<HomeCubit>().currentCameraPosition;
    var mapControllerStage = context.watch<HomeCubit>().mapControllerStage;

    return Scaffold(
      key: _scaffoldKey,
      body: mapControllerStage == MapControllerStage.loading || currentCameraPosition == null
          ? const CustomLoadingSpinner()
          : GoogleMap(
              myLocationEnabled: true,
              compassEnabled: false,
              myLocationButtonEnabled: false,
              mapToolbarEnabled: false,
              rotateGesturesEnabled: false,
              buildingsEnabled: true,
              mapType: MapType.terrain,
              zoomGesturesEnabled: true,
              zoomControlsEnabled: false,
              padding: const EdgeInsets.symmetric(vertical: 100),
              initialCameraPosition: currentCameraPosition!,
              onMapCreated: (GoogleMapController controller) async {
                viewModel.setMapController(controller);
                if (viewModel.currentUserLocation == null) {viewModel.getCurrentUserLocation();}
                controller.setMapStyle(mapStyle);
                await controller.setMapStyle(await DefaultAssetBundle.of(context).loadString('assets/json/map_style_light.json',),);
              },
            ),
    );
    // });
  }
}
