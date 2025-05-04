


import '../../../data/model/base/base_model.dart';
import '../../../data/model/base/response_model.dart';
import '../../repository/setting_repo.dart';
import '../base_usecase/base_use_case_call.dart';
import '../base_usecase/base_usecase.dart';




class GetAboutUseCase  implements BaseUseCase<String>{
  // final _tag = 'GetAboutUseCase';

  final SettingRepository repository;

  GetAboutUseCase({required this.repository});

  Future<ResponseModel<String>> call() async =>
     BaseUseCaseCall.onGetData<String>( await repository.getAbout(), onConvert);



  @override
  ResponseModel<String> onConvert(BaseModel baseModel) =>
      ResponseModel(true, baseModel.message, data:  baseModel.responseData);


}
