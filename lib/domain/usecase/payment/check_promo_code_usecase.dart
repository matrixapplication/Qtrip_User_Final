
import '../../../data/datasource/remote/exception/api_checker.dart';
import '../../../data/model/base/base_model.dart';
import '../../../data/model/base/response_model.dart';
import '../../../data/model/response/promo_code_model.dart';
import '../../entities/promo_code_entity.dart';
import '../../repository/address_repo.dart';
import '../../repository/payment_repo.dart';
import '../base_usecase/base_use_case_call.dart';
import '../base_usecase/base_usecase.dart';

class CheckPromoCodeUseCase  implements BaseUseCase<PromoCodeEntity>{
  final PaymentRepository _repository;


  const CheckPromoCodeUseCase({
    required PaymentRepository repository,
  }) : _repository = repository;


  Future<ResponseModel<PromoCodeEntity>> call({required String promoCode}) async =>
      BaseUseCaseCall.onGetData<PromoCodeEntity>( await _repository.checkPromoCode(promoCode: promoCode), onConvert,tag:'CheckPromoCodeUseCase' );



  @override
  ResponseModel<PromoCodeEntity> onConvert(BaseModel baseModel){

    if(baseModel.responseData==null){
      return  ApiChecker.checkApi<PromoCodeEntity>( message: baseModel.message);
    }
    PromoCodeEntity entity = PromoCodeModel.fromJson(baseModel.responseData);
    return ResponseModel(true, baseModel.message,data: entity);
  }
}
