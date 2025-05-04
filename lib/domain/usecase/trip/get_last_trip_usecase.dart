
import '../../../data/model/base/base_model.dart';
import '../../../data/model/base/response_model.dart';
import '../../../data/model/response/trip_model.dart';
import '../../repository/address_repo.dart';
import '../../repository/trip_repo.dart';
import '../base_usecase/base_use_case_call.dart';
import '../base_usecase/base_usecase.dart';

import '../../entities/trip_entity.dart';

class GetLastTripUseCase implements BaseUseCase<TripEntity>{

  final TripRepository _repository;

  const GetLastTripUseCase({
    required TripRepository repository,
  }) : _repository = repository;

  Future<ResponseModel<TripEntity>> call() async =>
      BaseUseCaseCall.onGetData( await _repository.getLastTrip(), onConvert,tag:'GetLastTripUseCase' );



@override
ResponseModel<TripEntity> onConvert(BaseModel baseModel) {
    try {
      TripEntity? entity = TripModel.fromJson(baseModel.responseData);
      return ResponseModel(true, baseModel.message, data: entity);
    } catch (e) {
      return ResponseModel(true, baseModel.message);
    }
  }
}
