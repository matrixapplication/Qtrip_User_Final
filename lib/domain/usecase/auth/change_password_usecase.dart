

import 'package:q_trip_user/core/utils/alerts.dart';
import 'package:q_trip_user/data/model/base/base_model.dart';

import '../../../data/model/base/response_model.dart';
import '../../../data/model/response/user_model.dart';
import '../../repository/auth_repo.dart';
import '../base_usecase/base_use_case_call.dart';
import '../base_usecase/base_usecase.dart';


class ChangePasswordUseCase implements BaseUseCase<UserModel>{


  final AuthRepository _repository;
  ChangePasswordUseCase({
    required AuthRepository repository,
  }) : _repository = repository;


  Future<ResponseModel> call({ required String password}) async =>
      BaseUseCaseCall.onGetData<UserModel>( await _repository.changePassword(password:password ), onConvert);




  @override
  ResponseModel<UserModel> onConvert(BaseModel baseModel) {
      UserModel? user = UserModel.fromJson(baseModel.responseData);
      Alerts.showSnackBar(baseModel.message,alertsType: AlertsType.success);
      return ResponseModel(true, baseModel.message, data: user);
  }


}
