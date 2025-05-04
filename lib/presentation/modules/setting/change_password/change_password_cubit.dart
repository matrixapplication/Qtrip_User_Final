import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../data/model/base/response_model.dart';
import '../../../../domain/usecase/auth/change_password_usecase.dart';

part 'change_password_state.dart';

class ChangePasswordCubit extends Cubit<ChangePasswordState> {
  final ChangePasswordUseCase _changePasswordUseCase;

   ChangePasswordCubit({
    required ChangePasswordUseCase changePasswordUseCase,
  }) : _changePasswordUseCase = changePasswordUseCase, super(ChangePasswordInitial());



  ///calling APIs Functions
  Future<ResponseModel> changePassword({required String password}) async {
    emit(ChangePasswordLoading());

    ResponseModel responseModel = await _changePasswordUseCase(password: password);

    emit(ChangePasswordInitial());
    return responseModel;
  }

}
