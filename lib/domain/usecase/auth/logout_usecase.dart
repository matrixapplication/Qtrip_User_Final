

import 'package:q_trip_user/data/model/base/base_model.dart';

import '../../../data/model/base/response_model.dart';
import '../../../data/model/response/user_model.dart';
import '../../repository/auth_repo.dart';
import '../base_usecase/base_use_case_call.dart';
import '../base_usecase/base_usecase.dart';


class LogoutUseCase implements BaseUseCase<UserModel>{


  final AuthRepository repository;

  LogoutUseCase({required this.repository});

  Future<ResponseModel> call() async {
    return BaseUseCaseCall.onGetData<UserModel>( await repository.logout(), onConvert);
  }



  @override
  ResponseModel<UserModel> onConvert(BaseModel baseModel) {
    return ResponseModel(true, baseModel.message);
  }


}
