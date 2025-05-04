import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import '../../../data/datasource/remote/exception/error_widget.dart';
import '../../../data/model/base/response_model.dart';
import '../../../domain/entities/drop_down_entity.dart';
import '../../../domain/usecase/trip/cancel_trip_usecase.dart';
import '../../../domain/usecase/trip/get_cancel_reasons_usecase.dart';


part 'cancel_response_picker_state.dart';

class CancelResponsePickerCubit extends Cubit< CancelResponsePickerState> {


  final tag = 'CancelResponsePickerCubit';
  final CancelTripUseCase _cancelTripUseCase;
  final GetCancelReasonsUseCase _getCancelReasonsUseCase;


  CancelResponsePickerCubit({
    required GetCancelReasonsUseCase getCancelReasonsUseCase,
    required CancelTripUseCase cancelTripUseCase,
  })  : _getCancelReasonsUseCase = getCancelReasonsUseCase,
        _cancelTripUseCase = cancelTripUseCase,
        super(CancelResponsePickerInitial());

  ///variables
  ResponseModel<List<DropDownEntity>>? _responseModel;
  DropDownEntity? _selected;
  List<DropDownEntity>? _selectedList = [];
  ErrorModel? _error;
  late String _tripId;

  ///getters
  ErrorModel? get error => _error;
  ResponseModel<List<DropDownEntity>>? get responseModel => _responseModel;
  DropDownEntity? get selected => _selected;
  List<DropDownEntity>? get selectedList => _selectedList;

  initVieModel(String tripId) {
    _tripId = tripId;
  }

  Future<void> getList(BuildContext context, bool reload) async {
    _responseModel= null;
    if (reload) {emit( CancelResponsePickerInitial());}
    if (_responseModel?.data!=null) {return;}

    _responseModel = await _getCancelReasonsUseCase.call();
    if(_responseModel?.data?.isNotEmpty??false){
      _selected=_responseModel?.data?[0];
    }
    emit( CancelResponsePickerInitial());
  }

  void onItemChecked({required bool isChecked, required DropDownEntity selectedItem}) {
    if (isChecked) {
    } else {
    }
    _selectedList = [..._selectedList!];
    emit( CancelResponsePickerInitial());
  }

  void onSelected(DropDownEntity value) {

    _selected = value;
    emit( CancelResponsePickerInitial());
  }

  Future cancelTrip() async {

    emit( CancelResponsePickerLoading());
    ResponseModel responseModel =await _cancelTripUseCase.call(tripId:_tripId,reasonId: selected?.id??0);
    emit( CancelResponsePickerInitial());
    return responseModel;

  }
}
