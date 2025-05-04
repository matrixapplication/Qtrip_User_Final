//
//
// import '../base_usecase/base_usecase.dart';
//
// class PaymentUseCase2 implements BaseUseCase<String>{
//
//   final TripRepository _repository;
//
//   const PaymentUseCase2({
//     required TripRepository repository,
//   }) : _repository = repository;
//   Future<ResponseModel<String>> call({required PaymentParams params}) async =>
//      BaseUseCaseCall.onGetData<String>( await _repository.paymentTrip(params: params), onConvert,tag:'PaymentUseCase' );
//
//
//
//
//   @override
//   ResponseModel<String> onConvert(BaseModel baseModel) {
//     return ResponseModel(true, baseModel.message, data: baseModel.urlPayment);
//
//   }
//
//
// }
//
//
