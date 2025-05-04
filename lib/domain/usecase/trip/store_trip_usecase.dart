

import '../../../data/model/base/base_model.dart';
import '../../../data/model/base/response_model.dart';
import '../../repository/trip_repo.dart';
import '../../request_body/request_body.dart';
import '../base_usecase/base_use_case_call.dart';
import '../base_usecase/base_usecase.dart';

class StoreTripUseCase implements BaseUseCase<String>{

  final TripRepository _repository;

  const StoreTripUseCase({
    required TripRepository repository,
  }) : _repository = repository;

  Future<ResponseModel<String>> call({ required RequestBody body}) async =>
      BaseUseCaseCall.onGetData<String>( await _repository.storeTrip(body: body), onConvert,tag:'StoreTripUseCase');




  @override
  ResponseModel<String> onConvert(BaseModel baseModel) {
    String tripId = baseModel.responseData['id'].toString();
    return ResponseModel(true, baseModel.message, data: tripId);

  }
}


