import 'dart:async';

import 'package:dio/dio.dart';

import '../../domain/repository/wallet_repo.dart';
import '../app_urls/app_url.dart';
import '../datasource/remote/dio/dio_client.dart';
import '../datasource/remote/exception/api_error_handler.dart';
import '../model/base/api_response.dart';

class WalletRepositoryImp implements WalletRepository{
  final DioClient _dioClient;

  WalletRepositoryImp({
    required DioClient dioClient,
  })  : _dioClient = dioClient;


  @override
  Future<ApiResponse> getWalletHistory({required int currentPage})  async {
    try {
      Response response = await _dioClient.get(AppURL.kGetWalletHistoryURI,queryParameters: {'page':currentPage+1});
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  @override
  Future<ApiResponse> rechargeWallet({required double amount}) async{
    try {
      Response response = await _dioClient.post(AppURL.kRechargeWalletURI,queryParameters:{'amount':amount});
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }



}
