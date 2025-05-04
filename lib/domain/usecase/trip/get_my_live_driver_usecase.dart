

import 'dart:async';
import 'package:firebase_database/firebase_database.dart';

import '../../repository/trip_repo.dart';

class GetMyLiveDriverUseCase  {

  final TripRepository _repository;

  const GetMyLiveDriverUseCase({
    required TripRepository repository,
  }) : _repository = repository;

  Stream<DatabaseEvent> call(String driverId) => _repository.getMyLiveDriver(driverId: driverId);

}


