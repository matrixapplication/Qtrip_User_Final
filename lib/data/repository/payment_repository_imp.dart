import 'dart:async';
import 'package:dio/dio.dart';
import '../../../domain/repository/payment_repo.dart';
import '../app_urls/app_url.dart';
import '../datasource/remote/dio/dio_client.dart';
import '../datasource/remote/exception/api_error_handler.dart';
import '../model/base/api_response.dart';



class PaymentRepositoryImp implements PaymentRepository {

  final DioClient _dioClient;

  PaymentRepositoryImp({required DioClient dioClient}) : _dioClient = dioClient;



  @override
  Future<ApiResponse> checkPromoCode({required String promoCode}) async {
    try {
      Response response = await _dioClient.post(AppURL.kCheckPromoCodeURL ,queryParameters: {'promo_code':promoCode});
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  @override
  Future<ApiResponse> getValidPromoCode() async {
    try {
      Response response = await _dioClient.get(AppURL.kGetValidPromoCodeURL);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }




}
