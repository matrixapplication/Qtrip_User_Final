
import 'dart:async';
import 'package:dio/dio.dart';
import '../../domain/repository/getsocialmedia_repo.dart';
import '../app_urls/app_url.dart';
import '../datasource/remote/dio/dio_client.dart';
import '../datasource/remote/exception/api_error_handler.dart';
import '../model/base/api_response.dart';

class GetSocialMediaRepositoryImp implements GetSocialMediaRepository{
  final DioClient _dioClient;
  const GetSocialMediaRepositoryImp({
    required DioClient dioClient,
  })  : _dioClient = dioClient;

  @override
  Future<ApiResponse> getGetSocialMedia() async{
    try {
      Response response = await _dioClient.get(
        AppURL.GetSocialMediasUrl,
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}

      