

import '../../../data/model/base/base_model.dart';
import '../../../data/model/response/wallet_list_model.dart';
import '../../entities/wallet_list_entity.dart';

import '../../../data/model/base/response_model.dart';


import '../../repository/wallet_repo.dart';
import '../base_usecase/base_use_case_call.dart';
import '../base_usecase/base_usecase.dart';




class GetWalletHistoryUseCase  implements BaseUseCase<WalletListEntity>{

  final WalletRepository _repository;

  const GetWalletHistoryUseCase({
    required WalletRepository repository,
  }) : _repository = repository;

  Future<ResponseModel<WalletListEntity>> call({required int currentPage}) async =>
     BaseUseCaseCall.onGetData<WalletListEntity>( await _repository.getWalletHistory(currentPage:currentPage), onConvert,tag: 'GetWalletHistoryUseCase');

  @override
  ResponseModel<WalletListEntity> onConvert(BaseModel baseModel) {
    WalletListEntity entity = WalletListModel.fromJson(baseModel.response);

    return ResponseModel(true, baseModel.message, data: entity);
  }
}
