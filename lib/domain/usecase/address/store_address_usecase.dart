
import '../../../data/model/base/base_model.dart';
import '../../../data/model/base/response_model.dart';
import '../../repository/address_repo.dart';
import '../../request_body/address_body.dart';
import '../base_usecase/base_use_case_call.dart';
import '../base_usecase/base_usecase.dart';


class StoreAddressUseCase implements BaseUseCase{

  final AddressRepository repository;
  StoreAddressUseCase({required this.repository});

  Future<ResponseModel> call({ required AddressBody body}) async => BaseUseCaseCall.onGetData( await repository.storeAddress(body: body), onConvert);

  @override
  ResponseModel onConvert(BaseModel baseModel) =>ResponseModel(true, baseModel.message);

}
