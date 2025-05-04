

import '../../../data/model/base/base_model.dart';
import '../../../data/model/base/response_model.dart';
import '../../../data/model/response/vehicle_model.dart';
import '../../entities/vehicle_entity.dart';
import '../../repository/trip_repo.dart';
import '../../request_body/vehicle_body.dart';
import '../base_usecase/base_use_case_call.dart';
import '../base_usecase/base_usecase.dart';

class GetVehiclesUseCase implements BaseUseCase<List<VehicleEntity>>{

  final TripRepository _repository;

  const GetVehiclesUseCase({
    required TripRepository repository,
  }) : _repository = repository;
  Future<ResponseModel<List<VehicleEntity>>> call({ required VehicleBody body}) async =>
     BaseUseCaseCall.onGetData<List<VehicleEntity>>( await _repository.getVehicles(body: body), onConvert,tag:'GetVehiclesUseCase' );




  @override
  ResponseModel<List<VehicleEntity>> onConvert(BaseModel baseModel) {
    List<VehicleEntity> list =[];
    baseModel.responseData.forEach((product) => list.add(VehicleModel.fromJson(product)));
    return ResponseModel(true, baseModel.message, data: list);

  }


}


