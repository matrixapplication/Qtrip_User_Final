import 'dart:async';

import 'package:dio/dio.dart';

import '../../domain/repository/setting_repo.dart';
import '../../domain/request_body/contact_us_request_body.dart';
import '../app_urls/app_url.dart';
import '../datasource/remote/dio/dio_client.dart';
import '../datasource/remote/exception/api_error_handler.dart';
import '../model/base/api_response.dart';

class SettingRepositoryImp implements SettingRepository{
  final DioClient _dioClient;

  SettingRepositoryImp({
    required DioClient dioClient,
  })  : _dioClient = dioClient;

  @override
  Future<ApiResponse> getCities() async {
    try {
      Response response = await _dioClient.get(AppURL.kGetCitiesURL);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  @override
  Future<ApiResponse> getCategories() async {
    try {
      Response response = await _dioClient.get(AppURL.kGetCategoriesURL);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  @override
  Future<ApiResponse> getCountries() async {
    try {
      Response response = await _dioClient.get(AppURL.kGetCountriesURL);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  @override
  Future<ApiResponse> contactUsRequest(ContactUsRequestsBody body)  async {
    try {
      Response response = await _dioClient.post(AppURL.kContactUsRequestURL,queryParameters: body.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }


  @override
  Future<ApiResponse> getFQAs()  async {
    try {
      Response response = await _dioClient.get(AppURL.kGetFAGsURL);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  @override
  Future<ApiResponse> getAbout() async {
    try {
      Response response = await _dioClient.get(AppURL.kGetAboutURL);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  @override
  Future<ApiResponse> getPrivacy() async {
    try {
      Response response = await _dioClient.get(AppURL.kGetPrivacyURL);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  @override
  Future<ApiResponse> getTerms() async {
    try {
      Response response = await _dioClient.get(AppURL.kGetTermsURL);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

}
