

import 'package:q_trip_user/data/model/base/base_model.dart';
import 'package:q_trip_user/domain/entities/user_entity.dart';

import '../../../data/datasource/remote/exception/api_checker.dart';
import '../../../data/model/base/response_model.dart';
import '../../../data/model/response/user_model.dart';
import '../../repository/auth_repo.dart';
import '../../request_body/login_body.dart';
import '../base_usecase/base_use_case_call.dart';
import '../base_usecase/base_usecase.dart';


class SendOtpUseCase implements BaseUseCase<dynamic>{


  final AuthRepository repository;

  SendOtpUseCase({required this.repository});

  Future<ResponseModel> call({ required String phone}) async {
    return BaseUseCaseCall.onGetData<dynamic>( await repository.sendOtp(phone: phone), onConvert,tag: 'SendOtpUseCase');
  }

  @override
  ResponseModel<dynamic> onConvert(BaseModel baseModel) {
    try{
      if(baseModel.code =='200' ||baseModel.code =='201'){
        return ResponseModel(baseModel.status??true, baseModel.message,data: baseModel.message);
      }else{
        return ResponseModel(baseModel.status??false, baseModel.message,data: baseModel.message);
      }
    }catch(e){
      return ResponseModel(baseModel.status??false, baseModel.message,data: baseModel.message);
    }
  }
}
