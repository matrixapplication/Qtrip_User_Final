
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DestinationEntity{
  final String? _destinationName;
  final LatLng? _latLng;

  DestinationEntity({
     String? destinationName,
     LatLng? latLng,
  })  : _destinationName = destinationName,
        _latLng = latLng;


  LatLng? get latLng => _latLng;

  String? get destinationName => _destinationName;
}
