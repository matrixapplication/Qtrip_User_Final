import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

Future<void> setZoom(GoogleMapController mapController, bool zoomIn) async {
  double zoom = await mapController.getZoomLevel();
  if (!zoomIn) {
    if (zoom - 1 <= 0) {
      return;
    }
  }

  zoom = zoomIn ? zoom + 1 : zoom - 1;

  final bounds = await mapController.getVisibleRegion();
  final northeast = bounds.northeast;
  final southwest = bounds.southwest;
  final center = LatLng(
    (northeast.latitude + southwest.latitude) / 2,
    (northeast.longitude + southwest.longitude) / 2,
  );
  final cameraUpdate = CameraUpdate.newLatLngZoom(center, zoom);
  await mapController.animateCamera(cameraUpdate);
}

class MapHelper{
 // static Future<Uint8List> getBytesFromAsset(String path, int width) async {
 //   print('asdasdasd path :$path');
 //    ByteData data = await rootBundle.load(path);
 //    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetWidth: width);
 //    ui.FrameInfo fi = await codec.getNextFrame();
 //    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!.buffer.asUint8List();
 //  }
 static Future<Uint8List> getBytesFromAsset(String path, int width) async {
   try {
     print('Loading asset from path: $path');
     ByteData data = await rootBundle.load(path);
     ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetWidth: width);
     ui.FrameInfo fi = await codec.getNextFrame();
     return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!.buffer.asUint8List();
   } catch (e) {
     print('Error loading asset from path: $path. Error: $e');
     rethrow; // or handle the error appropriately
   }
 }


 static LatLngBounds? moveCamera({required LatLng? from ,required LatLng? to}){
   try{
     if(from==null || to==null)return null;

     LatLngBounds latLngBounds;
     if(from.latitude>to.latitude && from.longitude>to.longitude){
       latLngBounds= LatLngBounds(southwest: to, northeast: from);
     }else if(from.longitude>to.longitude ){
       latLngBounds= LatLngBounds(southwest: LatLng(from.latitude,to.longitude), northeast: LatLng(to.latitude,from.longitude));
     }else if(from.latitude>to.latitude){
       latLngBounds= LatLngBounds(southwest: LatLng(to.latitude,from.longitude), northeast: LatLng(from.latitude,to.longitude));
     }else{
       latLngBounds= LatLngBounds(southwest: from, northeast: to);
     }
     return latLngBounds;
   } catch (e) {
     return null;

   }
 }
}