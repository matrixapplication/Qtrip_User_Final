import 'package:firebase_database/firebase_database.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:q_trip_user/core/utils/globals.dart';

import '../../../domain/logger.dart';


class UpdateLastLocationHelper{
  final _tag = 'UpdateLastLocationHelper';
   // final _deliveryStatus = FirebaseDatabase.instance.ref().child('Driver').child('${kUser?.id}');
 late DatabaseReference _deliveryStatus;

  UpdateLastLocationHelper(int? userId){
    _deliveryStatus =  FirebaseDatabase.instance.ref().child('drivers').child('$userId');
  }

  updateLocation(LocationData? locationData,bool online,String status ){
    log(_tag, 'lat location ${locationData?.latitude},${locationData?.longitude}');
    _deliveryStatus.update({
      'lat':locationData?.latitude,
      'lng':locationData?.longitude,
      'online':online,
      'status':status,
      'last_update':DateTime.now().toString(),
    });
  }


  streamUpdateLocation(){}



/*  deliveryStatus.onValue.listen((event) {
    final update = event.snapshot.value;
    if (update != null) {
      int status = int.parse(update["Status"].toString());
      switch (status)
      {
        case 1:
          {
            StaticData.connect = DeliveryStatus.DISCONNECTED;
            showDistanceButton = false;
            StaticData.busy=false;
          }
          break;
        case 2:
          {
            StaticData.connect = DeliveryStatus.CONNECTED;
            showDistanceButton = true;
            StaticData.busy=false;

          }
          break;
        case 3:
          {
            StaticData.connect = DeliveryStatus.BLOCKED;
            showDistanceButton = false;
            StaticData.busy=false;

          }
          break;
        case 4:
          {
            StaticData.connect = DeliveryStatus.BUSY;
            showDistanceButton = true;
          }
          break;
      }
        notifyListeners();
    }
  });*/

}