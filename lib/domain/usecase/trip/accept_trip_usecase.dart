
import '../../../data/model/base/base_model.dart';
import '../../../data/model/base/response_model.dart';
import '../../repository/address_repo.dart';
import '../../repository/trip_repo.dart';
import '../base_usecase/base_use_case_call.dart';
import '../base_usecase/base_usecase.dart';


class AcceptTripUseCase implements BaseUseCase{

  final TripRepository _repository;

  const AcceptTripUseCase({
    required TripRepository repository,
  }) : _repository = repository;

  Future<ResponseModel> call({required String tripId,required String driverId,required String price}) async =>
      BaseUseCaseCall.onGetData( await _repository.acceptTrip(tripId: tripId, driverId: driverId,price:price), onConvert,tag:'AcceptTripUseCase' );




  @override
  ResponseModel onConvert(BaseModel baseModel) {
    return ResponseModel(true, baseModel.message);

  }
}


