

import 'package:q_trip_user/data/model/base/base_model.dart';
import 'package:q_trip_user/domain/entities/user_entity.dart';
import 'package:q_trip_user/domain/request_body/register_body.dart';

import '../../../data/datasource/remote/exception/api_checker.dart';
import '../../../data/model/base/response_model.dart';
import '../../../data/model/response/user_model.dart';
import '../../repository/auth_repo.dart';
import '../base_usecase/base_use_case_call.dart';
import '../base_usecase/base_usecase.dart';


class RegisterUseCase implements BaseUseCase{


  final AuthRepository repository;

  RegisterUseCase({required this.repository});

  Future<ResponseModel> call({ required RegisterBody body}) async {
    return BaseUseCaseCall.onGetData( await repository.register(registerBody: body), onConvert,tag: 'RegisterUseCase');
  }


  @override
  ResponseModel onConvert(BaseModel baseModel) {
    return ResponseModel(true, baseModel.message,data: baseModel.responseData);

  }


}
