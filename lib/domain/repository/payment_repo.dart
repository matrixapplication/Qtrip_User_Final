


import '../../data/model/base/api_response.dart';

abstract class PaymentRepository {

  Future<ApiResponse> getValidPromoCode();
  Future<ApiResponse> checkPromoCode({required String promoCode});

}
