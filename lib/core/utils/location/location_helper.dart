import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:geolocator/geolocator.dart' as geo;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as loc;
import 'package:permission_handler/permission_handler.dart' as perm;
import 'package:q_trip_user/domain/logger.dart';
import 'package:http/http.dart' as http;

class LocationHelper {
  final _tag = 'LocationHelper';

  final loc.Location _location = loc.Location();
  loc.LocationData? locationData;
  bool _serviceEnabled = false;
  perm.PermissionStatus? _permissionGranted;

  bool get serviceEnabled => _serviceEnabled;
  perm.PermissionStatus? get permissionGranted => _permissionGranted;

  Future<bool> _checkPermission() async {
    _serviceEnabled = await _location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await _location.requestService();
      if (!_serviceEnabled) return false;
    }

    perm.PermissionStatus status = await perm.Permission.location.status;
    if (!status.isGranted) {
      status = await perm.Permission.location.request();
      if (!status.isGranted) return false;
    }

    _permissionGranted = status;
    return true;
  }

  Future<bool> checkGps() async {
    return await geo.Geolocator.isLocationServiceEnabled();
  }

  Future<geo.LocationPermission> checkLocationPermission() async {
    return await geo.Geolocator.requestPermission();
  }

  Future<LatLng?> gpsLastLocation() async {
    log(_tag, 'gpsLastLocation Start');
    bool hasPermission = await _checkPermission();
    log(_tag, 'gpsLastLocation _checkPermission: $hasPermission');

    if (!hasPermission) return null;

    try {
      await checkGps();
      geo.Position currentLocation = await geo.Geolocator.getCurrentPosition();
      return LatLng(currentLocation.latitude, currentLocation.longitude);
    } catch (e) {
      log(_tag, 'getCurrentUserLocation Error => $e');
      await checkLocationPermission();
      return null;
    }
  }

  Future<void> gpsChangeStream(Function(loc.LocationData) updateLocation) async {
    log(_tag, 'gpsChangeStream');
    bool hasPermission = await _checkPermission();

    if (hasPermission) {
      _getLiveLocation(updateLocation);
    } else {
      log(_tag, 'gpsChangeStream:: Permission denied');
    }
  }

  void _getLiveLocation(Function(loc.LocationData) updateLocation) {
    log(_tag, '_getLiveLocation start');

    _location.enableBackgroundMode(enable: true);
    _location.onLocationChanged.listen((loc.LocationData newData) {
      if (_serviceEnabled || _permissionGranted == perm.PermissionStatus.granted) {
        locationData = newData;
        updateLocation(newData);
      }
    });
  }

  int calculateDistance(LatLng from, LatLng to) {
    double lat1 = from.latitude;
    double lon1 = from.longitude;
    double lat2 = to.latitude;
    double lon2 = to.longitude;

    var p = 0.017453292519943295;
    var a = 0.5 -
        cos((lat2 - lat1) * p) / 2 +
        cos(lat1 * p) * cos(lat2 * p) * (1 - cos((lon2 - lon1) * p)) / 2;
    double distance = 12742 * asin(sqrt(a));
    return distance.round();
  }

  int calculateDuration(LatLng from, LatLng to) {
    return calculateDistance(from, to); // Assuming 1km = 1min approx (dummy logic)
  }

  Future<Map<String, dynamic>?> getRouteInfo(LatLng from, LatLng to) async {
    final url =
        'https://router.project-osrm.org/route/v1/driving/${from.longitude},${from.latitude};${to.longitude},${to.latitude}?overview=false';
    print('url: $url');

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['routes'] != null && data['routes'].isNotEmpty) {
        final route = data['routes'][0];
        return {
          'distance': route['distance'],
          'duration': route['duration'],
        };
      }
    } else {
      print('Error: ${response.statusCode}');
    }

    return null;
  }
}
