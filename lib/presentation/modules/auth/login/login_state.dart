part of 'login_cubit.dart';

@immutable
abstract class LoginViewModelState {}


class LoginViewInitial extends LoginViewModelState {}
class LoginViewLoading extends LoginViewModelState {}
class SendOtpLoading extends LoginViewModelState {}
class SendOtpSuccess extends LoginViewModelState {}
class SendOtpError extends LoginViewModelState {}
class LoginViewError extends LoginViewModelState {
  final ErrorModel? _error;

  ErrorModel? get error => _error;

  LoginViewError({
    required ErrorModel? error,
  }) : _error = error;
}
class LoginViewSuccessfully extends LoginViewModelState {}



// class LoginViewModelState {
//   ///Variables
//   bool isLoading = false;
//   String? error;
//
//   LoginViewModelState();
//
//   LoginViewModelState copyWith({
//     bool? isLoading,
//     String? error,
//   }) {
//     return LoginViewModelState()
//       ..isLoading = isLoading ?? this.isLoading
//       ..error = error ?? this.error;
//   }
//
//
// }

