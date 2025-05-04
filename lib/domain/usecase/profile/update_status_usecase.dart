import 'package:q_trip_user/data/model/base/base_model.dart';
import 'package:q_trip_user/data/model/base/response_model.dart';
import 'package:q_trip_user/domain/entities/user_entity.dart';
import 'package:q_trip_user/domain/repository/profile_repo.dart';
import '../../../data/model/response/user_model.dart';
import '../base_usecase/base_use_case_call.dart';
import '../base_usecase/base_usecase.dart';


class UpdateStatusUseCase implements BaseUseCase<UserEntity>{


  final ProfileRepository repository;

  UpdateStatusUseCase({required this.repository});

  Future<ResponseModel> call() async {
    return BaseUseCaseCall.onGetData<UserEntity>( await repository.updateStatus(), onConvert);
  }


  @override
  ResponseModel<UserEntity> onConvert(BaseModel baseModel) {
    UserEntity? user = UserModel.fromJson(baseModel.responseData);
    return ResponseModel(true, baseModel.message, data: user);
  }
}



