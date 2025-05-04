

import '../../../data/model/base/base_model.dart';
import '../../../data/model/base/response_model.dart';
import '../../../data/model/response/user_model.dart';
import '../../entities/user_entity.dart';
import '../../repository/auth_repo.dart';
import '../../request_body/check_otp_body.dart';
import '../base_usecase/base_use_case_call.dart';
import '../base_usecase/base_usecase.dart';


class CheckOTPUseCase implements BaseUseCase<UserEntity>{


  final AuthRepository repository;
  CheckOTPUseCase({required this.repository});
  Future<ResponseModel> call({ required CheckOTPBody body}) async {
    return BaseUseCaseCall.onGetData<UserEntity>( await repository.otpCode(checkOTPBody: body), onConvert);
  }


  @override
  ResponseModel<UserEntity> onConvert(BaseModel baseModel) {
    UserEntity? user = UserModel.fromJson(baseModel.responseData);

    try{
      String? token = baseModel.responseData['token'];
      if (token != null) {
        return ResponseModel(true, baseModel.message, data: user);
      } else {
        return ResponseModel(true, baseModel.message,data: baseModel.responseData);
      }
    }catch(e){
      return ResponseModel(true, baseModel.message,data: baseModel.responseData);
    }
  }


}
