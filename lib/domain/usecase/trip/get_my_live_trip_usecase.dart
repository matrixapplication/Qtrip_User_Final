

import 'dart:async';
import 'package:firebase_database/firebase_database.dart';

import '../../repository/trip_repo.dart';

class GetMyLiveTripUseCase  {


  final TripRepository _repository;

  const GetMyLiveTripUseCase({
    required TripRepository repository,
  }) : _repository = repository;

  Stream<DatabaseEvent> call(String tripId) => _repository.getMyLiveTrip(tripId: tripId);


}


