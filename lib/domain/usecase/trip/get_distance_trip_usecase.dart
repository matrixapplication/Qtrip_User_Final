

import 'dart:async';
import 'package:firebase_database/firebase_database.dart';

import '../../../data/model/base/base_model.dart';
import '../../../data/model/base/response_model.dart';
import '../../../data/model/response/distance_trip_model.dart';
import '../../entities/trip_entity.dart';
import '../../repository/trip_repo.dart';
import '../base_usecase/base_use_case_call.dart';
import '../base_usecase/base_usecase.dart';


class GetDistanceTripUseCase implements BaseUseCase<DestanceTripModel>{

  final TripRepository _repository;

  const GetDistanceTripUseCase({
    required TripRepository repository,
  }) : _repository = repository;

  Future<ResponseModel<DestanceTripModel>> call({required String tripId ,required String captainId}) async =>
      BaseUseCaseCall.onGetData( await _repository.getDestinationTrip(tripId: tripId, captainId: captainId), onConvert,tag:'GetDistanceTripUseCase' );



  @override
  ResponseModel<DestanceTripModel> onConvert(BaseModel baseModel) {
    try {
      DestanceTripModel? entity = DestanceTripModel.fromJson(baseModel.responseData);
      return ResponseModel(true, baseModel.message, data: entity);
    } catch (e) {
      return ResponseModel(true, baseModel.message);
    }
  }
}



