
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:equatable/equatable.dart';

class AddressEntity extends Equatable{
  final int _id;
  final String _name;
  final String _address;
  final LatLng _location;
  final String _addressType;

  const AddressEntity({
    required int id,
    required String name,
    required String address,
    required LatLng location,
    required String addressType,
  })  : _id = id,
        _name = name,
        _address = address,
        _location = location,
        _addressType = addressType;

  @override
  List<Object> get props => [_id, _name, _address, _location,_addressType];

  String get addressType => _addressType;

  LatLng get location => _location;

  String get address => _address;

  String get name => _name;

  int get id => _id;
}
