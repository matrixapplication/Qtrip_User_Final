import 'dart:async';

import 'package:dio/dio.dart';

import '../../domain/repository/notification_repo.dart';
import '../app_urls/app_url.dart';
import '../datasource/remote/dio/dio_client.dart';
import '../datasource/remote/exception/api_error_handler.dart';
import '../model/base/api_response.dart';

class NotificationRepositoryImp implements NotificationRepository{
  final DioClient _dioClient;

  NotificationRepositoryImp({
    required DioClient dioClient,
  })  : _dioClient = dioClient;


  @override
  Future<ApiResponse> getNotifications({int? currentPage })  async {
    try {
      Response response = await _dioClient.get('${AppURL.kGetNotificationsURI}?page=${currentPage??1}');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }



}
