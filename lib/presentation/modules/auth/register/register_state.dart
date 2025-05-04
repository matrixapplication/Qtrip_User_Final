
part of 'register_cubit.dart';


@immutable
abstract class RegisterState {}


class RegisterInitial extends RegisterState {}
// class RegisterInitial extends RegisterViewModelState {final RegisterBody body = RegisterBody();}
class RegisterLoading extends RegisterState {}
class RegisterSuccessfully extends RegisterState {}






//
// class RegisterField extends RegisterViewModelState {}

// class RegisterViewModelState {
//
//   ///Variables
//   bool _isLoading = false;
//
//
//   bool get isLoading => _isLoading;
//
//
//
//
//   RegisterViewModelState();
//
//   RegisterViewModelState copyWith({
//     bool? isLoading,
//     String? error,
//   }) {
//     return RegisterViewModelState()
//       .._isLoading = isLoading ?? _isLoading;
//   }
// }

