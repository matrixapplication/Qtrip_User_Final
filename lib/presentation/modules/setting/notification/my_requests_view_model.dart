/*

import 'package:flutter/material.dart';

import '../../../../data/model/base/response_model.dart';

class MyRequestsViewModel extends ChangeNotifier {
  final GetMyRequestsUseCase _getMyRequestsUseCase;

  MyRequestsViewModel({
    required GetMyRequestsUseCase getMyRequestsUseCase,
  }) : _getMyRequestsUseCase = getMyRequestsUseCase;


  ///variables
  bool _isLoadRequestList = true;
  ResponseModel<RequestListModel>? _responseModel;
  int _currentPage=0;
  ///getters
  bool get isLoadRequestList => _isLoadRequestList;
  ResponseModel<RequestListModel>? get responseModel => _responseModel;


  ///colling api functions
  //get requests list
  getRequests({bool reload = false, bool isLoadMore = false}) async {
    _isLoadRequestList = true;

    if (reload) {_responseModel = null;_currentPage = 1;notifyListeners();}
    else if (!isLoadMore) {_responseModel = null;}
    else {_currentPage = _currentPage + 1;}

    ResponseModel<RequestListModel> responseModel = await _getMyRequestsUseCase.call(currentPage: currentPage);

    if (isLoadMore && _responseModel != null) {
      _responseModel?.data?.list.addAll(responseModel.data?.list ?? []);
    } else {
      _responseModel = responseModel;
    }

    _isLoadRequestList = false;
    notifyListeners();
  }



}
*/
