

import 'package:q_trip_user/domain/entities/user_entity.dart';

import '../../../data/model/base/base_model.dart';
import '../../../data/model/base/response_model.dart';
import '../../../data/model/response/user_model.dart';
import '../../repository/profile_repo.dart';
import '../base_usecase/base_use_case_call.dart';
import '../base_usecase/base_usecase.dart';

class GetProfileUseCase  implements BaseUseCase<UserEntity>{
  final ProfileRepository repository;

  GetProfileUseCase({required this.repository});

  Future<ResponseModel> call() async {
    return BaseUseCaseCall.onGetData<UserEntity>( await repository.getProfile(), onConvert,tag: 'GetProfileUseCase');
  }

  @override
  ResponseModel<UserEntity> onConvert(BaseModel baseModel) {
    UserEntity? user ;
    if (baseModel.responseData != null) { user = UserModel.fromJson(baseModel.responseData);}
    return ResponseModel(true, baseModel.message, data: user);
  }
}
