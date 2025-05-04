
import '../../../data/model/base/base_model.dart';
import '../../../data/model/base/response_model.dart';
import '../../repository/address_repo.dart';
import '../../repository/trip_repo.dart';
import '../base_usecase/base_use_case_call.dart';
import '../base_usecase/base_usecase.dart';


class CancelTripUseCase implements BaseUseCase{

  final TripRepository _repository;

  const CancelTripUseCase({
    required TripRepository repository,
  }) : _repository = repository;

  Future<ResponseModel> call({required String tripId,required int reasonId}) async =>
      BaseUseCaseCall.onGetData( await _repository.cancelTrip(tripId: tripId, reasonId: reasonId), onConvert,tag:'CancelTripUseCase' );




  @override
  ResponseModel onConvert(BaseModel baseModel) {
    return ResponseModel(true, baseModel.message);

  }
}


