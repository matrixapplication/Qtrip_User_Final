

import 'dart:io';

import 'package:q_trip_user/data/model/base/base_model.dart';

import '../../../data/model/base/response_model.dart';
import '../../../data/model/response/user_model.dart';
import '../../repository/auth_repo.dart';
import '../base_usecase/base_use_case_call.dart';
import '../base_usecase/base_usecase.dart';


class UpdateFCMTokenUseCase implements BaseUseCase<UserModel>{


  final AuthRepository repository;

  UpdateFCMTokenUseCase({required this.repository});

  Future<ResponseModel> call({ required String fcmToken}) async {

    return BaseUseCaseCall.onGetData<UserModel>( await repository.updateFCMToken(fcmToken: fcmToken, deviceType: _getDeviceType()), onConvert);
  }



  @override
  ResponseModel<UserModel> onConvert(BaseModel baseModel) {
    return ResponseModel(true, baseModel.message);
  }

  String _getDeviceType() {
    if (Platform.isIOS) {
      return 'android';
    } else if (Platform.isAndroid) {
      return 'android';
    } else {
      return 'web';
    }
  }
}
