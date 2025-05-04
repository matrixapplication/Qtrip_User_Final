import '../../../data/model/base/base_model.dart';
import '../../../data/model/base/response_model.dart';
import '../../../data/model/response/social_medail_model.dart';
import '../../repository/getsocialmedia_repo.dart';
import '../base_usecase/base_use_case_call.dart';
import '../base_usecase/base_usecase.dart';


class GetSocialMediaUseCase implements BaseUseCase<SocialMediaModel>{
  final GetSocialMediaRepository repository;
  GetSocialMediaUseCase({required this.repository});
  Future<ResponseModel<SocialMediaModel>> call() async {
    return BaseUseCaseCall.onGetData<SocialMediaModel>( await repository.getGetSocialMedia(), onConvert,tag: 'GetSocialMediaUseCase');
  }

  @override
  ResponseModel<SocialMediaModel> onConvert(BaseModel baseModel) {
    SocialMediaModel socialMediaModel =SocialMediaModel.fromJson(baseModel.response);
    try{
      return ResponseModel(baseModel.status??true, baseModel.message,data:socialMediaModel);
    }catch(e){
      return ResponseModel(baseModel.status??false, baseModel.message,data: baseModel.responseData);
    }
  }
}

      