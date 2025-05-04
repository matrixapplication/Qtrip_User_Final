

import 'package:q_trip_user/data/datasource/remote/exception/api_checker.dart';
import 'package:q_trip_user/data/model/base/base_model.dart';
import 'package:q_trip_user/data/model/base/response_model.dart';
import 'package:q_trip_user/domain/entities/user_entity.dart';
import 'package:q_trip_user/domain/repository/profile_repo.dart';
import 'package:q_trip_user/domain/request_body/profile_body.dart';

import '../../../core/utils/globals.dart';
import '../../../data/model/response/user_model.dart';
import '../base_usecase/base_use_case_call.dart';
import '../base_usecase/base_usecase.dart';


class UpdateProfileImageUseCase implements BaseUseCase<UserEntity>{
  final ProfileRepository _repository;

  const UpdateProfileImageUseCase({
    required ProfileRepository repository,
  }) : _repository = repository;

  Future<ResponseModel<UserEntity>> call({required String path}) async {
    return BaseUseCaseCall.onGetData<UserEntity>(
        await _repository.updateProfileImage(path: path), onConvert);
  }

  @override
  ResponseModel<UserEntity> onConvert(BaseModel baseModel) {
    UserEntity user = UserModel.fromJson(baseModel.item['data']);
    kUser = user;
    return ResponseModel(true, baseModel.message, data: user);
  }
}
