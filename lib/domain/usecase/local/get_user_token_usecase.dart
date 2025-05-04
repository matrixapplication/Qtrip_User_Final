
import 'package:q_trip_user/data/model/base/response_model.dart';

import '../../repository/local_repo.dart';

class GetUserTokenUseCase {
  // final _tag = 'GetUserTokenDataUseCase';
  final LocalRepository repository;

  GetUserTokenUseCase({required this.repository});

  Future<ResponseModel> call() async {
    String token =await repository.getUserToken();

    if (token.isNotEmpty) {
      return ResponseModel(true, 'successful', data: token);
    } else {
      return ResponseModel(false, 'error');
    }
  }
}
