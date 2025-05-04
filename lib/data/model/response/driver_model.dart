import 'package:firebase_database/firebase_database.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../domain/entities/driver_entity.dart';



class DriverModel extends DriverEntity{

  const DriverModel({
    required int id,
    required String name,
    required String image,
    required String mobile,
    required LatLng location,
  }) : super(
    id: id,
    name: name,
    image: image,
    mobile: mobile,
    location: location,
  );




  factory DriverModel.fromJson(DataSnapshot snapshot) => DriverModel(
    id: (num.parse((snapshot.child("id").value ?? '0').toString())).toInt(),
    name: (snapshot.child("name").value??'').toString() ,
    image: (snapshot.child("image").value??'').toString() ,
    mobile: (snapshot.child("mobile_number").value??'').toString() ,
    location: LatLng(
        num.parse((snapshot.child("lat").value ?? '0').toString()).toDouble(),
        num.parse((snapshot.child("lng").value ?? '0').toString()).toDouble()),



  );
}
