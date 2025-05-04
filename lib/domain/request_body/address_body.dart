
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../core/utils/constants.dart';
import '../../data/model/response/drop_down_model.dart';
import '../entities/address_entity.dart';
import '../entities/drop_down_entity.dart';

// class AddressBody {
//   int? id;
//   String? name;
//   String? address;
//   double? latitude;
//   double? longitude;
//
//
//   AddressBody(
//       {this.id,
//       this.name,
//       this.address,
//       this.latitude,
//       this.longitude,
//   });
//   Map<String, dynamic> toJson() => {
//     // "home": home.toJson(),
//     // "work": work.toJson(),
//     // "favorites": List<dynamic>.from(favorites.map((x) => x.toJson())),
//   };
// }

class AddressBody{
  final String? _id;
  final String? _placeId;
  final String _title;
  final String _address;
  final LatLng? _latLng;
  final double _cameraView;
  final List<DropDownEntity> _terms;
  final AddressType _addressType;


  const AddressBody({
    String? id,
    String? placeId,
    required String title,
     LatLng? latLng,
    required String address,
    double cameraView =20,
    List<DropDownEntity>? terms,
    AddressType addressType =AddressType.favorite,
  })  : _title = title,
        _id = id,
        _latLng = latLng,
        _placeId = placeId,
        _terms = terms??const [],
        _cameraView = cameraView,
        _address = address,
        _addressType = addressType;

  double get cameraView => _cameraView;

  String? get placeId => _placeId;
  LatLng? get latLng => _latLng;

  String? get title => _title;
  String? get address => _address;
  String? get id => _id;

   AddressBody copyWith({String? title,String? id,LatLng? latLng,String? placeId}) => AddressBody(
       id: id??null,
       title: title??_title,placeId: placeId??_placeId, latLng: latLng??_latLng, addressType: _addressType, address: _address);

  Map<String, dynamic> toJsonFromGoogle() {
    Map<String, dynamic> data = {};

    //{
    //     "name": _title,
    //     "address":_address,
    //     "lat":_latLng?.longitude,
    //     "lng":_latLng?.longitude,
    //     "address_type":_addressType.name
    //   };

    return data;
  }

  factory AddressBody.fromJsonFromGoogle(Map<String, dynamic> json) =>
      AddressBody(
        title: json["description"] ?? '',
        address: json["description"] ?? '',
        placeId: json["place_id"] ?? '',
        terms: List<DropDownEntity>.from(json["terms"].map((x) => DropDownModel.fromJson(x))),
      );

  //          _list.add(AddressBody(title:  model['description'], address:  model['description'],placeId:model['place_id'] ));
  @override
  String toString() {
    return 'AddressBody{_title: $_title, _latLng: $_latLng, _cameraView: $_cameraView}';
  }
  Map<String, dynamic> toJson() => {
    "id":_id,
    "name": _title,
    "address":_address,
    "lat":_latLng?.latitude,
    "lng":_latLng?.longitude,
    "address_type":_addressType.name
  };

/*  factory AddressesModel.fromJson(Map<String, dynamic> json) => AddressesModel(
    home: AddressModel.fromJson(json["home"]),
    work: AddressModel.fromJson(json["work"]),
    favorites: List<AddressModel>.from(json["favorites"].map((x) => AddressModel.fromJson(x))),
  );*/
 factory AddressBody.setAddress({required AddressEntity entity, AddressType? type}) =>
      AddressBody(
          title: entity.name,
          latLng: entity.location,
          addressType: type??_getAddressType(entity.addressType), address: entity.address);

 static  AddressType _getAddressType(String? type){
    switch(type){

      case 'home':
        return AddressType.home;
      case 'work':
        return AddressType.work;
      case 'favorite':
        return AddressType.favorite;
      default:
        return AddressType.favorite;
    }
  }

  AddressType get addressType => _addressType;
}
