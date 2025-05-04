import 'dart:async';
import 'package:dio/dio.dart';
import 'package:q_trip_user/domain/repository/address_repo.dart';
import 'package:q_trip_user/domain/request_body/address_body.dart';

import '../app_urls/app_url.dart';
import '../datasource/remote/dio/dio_client.dart';
import '../datasource/remote/exception/api_error_handler.dart';
import '../model/base/api_response.dart';


class AddressRepositoryImp implements AddressRepository {
  final DioClient _dioClient;

  AddressRepositoryImp({
    required DioClient dioClient,
  })  : _dioClient = dioClient;


  @override
  Future<ApiResponse> getAddresses()  async {
    try {
      Response response = await _dioClient.get(AppURL.kGetAddressesURL);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }


  @override
  Future<ApiResponse> deleteAddress({required int addressId}) async {
    try {
      print('asdasd ${addressId}');
      Response response = await _dioClient.post(AppURL.kDeleteAddressURL,queryParameters: {'id':addressId});
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  @override
  Future<ApiResponse> storeAddress({required AddressBody body}) async {
    try {
      Response response = await _dioClient.post(AppURL.kStoreAddressURL,queryParameters: body.toJson()/*,data: FormData.fromMap(body.toJson())*/);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  @override
  Future<ApiResponse> updateAddress({required AddressBody body}) async {
    try {
      Response response = await _dioClient.post(AppURL.kUpdateAddressURL,queryParameters: body.toJson()/*,data: FormData.fromMap(body.toJson())*/);

      // Response response = await _dioClient.post(AppURL.kUpdateAddressURL,data: FormData.fromMap(body.toJson()));
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}
