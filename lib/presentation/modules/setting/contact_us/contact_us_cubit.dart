import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../data/model/base/response_model.dart';
import '../../../../domain/request_body/contact_us_request_body.dart';
import '../../../../domain/usecase/setting/contact_us_request_usecase.dart';

part 'contact_us_state.dart';

class ContactUsCubit extends Cubit<ContactUsState> {
  final ContactUsRequestUseCase _contactUsRequestUseCase;

   ContactUsCubit({
    required ContactUsRequestUseCase contactUsRequestUseCase,
  }) : _contactUsRequestUseCase = contactUsRequestUseCase, super(ContactUsInitial());


  ///calling APIs Functions
  ///
  Future<ResponseModel> sendContactUsRequest({required String name,required String mobile,required String message,required String email}) async {
    emit(ContactUsLoading());

    ResponseModel responseModel = await _contactUsRequestUseCase(body: ContactUsRequestsBody(name: name, phone: mobile, message: message, email: email,));

    emit(ContactUsInitial());
    return responseModel;
  }

}
