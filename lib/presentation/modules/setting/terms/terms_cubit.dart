import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../data/model/base/response_model.dart';
import '../../../../domain/usecase/setting/get_terms_usecase.dart';

part 'terms_state.dart';

class TermsCubit extends Cubit<TermsState> {
  final GetTermsUseCase _getTermsUseCase;

  TermsCubit({required GetTermsUseCase getTermsUseCase})
      : _getTermsUseCase = getTermsUseCase,
        super(TermsInitial());

  ///call APIs Functions
  // get terms
  getTerms({required bool reload}) async {
    emit(TermsLoading());

    ResponseModel<String> responseModel = await _getTermsUseCase();
    if (responseModel.data != null) {
      emit(TermsGotSuccessfully(terms: responseModel.data!));
    }
    emit(TermsInitial());
  }
}
