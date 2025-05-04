
import '../../../data/model/base/base_model.dart';
import '../../../data/model/base/response_model.dart';
import '../../../data/model/response/promo_code_model.dart';
import '../../entities/promo_code_entity.dart';
import '../../repository/address_repo.dart';
import '../../repository/payment_repo.dart';
import '../base_usecase/base_use_case_call.dart';
import '../base_usecase/base_usecase.dart';


class GetPromoCodesUseCase  implements BaseUseCase<List<PromoCodeEntity>>{
  final PaymentRepository _repository;


  const GetPromoCodesUseCase({
    required PaymentRepository repository,
  }) : _repository = repository;


  Future<ResponseModel<List<PromoCodeEntity>>> call() async =>
      BaseUseCaseCall.onGetData<List<PromoCodeEntity>>( await _repository.getValidPromoCode(), onConvert,tag:'GetPromoCodesUseCase' );




  @override
  ResponseModel<List<PromoCodeEntity>> onConvert(BaseModel baseModel){
    List<PromoCodeEntity> list = List<PromoCodeModel>.from( (baseModel.responseData??[]).map((x) => PromoCodeModel.fromJson(x)));
    return ResponseModel(true, baseModel.message,data: list);
  }
}
