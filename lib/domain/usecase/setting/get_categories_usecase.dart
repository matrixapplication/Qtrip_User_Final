


import '../../../data/model/base/base_model.dart';
import '../../../data/model/base/response_model.dart';
import '../../../data/model/response/drop_down_model.dart';
import '../../entities/drop_down_entity.dart';
import '../../repository/setting_repo.dart';
import '../base_usecase/base_use_case_call.dart';
import '../base_usecase/base_usecase.dart';




class GetCategoriesUseCase  implements BaseUseCase<List<DropDownEntity>>{

  final SettingRepository repository;

  GetCategoriesUseCase({required this.repository});

  Future<ResponseModel<List<DropDownEntity>>> call() async {
    return BaseUseCaseCall.onGetData<List<DropDownEntity>>( await repository.getCategories(), onConvert);
  }

  @override
  ResponseModel<List<DropDownEntity>> onConvert(BaseModel baseModel) {
    List<DropDownEntity> list = [];

    baseModel.responseData.forEach((product) => list.add(DropDownModel.fromJson(product)));
    return ResponseModel(true, baseModel.message, data: list);
  }

  Future<ResponseModel<List<DropDownEntity>>> callTest() async {
    List<DropDownEntity> list = [
      const DropDownEntity(id: 1, title: "جدة",),
      const DropDownEntity(id: 2, title: "المدينة"),
      const DropDownEntity(id: 3, title: "مكة" ),
    ];
    return ResponseModel(true, '', data: list);
  }
}



