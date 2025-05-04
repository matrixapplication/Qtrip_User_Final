part of 'my_trips_cubit.dart';

@immutable
 class MyTripsState {}

 class MyTripsInitial extends MyTripsState {}
class GetMyTripsLoading extends MyTripsState {}
class GetMyTripsSuccess extends MyTripsState {
  final ResponseModel<List<TripHistoryEntity>> responseModel ;

  GetMyTripsSuccess({required this.responseModel});
}
class GetMyTripsErro extends MyTripsState {}
