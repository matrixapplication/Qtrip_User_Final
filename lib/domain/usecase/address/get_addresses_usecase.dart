

import '../../../data/model/base/base_model.dart';
import '../../../data/model/base/response_model.dart';
import '../../../data/model/response/addresses_model.dart';
import '../../entities/addresses_entity.dart';
import '../../repository/address_repo.dart';
import '../base_usecase/base_use_case_call.dart';
import '../base_usecase/base_usecase.dart';


class GetAddressesUseCase implements BaseUseCase<AddressesEntity>{


  final AddressRepository repository;

  GetAddressesUseCase({required this.repository});

  Future<ResponseModel<AddressesEntity>> call() async {
    return BaseUseCaseCall.onGetData<AddressesEntity>( await repository.getAddresses(), onConvert,tag: 'GetAddressesUseCase');
  }


  @override
  ResponseModel<AddressesEntity> onConvert(BaseModel baseModel) {
    AddressesEntity object=  AddressesModel.fromJson(baseModel.responseData);
    return ResponseModel(true, baseModel.message, data: object);
  }
}
