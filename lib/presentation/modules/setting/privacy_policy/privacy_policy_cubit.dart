import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:q_trip_user/domain/usecase/setting/get_privacy_usecase.dart';

import '../../../../data/model/base/response_model.dart';
import '../../../../domain/usecase/setting/get_terms_usecase.dart';

part 'privacy_policy_state.dart';

class PrivacyPolicyCubit extends Cubit<PrivacyPolicyState> {
  final GetPrivacyUseCase _getPrivacyUseCase;

  PrivacyPolicyCubit({required GetPrivacyUseCase getPrivacyUseCase})
      : _getPrivacyUseCase = getPrivacyUseCase,
        super(PrivacyPolicyInitial());

  ///call APIs Functions
  // get terms
  getPrivacyPolicy({required bool reload}) async {
    emit(PrivacyPolicyLoading());

    ResponseModel<String> responseModel = await _getPrivacyUseCase();
    if (responseModel.data != null) {
      emit(PrivacyPolicyGotSuccessfully(privacyPolicy: responseModel.data!));
    }
    emit(PrivacyPolicyInitial());
  }
}
