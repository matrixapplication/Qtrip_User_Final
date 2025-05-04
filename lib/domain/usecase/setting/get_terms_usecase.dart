
import '../../../data/model/base/base_model.dart';
import '../../repository/setting_repo.dart';

import '../../../data/model/base/response_model.dart';
import '../base_usecase/base_use_case_call.dart';
import '../base_usecase/base_usecase.dart';




class GetTermsUseCase  implements BaseUseCase<String>{
  // final _tag = 'GetTermsUseCase';

  final SettingRepository repository;

  GetTermsUseCase({required this.repository});

  Future<ResponseModel<String>> call() async =>
     BaseUseCaseCall.onGetData<String>( await repository.getTerms(), onConvert);



  @override
  ResponseModel<String> onConvert(BaseModel baseModel) =>
      ResponseModel(true, baseModel.message, data:  baseModel.responseData);


}
