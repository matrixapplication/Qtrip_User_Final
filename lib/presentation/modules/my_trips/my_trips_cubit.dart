import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../data/model/base/response_model.dart';
import '../../../domain/entities/trip_history_entity.dart';
import '../../../domain/usecase/trip/get_trips_usecase.dart';

part 'my_trips_state.dart';

class MyTripsCubit extends Cubit<MyTripsState> {
  final GetTripsUseCase getTripsUseCase;
  MyTripsCubit({required this.getTripsUseCase}) : super(MyTripsInitial());

  getTrips({required bool reload, DateTime? date}) async {
    if(reload)emit(GetMyTripsLoading());
    ResponseModel<List<TripHistoryEntity>> responseModel =await getTripsUseCase(date:date);
    emit(GetMyTripsSuccess(responseModel: responseModel));
  }
}
