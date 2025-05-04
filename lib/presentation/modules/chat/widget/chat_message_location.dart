import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class ChatMessageLocation extends StatefulWidget {
  final LatLng latLng;
  const ChatMessageLocation({Key? key, required this.latLng}) : super(key: key);

  @override
  ChatMessageLocationState createState() => ChatMessageLocationState();
}

class ChatMessageLocationState extends State<ChatMessageLocation> {
  @override
  Widget build(BuildContext context) {
    return   InkWell(
      onDoubleTap: (){
        launch('https://www.google.com/maps/search/?api=1&query=${widget.latLng.latitude},${widget.latLng.longitude}');

      },
      child: SizedBox(
        height: 130,
        child: GoogleMap(
          initialCameraPosition: CameraPosition(
            target: widget.latLng,
            zoom: 14.4746,
          ),
          markers: <Marker>{
            Marker(
              markerId: const MarkerId('1'),
              position: widget.latLng,
            ),
          },
        ),
      ),
    );
  }
}
