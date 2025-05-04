import 'dart:async';

import 'package:q_trip_user/domain/request_body/profile_body.dart';
import 'package:dio/dio.dart';

import '../../domain/repository/profile_repo.dart';
import '../app_urls/app_url.dart';
import '../datasource/remote/dio/dio_client.dart';
import '../datasource/remote/exception/api_error_handler.dart';
import '../model/base/api_response.dart';

class ProfileRepositoryImp implements ProfileRepository{
  final DioClient _dioClient;


  const ProfileRepositoryImp({
    required DioClient dioClient,
  })  : _dioClient = dioClient;
  @override
  Future<ApiResponse> getProfile() async {
    try {
      Response response = await _dioClient.get(AppURL.kGetProfileURL);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }


  @override
  Future<ApiResponse> updateProfile({required ProfileBody profileBody})  async {
    try {
      Response response = await _dioClient.post(AppURL.kUpdateProfileURL, queryParameters: profileBody.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }


  @override
  Future<ApiResponse> updateProfileImage({required String path})  async {
    try {
      Response response = await _dioClient.post(AppURL.kUpdateProfileImageURL, filePath: path);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
  @override
  Future<ApiResponse> updateStatus()  async {
    try {
      Response response = await _dioClient.post(AppURL.kUpdateProfileStatusURL,
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

}
