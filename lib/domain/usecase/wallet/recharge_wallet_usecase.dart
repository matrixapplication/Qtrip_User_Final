

import '../../../data/model/base/base_model.dart';
import '../../../data/model/response/wallet_list_model.dart';
import '../../entities/wallet_list_entity.dart';

import '../../../data/model/base/response_model.dart';
import '../../repository/wallet_repo.dart';


import '../base_usecase/base_use_case_call.dart';
import '../base_usecase/base_usecase.dart';




class RechargeWalletUseCase  implements BaseUseCase<String>{

  final WalletRepository _repository;

  const RechargeWalletUseCase({
    required WalletRepository repository,
  }) : _repository = repository;

  Future<ResponseModel<String>> call({required double amount}) async =>
     BaseUseCaseCall.onGetData<String>( await _repository.rechargeWallet(amount:amount), onConvert,tag: 'RechargeWalletUseCase');

  @override
  ResponseModel<String> onConvert(BaseModel baseModel) {
    return ResponseModel(true, baseModel.message, data: baseModel.url['url']);
  }
}
