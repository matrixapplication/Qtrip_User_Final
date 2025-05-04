import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:q_trip_user/core/routing/navigation_services.dart';
import 'package:q_trip_user/core/routing/routes.dart';
import 'package:q_trip_user/core/utils/globals.dart';



class TripHelper{

 static final DatabaseReference  _reference =FirebaseDatabase.instance.ref().child('trips');

  static  checkMyTrip() async {
     StreamSubscription<DatabaseEvent>? streamSubscription ;
     streamSubscription = _reference.onValue.listen((event) {
      for(var snapshot in event.snapshot.children){

        if (snapshot.child('user_id').value.toString() == (kUser?.id??'177').toString() && snapshot.child('trip_id').exists && snapshot.child('trip_id').value != null) {
          streamSubscription?.cancel();
          NavigationService.push(Routes.driverTripScreen, arguments: {'tripId': snapshot.child('trip_id').value.toString()});
          return;
        }
      }
    });
  }
 // static  checkTrip(String tripId) async {
 //   StreamSubscription<DatabaseEvent>? streamSubscription ;
 //   streamSubscription = _reference.child(tripId).onValue.listen((event) {
 //      if(!event.snapshot.exists){
 //        NavigationService.pushNamedAndRemoveUntil(RoutesDriver.driverHomeScreen);
 //        streamSubscription?.cancel();
 //      }
 //   });
 // }

  // StreamSubscription<DatabaseEvent>? _streamSubscription ;
  // StreamController<TripEntity?> controller = StreamController<TripEntity?>();

 // Stream<DatabaseEvent> getTrip(String tripId)  =>_reference.child(tripId).onValue;
 //
 //
 //
 // Stream<TripEntity?> getTrip1(String tripId) async* {
 //   _streamSubscription = _reference.child(tripId).onValue.listen((event) {    controller.add(TripModel.fromJson(event.snapshot)) ;});
 // }
}

/*  static Future<TripEntity?> checkTrip() async {
     StreamSubscription<DatabaseEvent>? streamSubscription ;


    // /*_streamSubscription = */_reference.onValue.listen((event)async* {
    //   for(var snapshot in event.snapshot.children){
    //     // if (snapshot.child('user_id').value.toString() == kUser?.id.toString() && snapshot.child('trip_id').exists && snapshot.child('trip_id').value != null) {
    //     //   log('TripTripTripTripTripTrip1', '${snapshot.child('user_id').value.toString()}');
    //       log('TripTripTripTripTripTrip2', '${snapshot.child('expected_time').value.toString()}');
    //       // NavigationService.push(RoutesDriver.driverTripScreen, arguments: {'tripId': snapshot.child('trip_id')});
    //       // _streamSubscription?.cancel();
    //     // }
    //   }
    // });

    // log('TripTripTripTripTripTrip2', (kUser?.id??'user id is null').toString());
     streamSubscription = _reference.onValue.listen((event) {
      for(var snapshot in event.snapshot.children){
        if (snapshot.child('user_id').value.toString() == (kUser?.id??'173').toString() && snapshot.child('trip_id').exists && snapshot.child('trip_id').value != null) {
          log('TripHelper', '${snapshot.child('user_id').value.toString()}');
          NavigationService.push(RoutesDriver.driverTripScreen, arguments: {'tripId': snapshot.child('trip_id').value.toString()});
          streamSubscription?.cancel();
          break;
        }
      }
    });
    // _reference.ref.child('distance').onValue..contains(true);
   // final counterSnapshot = await  _reference.get();
   // final counterSnapshot = await  _reference.get().value;
   // _reference.ref.child('distance').get();
   // log('TripTripTripTripTripTrip', '${counterSnapshot.children.firstWhere((element) => element.child('distance')=='21').toString()}');

   // DatabaseEvent? data= await _reference.onValue.firstWhere((element) {
   //   log('TripTripTripTripTripTrip2','${element.snapshot.children.first.child('distance').value.toString()}');
   //   log('TripTripTripTripTripTrip2','${element.snapshot.child('distance').value.toString()}');
   //   return  element.snapshot.child('distance').value.toString()=='distance';
   // });


   //  DatabaseEvent? data= await _reference.onValue.firstWhere((element) => element.snapshot.children.first.child('distance').value.toString()=='1232131');
   //
   // log('TripTripTripTripTripTrip0','${data.snapshot.children.first.child('distance').value.toString()}');
   // log('TripTripTripTripTripTrip0','${data.snapshot.child('expected_time').value}');



    //
    // _reference.onValue.listen((event) {
    //   for(var snapshot in event.snapshot.children){
    //
    //     log('TripTripTripTripTripTrip2', '${snapshot.child('expected_time').value.toString()}');
    //   }
    // });


    // _streamSubscription = _reference.onValue.listen((event) async* {
    //   log('TripTripTripTripTripTrip2', '${event.snapshot.children.first.child('distance').value.toString()}');
    //
    //   var snapshot = event.snapshot.children.firstWhere((snapshot) => snapshot.child('distance').value.toString() == '123123');
    //   if (snapshot.exists) {
    //     // TripModel.fromJson(snapshot.children.first.value);
    //     log('TripTripTripTripTripTrip2', '${snapshot.children.first.child('distance').value.toString()}');
    //     // _streamSubscription?.cancel();
    //   } else {
    //     log('TripTripTripTripTripTrip2', 'null null null');
    //   }
    //
    // });
    return null;

   //  _reference.onValue.listen((event) {
   //  log('TripTripTripTripTripTrip2', '${event.snapshot.children.first.child('distance').value.toString()}');
   //
   //  var snapshot= event.snapshot.children.firstWhere((snapshot) => snapshot.child('distance').value.toString() == '123123');
   //  if(snapshot.exists){
   //    // TripModel.fromJson(snapshot.children.first.value);
   //    log('TripTripTripTripTripTrip2', '${snapshot.children.first.child('distance').value.toString()}');
   //  }else{
   //    log('TripTripTripTripTripTrip2', 'null null null');
   //  }
   // });



    // _reference.get().asStream().listen((event) {
    //   event.children.
    // });
    // _reference.onValue.listen(
    //   (DatabaseEvent event) {
    //     final data = event.snapshot.value;
    //     log('TripTripTripTripTripTrip', data.toString());
    //     // event.snapshot.value
    //     // _error = null;
    //     // _counter = (event.snapshot.value ?? 0) as int;
    //   },
    //   onError: (Object o) {
    //     // final error = o as FirebaseException;
    //     // setState(() {
    //     //   _error = error;
    //     // });
    //   },
    // );

    // print(
    //   'Connected to directly configured database and read ''${counterSnapshot.value}',
    // );
  }
*/