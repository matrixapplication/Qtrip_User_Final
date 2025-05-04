part of 'select_car_cubit.dart';

@immutable
abstract class SelectCarState {}

class SelectCarInitial extends SelectCarState {}
class SelectCarLoading2 extends SelectCarState {}
class SelectCarLoading extends SelectCarState {}
class SelectCarStoreRequest extends SelectCarState {}
class SelectCarStoreError extends SelectCarState {}
class PaymentLoadingState extends SelectCarState {}
class PaymentSuccessfulState extends SelectCarState {}
class PaymentErrorState extends SelectCarState {}
class SelectCarSuccessfully extends SelectCarState {
 final List<VehicleEntity> _list ;

 List<VehicleEntity> get list => _list;

  SelectCarSuccessfully({
    required List<VehicleEntity> list,
  }) : _list = list;
}

// class SelectCarSuccessfully extends SelectCarState {
//   List<VehicleEntity>? _list;
//   RequestBody? _body;
//
//   List<VehicleEntity>? get list => _list;
//   RequestBody? get body => _body;
//
//   // SelectCarSuccessfully({
//   //   required List<VehicleEntity> list,
//   //   RequestBody? body,
//   // }) : _list = list, _body = body;
//
//   SelectCarSuccessfully copyWith({List<VehicleEntity>? list, RequestBody? body}) {
//     return SelectCarSuccessfully()
//       .._list = list ?? this._list
//       .._body = body ?? this._body;
//   }
// }

class SelectCarError extends SelectCarState {
  final ErrorModel _error ;

  ErrorModel get error => _error;

  SelectCarError({
    required ErrorModel error,
  }) : _error = error;
}