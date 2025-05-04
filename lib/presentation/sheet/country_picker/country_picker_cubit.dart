import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

import '../../../data/model/base/response_model.dart';
import '../../../domain/entities/country_entity.dart';
import '../../../domain/logger.dart';

import 'dart:async';

import 'package:flutter/material.dart';

import '../../../data/datasource/remote/exception/error_widget.dart';
import '../../../domain/usecase/setting/get_country_usecase.dart';

part 'country_picker_state.dart';

class CountryPickerCubit extends Cubit<CountryPickerState> {
  final _tag = 'CountryPickerCubit';

  final GetCountriesUseCase _getCountriesUseCase;


  CountryPickerCubit({
    required GetCountriesUseCase getCountriesUseCase,
  }) : _getCountriesUseCase = getCountriesUseCase , super(CountryPickerInitial());




  ///variables
  ResponseModel<List<CountryEntity>>? _responseModel;
  CountryEntity? _selected;
  List<CountryEntity>? _selectedList = [];
  ErrorModel? _error;

  ///getters
  ErrorModel? get error => _error;
  ResponseModel<List<CountryEntity>>? get responseModel => _responseModel;
  CountryEntity? get selected => _selected;
  List<CountryEntity>? get selectedList => _selectedList;


  Future<void> getList(BuildContext context, bool reload) async {
    if((_responseModel?.data ??[]).isNotEmpty)return;
    if (reload) {emit( CountryPickerInitial());}
    if (_responseModel?.data!=null) {return;}

    _responseModel = await _getCountriesUseCase.call();

    emit( CountryPickerInitial());
  }

  void onItemChecked({required bool isChecked, required CountryEntity selectedItem}) {
    log(_tag, 'onItemChecked: isChecked= $isChecked id= $selectedItem');
    if (isChecked) {
      log(_tag, 'onItemChecked: add');_selectedList!.add(selectedItem);
    } else {
      log(_tag, 'onItemChecked: remove');_selectedList!.removeWhere((item) => item.id == selectedItem.id);
    }
    _selectedList = [..._selectedList!];
    emit( CountryPickerInitial());
  }

  void onSelected(CountryEntity value) {
    log(_tag, 'onSelected: $value');

    _selected = value;
    emit( CountryPickerInitial());
  }


}
