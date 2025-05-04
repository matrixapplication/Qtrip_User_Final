part of 'wallet_cubit.dart';

@immutable
abstract class WalletState {}

class WalletInitial extends WalletState {}
class WalletLoading extends WalletState {}
class RechargeWalletLoading extends WalletState {}
class RechargeWalletSuccess extends WalletState {}
class RechargeWalletError extends WalletState {}
class WalletError extends WalletState {
  final ErrorModel _error ;

  ErrorModel get error => _error;

  WalletError({
    required ErrorModel error,
  }) : _error = error;
}


class WalletHistoryGotSuccessfully extends WalletState {
  final ResponseModel<WalletListEntity> _responseModel ;



  ResponseModel<WalletListEntity> get responseModel => _responseModel;

  WalletHistoryGotSuccessfully({
    required ResponseModel<WalletListEntity> responseModel,
  }) : _responseModel = responseModel;
}

