
import '../../../data/model/base/base_model.dart';
import '../../../data/model/base/response_model.dart';
import '../../repository/address_repo.dart';
import '../base_usecase/base_use_case_call.dart';
import '../base_usecase/base_usecase.dart';

class DeleteAddressUseCase implements BaseUseCase{


  final AddressRepository repository;

  DeleteAddressUseCase({required this.repository});

  Future<ResponseModel> call({ required int addressId}) async {
    return BaseUseCaseCall.onGetData( await repository.deleteAddress(addressId: addressId), onConvert);
  }



  @override
  ResponseModel onConvert(BaseModel baseModel) {
    return ResponseModel(true, baseModel.message);
  }


}
