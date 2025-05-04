import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:q_trip_user/domain/usecase/setting/get_about_usecase.dart';

import '../../../../data/model/base/response_model.dart';
import '../../../../domain/usecase/setting/get_terms_usecase.dart';

part 'about_us_state.dart';

class AboutUsCubit extends Cubit<AboutUsState> {
  final GetAboutUseCase _getAboutUseCase;

  AboutUsCubit({required GetAboutUseCase getAboutUseCase})
      : _getAboutUseCase = getAboutUseCase,
        super(AboutUsInitial());

  ///call APIs Functions
  // get terms
  getAboutUs({required bool reload}) async {
    emit(AboutUsLoading());

    ResponseModel<String> responseModel = await _getAboutUseCase();
    if (responseModel.data != null) {
      emit(AboutUsGotSuccessfully(aboutUs: responseModel.data!));
    }
    emit(AboutUsInitial());
  }
}
