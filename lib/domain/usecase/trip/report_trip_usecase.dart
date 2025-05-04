import '../../../data/model/base/base_model.dart';
import '../../../data/model/base/response_model.dart';
import '../../repository/trip_repo.dart';
import '../../request_body/rate_body.dart';
import '../base_usecase/base_use_case_call.dart';
import '../base_usecase/base_usecase.dart';

class ReportTripUseCase implements BaseUseCase{

  final TripRepository _repository;

  const ReportTripUseCase({
    required TripRepository repository,
  }) : _repository = repository;

  Future<ResponseModel> call({required RateBody rateBody}) async =>
      BaseUseCaseCall.onGetData( await _repository.reportTrip(rateBody: rateBody), onConvert,tag:'ReportTripUseCase' );



@override
ResponseModel onConvert(BaseModel baseModel) {
  return ResponseModel(true, baseModel.message);
  }
}
