

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:meta/meta.dart';
import 'package:q_trip_user/presentation/modules/setting/wallet/payment_page.dart';
import '../../../../core/utils/show_toast.dart';
import '../../../../data/datasource/remote/exception/error_widget.dart';
import '../../../../data/model/base/response_model.dart';

import '../../../../../domain/logger.dart';
import '../../../../domain/entities/wallet_list_entity.dart';
import '../../../../domain/usecase/wallet/get_wallet_history_usecase.dart';
import '../../../../domain/usecase/wallet/recharge_wallet_usecase.dart';

part 'wallet_state.dart';

class WalletCubit extends Cubit<WalletState> {
  final GetWalletHistoryUseCase _getWalletHistoryUseCase;
  final RechargeWalletUseCase rechargeWalletUseCase;

  WalletCubit({
    required this.rechargeWalletUseCase,

    required GetWalletHistoryUseCase getWalletHistoryUseCase,
  })  : _getWalletHistoryUseCase = getWalletHistoryUseCase,
        super(WalletInitial());


  ///variables
  bool _isLoadRequestList = true;
  ResponseModel<WalletListEntity>? _responseModel;
  int _currentPage=1;

  ///getters
  bool get isLoadRequestList => _isLoadRequestList;
  ResponseModel<WalletListEntity>? get responseModel => _responseModel;




  ///call APIs Functions
  Future rechargeWallet({required double amount,required BuildContext context})async{
    try{
      emit(RechargeWalletLoading());
      ResponseModel responseModel = await rechargeWalletUseCase.call(amount: amount);
      if(responseModel.isSuccess){
        final paymentUrl =responseModel.data;
        Navigator.pop(context);
        if(paymentUrl.isNotEmpty){
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PaymentPage( paymentUrl),
            ),
          ).then((result) {
            if (result == true) {
              if (kDebugMode) {
                print("تم الدفع بنجاح");
              }
              showToast(text: responseModel.message.toString(), state: ToastStates.success,);
              getWallet(reload: true);
              return true;
            } else {
              print("فشلت عملية الدفع");

              return false;

            }
          });
          return false;
        }

        emit(RechargeWalletSuccess());

      }else{
        emit(RechargeWalletError());

      }
    }catch(e){
      emit(RechargeWalletError());
    }
  }

  getWallet({bool reload = false, bool isLoadMore = false}) async {
    log('getWallet', 'reload:$reload -- isLoadMore:$isLoadMore');
    _isLoadRequestList = true;
    if (reload) {_responseModel = null;_currentPage = 0; emit(WalletLoading());}
    else if (!isLoadMore) {_responseModel = null;}
    else {_currentPage = _currentPage + 1;}

    ResponseModel<WalletListEntity> responseModel = await _getWalletHistoryUseCase.call(currentPage: _currentPage);

    if (isLoadMore && _responseModel != null) {
      _responseModel?.data?.list.addAll(responseModel.data?.list ?? []);
    } else {
      _responseModel = responseModel;
    }
    _isLoadRequestList = false;
    emit(WalletHistoryGotSuccessfully(responseModel: responseModel));
  }

  void init(BuildContext context) {
    _responseModel= null;
    getWallet();
  }

}
