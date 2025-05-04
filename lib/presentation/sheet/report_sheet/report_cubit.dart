import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:q_trip_user/domain/request_body/rate_body.dart';
import 'package:q_trip_user/domain/usecase/trip/rate_trip_usecase.dart';

import '../../../data/model/base/response_model.dart';
import '../../../domain/usecase/trip/report_trip_usecase.dart';

part 'report_state.dart';

class ReportSheetCubit extends Cubit< ReportState> {



  final ReportTripUseCase _reportTripUseCase;



  ReportSheetCubit({
    required ReportTripUseCase reportTripUseCase,
  }) : _reportTripUseCase = reportTripUseCase,super( ReportInitial());


  ///variables
  late RateBody _body ;


  ///getters
  RateBody get body => _body;



  init (String tripId)=>_body = RateBody(tripId: tripId);

  ///call APIs Functions
  Future<ResponseModel> rateTrip({required String report}) async {
    _body.setReport(report);
    emit( ReportLoading());
    ResponseModel responseModel =  await _reportTripUseCase.call(rateBody: _body);
    emit( ReportInitial());
    return responseModel;
  }
}
