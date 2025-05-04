

import '../../../data/model/base/base_model.dart';
import '../../../data/model/base/response_model.dart';
import '../../../data/model/response/country_model.dart';
import '../../entities/country_entity.dart';
import '../../repository/setting_repo.dart';
import '../base_usecase/base_use_case_call.dart';
import '../base_usecase/base_usecase.dart';




class GetCountriesUseCase  implements BaseUseCase<List<CountryEntity>>{

  final SettingRepository _repository;
  GetCountriesUseCase({
    required SettingRepository repository,
  }) : _repository = repository;


  Future<ResponseModel<List<CountryEntity>>> call() async =>
     BaseUseCaseCall.onGetData<List<CountryEntity>>( await _repository.getCountries(), onConvert,tag: 'GetCountriesUseCase');



  @override
  ResponseModel<List<CountryEntity>> onConvert(BaseModel baseModel) {
    List<CountryEntity> list = [];
    baseModel.responseData.forEach((product) => list.add(CountryModel.fromJson(product)));
    return ResponseModel(true, baseModel.message, data: list);
  }


}



