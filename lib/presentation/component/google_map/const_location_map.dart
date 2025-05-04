import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../custom_loading_widget.dart';

class ConstLocationMap extends StatefulWidget {
  final double lat;
  final double long;
  const ConstLocationMap({Key? key, required this.lat, required this.long, }) : super(key: key);

  @override
  State<ConstLocationMap> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<ConstLocationMap> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => false;

  Future<LatLng>? _futurePosition;
  final _mapKey = const PageStorageKey('mapKey');
  Position? position;
  @override
  void initState() {
    super.initState();
    LatLng(widget.lat, widget.long);
    _futurePosition=getPosition();
  }
  Future<LatLng> getPosition ()async{
      return LatLng(widget.lat, widget.long);
    }

  @override
  Widget build(BuildContext context) {
    super.build(context); // Don't forget this line
    return Scaffold(
      body: FutureBuilder<LatLng?>(
        future: _futurePosition,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CustomLoadingWidget();
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final position = snapshot.data!;
            return PageStorage(
              bucket: PageStorageBucket(),
              child: GoogleMap(
                key: _mapKey, // Use PageStorageKey
                onMapCreated: (GoogleMapController controller) {
                },
                initialCameraPosition: CameraPosition(
                  target: LatLng(position.latitude, position.longitude),
                  zoom: 16.0,
                ),
                markers: {
                  Marker(
                    markerId: const MarkerId('markerId'),
                    position: LatLng(position.latitude, position.longitude),
                  ),
                },
              ), // Use PageStorageBucket
            );
          }
        },
      ),
    );
  }
}
