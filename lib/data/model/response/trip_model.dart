import 'package:firebase_database/firebase_database.dart';

import '../../../domain/entities/trip_entity.dart';
import 'driver_vehicle_model.dart';


/*

distance:"21"
driver_id:0
drop_address:"V77R+884 "Egypt"
drop_lat:"29.86156089978749"
drop_lng:"31.2886299"
expected_time:"10:46 PM"
pickup_address:"طلبه، عزبة جبريل، البساتين،، عزبة جبريل، البساتين، محافظة القاهرة‬،، X7C8+F2Q, Ezbet Gebreel, El Basatin, Cairo Governorate 4230121, Egypt"
pickup_lat:"29.9711931"
pickup_lng:"31.2652474"
price:"73"
status:"padding"
trip_id:4
user_image:"https://super-app.dev01.matrix-clouds.com/storage/clients/sB5yihfaZ9LiF7gu96U2Jj3Dwli64lCYn3HBBVaC.png"
user_name:"allam"

*/
class TripModel extends TripEntity{
  TripModel({
    required super.distance,
    required super.driverId,
    required super.driverName,
    required super.driverMobile,
    required super.dropAddress,
    required super.dropLat,
    required super.dropLng,
    required super.expectedTime,
    required super.pickupAddress,
    required super.pickupLat,
    required super.pickupLng,
    required super.price,
    required super.userRate,
    required super.status,
    required super.tripId,
    required super.userImage,
    required super.userName,
    required super.driverRate,
     super.paymentMethod,
    required super.vehicle, required super.driverImage, required super.driverAvgYear, required super.driverAvgTrips,

  });



  factory TripModel.fromSnapshot(DataSnapshot snapshot) => TripModel(
    distance: (snapshot.child("distance").value ?? 0).toString(),
    driverId: (snapshot.child("driver_id").value ?? 0).toString(),
    dropAddress: (snapshot.child("drop_address").value?? '').toString() ,
    dropLat: num.parse((snapshot.child("drop_lat").value ?? '0').toString()),
    dropLng: num.parse((snapshot.child("drop_lng").value ?? '0').toString()),
    pickupLat: num.parse((snapshot.child("pickup_lat").value ?? '0').toString()),
    pickupLng: num.parse((snapshot.child("pickup_lng").value ?? '0').toString()),
    expectedTime: (snapshot.child("drop_address").value?? '').toString() ,
    pickupAddress: (snapshot.child("pickup_address").value?? '').toString() ,
    price: (snapshot.child("price").value?? '').toString(),
    status: (snapshot.child("status").value?? '').toString() ,
    tripId: (snapshot.child("trip_id").value?? '').toString(),
    userImage: (snapshot.child("user_image").value?? '').toString() ,
    userName: (snapshot.child("user_name").value?? '').toString() ,
    driverMobile: (snapshot.child("driver_mobile").value?? '').toString() ,
    driverName: (snapshot.child("driver_name").value?? '').toString() ,
    driverRate: (snapshot.child("driver_avg_rate").value?? '0').toString() ,
    vehicle: DriverVehicleModel.fromSnapshot(snapshot.child("car")) ,
    userRate: 0, driverImage: (snapshot.child("driver_image").value?? '').toString(),
    driverAvgYear:(snapshot.child("driver_avg_year").value?? '').toString(),
    driverAvgTrips: (snapshot.child("driver_trip_count").value.toString()?? '').toString(),
    paymentMethod: (snapshot.child("payment_method").value.toString()?? '').toString(),
  );


  factory TripModel.fromJson(Map<String, dynamic> json) => TripModel(
    distance: ( json["distance"] ?? 0).toString(),
    driverId: (json["driver_id"] ?? 0).toString(),
    dropAddress: (json["drop_address"]?? '').toString() ,
    dropLat: double.parse((json["drop_lat"] ?? '0.0').toString()),
    dropLng: double.parse((json["drop_lng"] ?? '0.0').toString()),
    pickupLat: double.parse((json["pickup_lat"] ?? '0.0').toString()),
    pickupLng: double.parse((json["pickup_lng"] ?? '0.0').toString()),
    expectedTime: (json["expected_time"] ?? '').toString(),
    pickupAddress: (json["pickup_address"] ?? '').toString(),
    price: (json["price"] ?? '').toString(),
    status: (json["status"] ?? '').toString(),
    tripId: (json["trip_id"] ?? '').toString(),
    paymentMethod: (json["payment_method"] ?? '').toString(),
    userImage: (json["client_image"] ?? '').toString(),
    userRate: (json["client_rate"] ?? 0),
    userName: (json["user_name"] ?? '').toString(),
    driverName: (json["driver_name"] ?? '').toString(),
    driverMobile: (json["driver_mobile"] ?? '').toString(),
    driverRate: (json["driver_avg_rate"] ?? '0').toString(),
    vehicle: null, driverImage: (json["driver_image"] ?? '').toString(),
      driverAvgYear: (json["driver_avg_year"] ?? '').toString(),
      driverAvgTrips:(json["driver_trip_count"] ?? '').toString(),
  );
}

