//
//
// import 'dart:async';
//
// import 'package:driver/data/response/trip_model.dart';
// import 'package:driver/domain/entities/trip_entity.dart';
// import 'package:driver/domain/repository/trip_repo.dart';
// import 'package:firebase_database/firebase_database.dart';
//
// class GetVehiclesUseCase  {
//
//   final TripRepository repository;
//
//   GetVehiclesUseCase({required this.repository});
//
//   // StreamSubscription<DatabaseEvent>call() => repository.getMyLiveTrips();
//   Stream<TripEntity?>call()async* {
//     TripEntity? entity;
//     Stream<DatabaseEvent> stream = repository.getMyLiveTrips();
//     stream.listen((event) {
//       for(var snapshot in event.snapshot.children){
//         if (snapshot.child('user_id').value.toString() ==/* kUser?.id.toString()*/'177' && snapshot.child('trip_id').exists && snapshot.child('trip_id').value != null) {
//           entity = TripModel.fromJson(snapshot)
//           break;
//         }
//       }
//     });
//     return entity;
//   }
//
//
// }
//
//
