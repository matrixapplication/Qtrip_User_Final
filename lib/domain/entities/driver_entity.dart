import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DriverEntity extends Equatable {
  final int _id;
  final String _name;
  final String _mobile;
  final String _image;
  final LatLng _location;

  const DriverEntity({
    required int id,
    required String name,
    required String mobile,
    required String image,
    required LatLng location,
  })  : _id = id,
        _name = name,
        _mobile = mobile,
        _image = image,
        _location = location;

  @override
  List<Object> get props => [
    _id,
    _name,
    _mobile,
    _location,
    _image,
  ];

  int get id => _id;
  String get name => _name;
  String get mobile => _mobile;
  String get image => _image;
  LatLng get location => _location;


}
