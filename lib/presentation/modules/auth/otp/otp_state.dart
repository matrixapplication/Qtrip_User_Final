part of 'otp_cubit.dart';

class OtpViewModelState {
  ///Variables
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  OtpViewModelState();

  OtpViewModelState copyWith({
    bool? isLoading,
    String? error,
  }) {
    return OtpViewModelState().._isLoading = isLoading ?? _isLoading;
  }
}
