import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import '../../../data/model/base/response_model.dart';
import '../../../domain/request_body/rate_body.dart';
import '../../../domain/usecase/trip/rate_trip_usecase.dart';

part 'rate_state.dart';

class RateSheetCubit extends Cubit<RateState> {



  final RateTripUseCase _rateTripUseCase;



  RateSheetCubit({
    required RateTripUseCase rateTripUseCase,
  }) : _rateTripUseCase = rateTripUseCase,super(RateInitial());


  ///variables
  late RateBody _body ;


  ///getters
  RateBody get body => _body;



  init (String tripId)=>_body = RateBody(tripId: tripId);
  onRateChange(double rate)=>_body.setRate(rate);

  ///call APIs Functions
  Future<ResponseModel> rateTrip({required String notes}) async {
    _body.setNotes(notes);
    emit(RateLoading());
    ResponseModel responseModel =  await _rateTripUseCase.call(rateBody: _body);
    emit(RateInitial());
    return responseModel;
  }
}
