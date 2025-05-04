
import 'package:q_trip_user/data/model/base/response_model.dart';

import '../../repository/local_repo.dart';

class SaveUserDataUseCase {
  // final _tag = 'SaveUserDataUseCase';
  final LocalRepository repository;

  SaveUserDataUseCase({required this.repository});

  Future<ResponseModel> call(
      {required String token}) async {

    bool? isSaveToken = await repository.saveSecuredData(token);

    if (isSaveToken) {
      return ResponseModel(true, 'successful');
    } else {
      return ResponseModel(false, 'error');
    }
  }
}
