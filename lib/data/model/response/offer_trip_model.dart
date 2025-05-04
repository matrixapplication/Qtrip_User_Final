import 'package:firebase_database/firebase_database.dart';

class TripOfferModel{
  final String? driverId;
  final String? driverName;
  final String? driverImage;
  final String? driverRate;
  final String? driverPrice;
  final String? distance;
   String? distanceCaptainUser;
   String? timeCaptainUser;
  final String? time;
  final String? brand;
  final String? model;
  final String? vehicleTypeCategory;
  final String? vehicleTypeName;
  final String? image;
  final String? carNumber;
  final String? colorName;
  final String? colorCode;
  final String? manufacturingYear;

  TripOfferModel({
    this.distanceCaptainUser,
    this.timeCaptainUser,
    this.driverRate,
    this.brand, this.model, this.time,this.vehicleTypeCategory, this.vehicleTypeName, this.image, this.carNumber, this.colorName, this.colorCode, this.manufacturingYear, this.driverId, this.driverName,this.distance, this.driverImage, this.driverPrice});
  factory TripOfferModel.fromSnapshot(DataSnapshot snapshot) => TripOfferModel(
    driverId: (snapshot.child("driver_id").value ?? 0).toString(),
    driverName: (snapshot.child("driver_name").value?? '').toString() ,
    driverImage: (snapshot.child("driver_image").value?? '').toString() ,
    driverPrice: (snapshot.child("driver_price").value?? '').toString() ,
    driverRate: (snapshot.child("driver_avg_rate").value?? '').toString() ,
    distance: (snapshot.child("distance").value?? '').toString() ,
    time: (snapshot.child("expected_time").value?? '').toString() ,
      brand:(snapshot.child("details").child('brand').child('name').value?? '').toString(),
    model:(snapshot.child("details").child('model').child('name').value?? '').toString(),
    vehicleTypeCategory:(snapshot.child("details").child('vehicle_type').child('category').value?? '').toString(),
    vehicleTypeName:(snapshot.child("details").child('vehicle_type').child('name').value?? '').toString(),
    image:(snapshot.child("details").child('images').child('0').child('image').value?? '').toString(),
    carNumber:(snapshot.child("details").child('car_number').value?? '').toString(),
    colorName:(snapshot.child("details").child('color').child('name').value?? '').toString(),
    colorCode:(snapshot.child("details").child('color').child('color').value?? '').toString(),
    manufacturingYear:(snapshot.child("details").child('manufacturing_year').value?? '').toString(),
  );

}