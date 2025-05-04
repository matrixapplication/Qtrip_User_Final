
import '../../../data/model/base/base_model.dart';
import '../../../data/model/base/response_model.dart';
import '../../../data/model/response/drop_down_model.dart';
import '../../entities/drop_down_entity.dart';
import '../../repository/address_repo.dart';
import '../../repository/trip_repo.dart';
import '../base_usecase/base_use_case_call.dart';
import '../base_usecase/base_usecase.dart';

class GetCancelReasonsUseCase implements BaseUseCase<List<DropDownEntity>>{

  final TripRepository _repository;

  const GetCancelReasonsUseCase({
    required TripRepository repository,
  }) : _repository = repository;
  Future<ResponseModel<List<DropDownEntity>>> call() async =>
     BaseUseCaseCall.onGetData<List<DropDownEntity>>( await _repository.getCancelReasons(), onConvert,tag:'GetCancelReasonsUseCase' );




  @override
  ResponseModel<List<DropDownEntity>> onConvert(BaseModel baseModel) {
    List<DropDownEntity> list =[];
    baseModel.responseData.forEach((product) => list.add(DropDownModel.fromJson(product)));
    return ResponseModel(true, baseModel.message, data: list);

  }


}


