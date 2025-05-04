
import '../../../data/model/base/base_model.dart';
import '../../../data/model/base/response_model.dart';
import '../../../data/model/response/trip_history_model.dart';
import '../../entities/trip_history_entity.dart';
import '../../repository/trip_repo.dart';
import '../base_usecase/base_use_case_call.dart';
import '../base_usecase/base_usecase.dart';

class GetTripsUseCase  implements BaseUseCase<List<TripHistoryEntity>>{
  final TripRepository _repository;


  const GetTripsUseCase({
    required TripRepository repository,
  }) : _repository = repository;

  Future<ResponseModel<List<TripHistoryEntity>>> call({required DateTime? date}) async =>
      BaseUseCaseCall.onGetData<List<TripHistoryEntity>>( await _repository.getTrips(date: date), onConvert,tag:'GetTripsUseCase' );



  @override
  ResponseModel<List<TripHistoryEntity>> onConvert(BaseModel baseModel){
    List<TripHistoryEntity> list = List<TripHistoryModel>.from( (baseModel.responseData??[]).map((x) => TripHistoryModel.fromJson(x)));
    return ResponseModel(true, baseModel.message,data: list);
  }
}
