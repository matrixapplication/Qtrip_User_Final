
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:q_trip_user/domain/logger.dart';
import 'package:q_trip_user/domain/provider/local_auth_state.dart';
import 'package:q_trip_user/generated/locale_keys.g.dart';

import '../../core/notification/device_token.dart';
import '../../core/routing/navigation_services.dart';
import '../../core/routing/routes.dart';
import '../../core/utils/globals.dart';
import '../../data/model/base/response_model.dart';
import '../usecase/auth/delete_account_usecase.dart';
import '../usecase/auth/logout_usecase.dart';
import '../usecase/auth/update_fcm_token_usecase.dart';
import '../usecase/local/clear_user_data_usecase.dart';
import '../usecase/local/get_is_login_usecase.dart';
import '../usecase/profile/get_profile_usecase.dart';


class LocalAuthCubit extends Cubit<LocalAuthState> {
  final _tag = 'LocalAuthProvider';

  ///Use Cases
  final LogoutUseCase _logoutUseCase;
  final IsUserLoginUseCase _isUserLoginUseCase;
  final GetProfileUseCase _getProfileUseCase;
  final DeleteAccountUseCase _deleteAccountUseCase;
  final ClearUserDataUseCase _clearUserDataUseCase;
  final UpdateFCMTokenUseCase _updateFCMTokenUseCase;

  LocalAuthCubit({
    required LogoutUseCase logoutUseCase,
    required ClearUserDataUseCase clearUserDataUseCase,
    required IsUserLoginUseCase isUserLoginUseCase,
    required GetProfileUseCase getProfileUseCase,
    required DeleteAccountUseCase deleteAccountUseCase,
    required UpdateFCMTokenUseCase updateFCMTokenUseCase,
  })  : _clearUserDataUseCase = clearUserDataUseCase,
        _logoutUseCase = logoutUseCase,
        _isUserLoginUseCase = isUserLoginUseCase,
        _deleteAccountUseCase = deleteAccountUseCase,
        _updateFCMTokenUseCase = updateFCMTokenUseCase,
        _getProfileUseCase = getProfileUseCase,
        super(LocalAuthState());

  ///call APIs Functions
  Future<bool> isLogin() async {
    ResponseModel responseModel = await _isUserLoginUseCase();
    if (responseModel.isSuccess) {
      emit(state.copyWith(isLogin: true));
      _updateFCMToken();
      ResponseModel profileResponseModel = await getUser();
      if (!profileResponseModel.isSuccess) {
        logOut();
      }
      return profileResponseModel.isSuccess;
    } else {}
    return responseModel.isSuccess;
  }

  Future<bool> logOut() async {
    ResponseModel responseModel = await _logoutUseCase();
    if(responseModel.isSuccess){
      return await _clearUserData();
    }else{
      return false;
    }

  }
  Future<bool> _clearUserData() async {

    ResponseModel responseModel = await _clearUserDataUseCase();
    if (responseModel.isSuccess) {
      // FirebaseMessaging.instance.deleteToken();
      kUser = null;
      emit(state.copyWith(isLogin: false));
    }
    return responseModel.isSuccess;
  }


  Future<ResponseModel> getUser() async {
    log(_tag, 'getUser');
    notify(true, null);

    ResponseModel responseModel = await _getProfileUseCase();
    if (responseModel.isSuccess) {
      kUser = responseModel.data;
      // var response = await NavigationService.navigationKey.currentContext!.read<ProfileCubit>().updateProfile(name: kUser?.name??'', phone: kUser?.mobile??'', email: kUser?.email??'');
      notify(false, null);
    } else {
      notify(false, responseModel.message);
    }
    return responseModel;
  }

  Future<ResponseModel> deleteAccount(BuildContext context) async {
    log(_tag, 'deleteAccount');
    notify(true, null);

    ResponseModel responseModel = await _deleteAccountUseCase();
    if (responseModel.isSuccess) {
      if (await logOut()) {
        Navigator.pop(context);
        NavigationService.pushNamedAndRemoveUntil(Routes.loginScreen);
        notify(false, null);
      } else {
        notify(false, tr(LocaleKeys.error));
      }
    } else {
      notify(false, responseModel.message);
    }
    return responseModel;
  }

  ///update fcm token
  Future<bool> _updateFCMToken() async {
    String? fcmToken =  await getDeviceToken();
    if (fcmToken == null) return false;
    ResponseModel responseModel = await _updateFCMTokenUseCase(fcmToken: fcmToken);
    return responseModel.isSuccess;
  }

  ///update screens status Function
  void notify(bool loading, String? error) {
    emit(state.copyWith(loading: loading, error: error));
  }

  Future<bool> userLoginSuccessfully() async {
    return true;
  }
}
