import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:q_trip_user/core/utils/globals.dart';
import 'package:q_trip_user/domain/request_body/check_otp_body.dart';
import 'package:q_trip_user/domain/usecase/auth/check_otp_usecase.dart';
import 'package:q_trip_user/domain/usecase/auth/forget_password_usecase.dart';
import 'package:q_trip_user/domain/usecase/auth/update_fcm_token_usecase.dart';
import 'package:q_trip_user/generated/locale_keys.g.dart';

import '../../../../core/notification/device_token.dart';
import '../../../../data/model/base/response_model.dart';
import '../../../../domain/entities/country_entity.dart';
import '../../../../domain/entities/user_entity.dart';
import '../../../../domain/usecase/local/save_data_usecase.dart';

part 'otp_state.dart';

class OtpViewModelCubit extends Cubit<OtpViewModelState> {
  final SaveUserDataUseCase _saveUserDataUseCase;
  final ForgetPasswordUseCase _forgetPasswordUseCase;
  final CheckOTPUseCase _otpUseCase;
  final UpdateFCMTokenUseCase _updateFCMTokenUseCase ;

  OtpViewModelCubit({
    required SaveUserDataUseCase saveUserDataUseCase,
    required CheckOTPUseCase otpUseCase,
    required ForgetPasswordUseCase forgetPasswordUseCase,
    required UpdateFCMTokenUseCase updateFCMTokenUseCase,
  })  : _saveUserDataUseCase = saveUserDataUseCase,
        _forgetPasswordUseCase = forgetPasswordUseCase,
        _otpUseCase = otpUseCase,
        _updateFCMTokenUseCase = updateFCMTokenUseCase, super(OtpViewModelState());

  ///variables
  bool _isLoading = false;
  bool _isResendLoading = false;
  bool _isTimerDone = false;
  DateTime _endTime = DateTime.now().add(const Duration(minutes: 1));

  ///getters
  bool get isLoading => _isLoading;
  bool get isResendLoading => _isResendLoading;
  bool get isTimerDone => _isTimerDone;
  DateTime get endTime => _endTime;


  onTimerEnd(){
    _isTimerDone = true;
    emit(OtpViewModelState());
  }

  //TODO call API
  //send phone to get code
  Future<ResponseModel> reSendCode({required String phone}) async {
    if(!_isTimerDone)return ResponseModel(false, tr(LocaleKeys.error));
    _isResendLoading = true;
    emit(OtpViewModelState());
    ResponseModel responseModel = await _forgetPasswordUseCase(phone: phone);
    if (responseModel.isSuccess) {_isTimerDone = false;_endTime =DateTime.now().add(const Duration(minutes: 1));}
    _isResendLoading = false;
    emit(OtpViewModelState());
    return responseModel;
  }

  //send phone to get code
  Future<ResponseModel> otpCode({required String phone,required String otp,required CheckOTPType type}) async {
    _isLoading = true;
    emit(OtpViewModelState());
    ResponseModel responseModel = await _otpUseCase.call(body: CheckOTPBody(phone: phone,  type: type, otp: otp, ));
    if ( responseModel.isSuccess && responseModel.data != null) {
      UserEntity userEntity = responseModel.data;
      kUser = userEntity;
      String? token = userEntity.accessToken;
      if (token.isNotEmpty) {
        await _saveUserDataUseCase(token: token);
        await _updateFCMToken();
      }

    }
    _isLoading = false;
    emit(OtpViewModelState());
    return responseModel;
  }




  Future<void> _updateFCMToken() async {
    String? fcmToken =await getDeviceToken();
    if (fcmToken == null) {return;}
    await _updateFCMTokenUseCase(fcmToken: fcmToken);
    emit(OtpViewModelState());
  }

}
