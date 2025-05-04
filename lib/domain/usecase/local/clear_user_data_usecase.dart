import 'package:q_trip_user/data/model/base/response_model.dart';

import '../../repository/local_repo.dart';





class ClearUserDataUseCase {
  // final _tag = 'UserSubCategoriesViewModel';
  final LocalRepository repository;

  ClearUserDataUseCase({required this.repository});

  Future<ResponseModel> call() async {
    bool isCleared = await repository.clearSharedData();

    if (isCleared) {
      return ResponseModel(true, 'successful');
    } else {
      return ResponseModel(false, 'error');
    }
  }
}
