

import 'package:q_trip_user/data/model/base/base_model.dart';
import 'package:q_trip_user/domain/entities/user_entity.dart';

import '../../../data/datasource/remote/exception/api_checker.dart';
import '../../../data/model/base/response_model.dart';
import '../../../data/model/response/user_model.dart';
import '../../repository/auth_repo.dart';
import '../../request_body/login_body.dart';
import '../base_usecase/base_use_case_call.dart';
import '../base_usecase/base_usecase.dart';


class SignInUseCase implements BaseUseCase<UserEntity>{


  final AuthRepository repository;

  SignInUseCase({required this.repository});

  Future<ResponseModel> call({ required LoginBody loginBody}) async {
    return BaseUseCaseCall.onGetData<UserEntity>( await repository.login(loginBody: loginBody), onConvert,tag: 'SignInUseCase');
  }

  @override
  ResponseModel<UserEntity> onConvert(BaseModel baseModel) {
    try{
      String? token = baseModel.responseData['token'];
      if (token != null) {
        UserEntity? user = UserModel.fromJson(baseModel.responseData);
        return ResponseModel(true, baseModel.message, data: user);
      } else {
        return ResponseModel(true, baseModel.message,data: baseModel.responseData);
      }
    }catch(e){
      return ResponseModel(true, baseModel.message,data: baseModel.responseData);
    }
  }
}
