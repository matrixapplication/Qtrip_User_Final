

import '../../data/model/base/api_response.dart';

abstract class WalletRepository {

  Future<ApiResponse> getWalletHistory({required int currentPage});
  Future<ApiResponse> rechargeWallet({required double amount});


}
