

import 'package:q_trip_user/core/utils/globals.dart';
import 'package:q_trip_user/data/model/base/base_model.dart';
import 'package:q_trip_user/data/model/base/response_model.dart';
import 'package:q_trip_user/domain/entities/user_entity.dart';
import 'package:q_trip_user/domain/repository/profile_repo.dart';
import 'package:q_trip_user/domain/request_body/profile_body.dart';
import '../../../data/model/response/user_model.dart';
import '../base_usecase/base_use_case_call.dart';
import '../base_usecase/base_usecase.dart';


class UpdateProfileUseCase implements BaseUseCase<UserEntity>{


  final ProfileRepository _repository;

  const UpdateProfileUseCase({
    required ProfileRepository repository,
  }) : _repository = repository;

  Future<ResponseModel<UserEntity>> call({required ProfileBody body}) async {
    return BaseUseCaseCall.onGetData<UserEntity>(
        await _repository.updateProfile(profileBody: body), onConvert);
  }
  @override
  ResponseModel<UserEntity> onConvert(BaseModel baseModel) {
    UserEntity user = UserModel.fromJson(baseModel.responseData);
    kUser = user;
    return ResponseModel(true, baseModel.message, data: user);
  }

}
