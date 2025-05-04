

import 'dart:async';
import 'package:firebase_database/firebase_database.dart';

import '../../repository/trip_repo.dart';

class GeMyOffersTripUseCase  {

  final TripRepository _repository;

  const GeMyOffersTripUseCase({
    required TripRepository repository,
  }) : _repository = repository;

  Stream<DatabaseEvent> call(String tripId) => _repository.getMyOffersTrip(tripId: tripId);

}


