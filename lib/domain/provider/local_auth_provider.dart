// import 'package:q_trip_user_captain/domain/logger.dart';
// import 'package:q_trip_user_captain/domain/usecase/auth/update_fcm_token_usecase.dart';
// import 'package:q_trip_user_captain/generated/locale_keys.g.dart';
// import 'package:easy_localization/easy_localization.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/widgets.dart';
//
// import '../../core/utils/globals.dart';
// import '../../data/model/base/response_model.dart';
// import '../usecase/auth/delete_account_usecase.dart';
// import '../usecase/local/clear_user_data_usecase.dart';
// import '../usecase/local/get_is_login_usecase.dart';
// import '../usecase/more/get_profile_usecase.dart';
//
// class LocalAuthProvider with ChangeNotifier {
//   final _tag='LocalAuthProvider';
//
//   ///Use Cases
//   final IsUserLoginUseCase _isUserLoginUseCase;
//   final GetProfileUseCase _getProfileUseCase;
//   final DeleteAccountUseCase _deleteAccountUseCase;
//   final ClearUserDataUseCase _clearUserDataUseCase;
//   final UpdateFCMTokenUseCase _updateFCMTokenUseCase;
//
//   LocalAuthProvider({
//     required ClearUserDataUseCase clearUserDataUseCase,
//     required IsUserLoginUseCase isUserLoginUseCase,
//     required GetProfileUseCase getProfileUseCase,
//     required DeleteAccountUseCase deleteAccountUseCase,
//     required UpdateFCMTokenUseCase updateFCMTokenUseCase,
//   })
//       : _clearUserDataUseCase = clearUserDataUseCase,
//         _isUserLoginUseCase = isUserLoginUseCase,
//         _deleteAccountUseCase = deleteAccountUseCase,
//         _updateFCMTokenUseCase = updateFCMTokenUseCase,
//         _getProfileUseCase = getProfileUseCase;
//
//
//
//   ///Variables
//   bool _isLogin =false;
//   bool _loading = false;
//   String? _error;
//
//   ///Getters
//   bool get isAuth => _isLogin;
//   bool get loading => _loading;
//   String? get error => _error;
//
//
//   ///call APIs Functions
//   Future<bool> isLogin() async {
//     ResponseModel responseModel = await _isUserLoginUseCase();
//     if (responseModel.isSuccess) {
//       _isLogin = true;
//       _updateFCMToken();
//       ResponseModel profileResponseModel = await _getCurrentUser();
//       if (!profileResponseModel.isSuccess) {
//         logOut();
//       }
//       return profileResponseModel.isSuccess;
//     } else {
//     }
//     return responseModel.isSuccess;
//   }
//
//   Future<bool> logOut() async {
//     ResponseModel responseModel = await _clearUserDataUseCase();
//     if (responseModel.isSuccess) {
//       FirebaseMessaging.instance.deleteToken();
//       _isLogin = false ;
//        kUser = null ;
//     }
//     return responseModel.isSuccess;
//   }
//
//   Future<ResponseModel> _getCurrentUser() async {
//     log(_tag, 'getUser');
//     notify(true, null);
//
//
//
//     ResponseModel responseModel = await _getProfileUseCase();
//     if (responseModel.isSuccess) {
//       kUser =  responseModel.data;
//       notify(false, null);
//     }else{
//       notify(false, responseModel.message);
//     }
//     return responseModel;
//   }
//
//   Future<ResponseModel> deleteAccount() async {
//     log(_tag, 'deleteAccount');
//     notify(true, null);
//
//
//     ResponseModel responseModel = await _deleteAccountUseCase();
//     if (responseModel.isSuccess) {
//       if (await logOut()) {
//         notify(false, null);
//       }  else{
//         notify(false, tr(LocaleKeys.error));
//       }
//
//
//     }else{
//       notify(false, responseModel.message);
//     }
//     return responseModel;
//   }
//
//   //update fcm token
//   Future<bool> _updateFCMToken() async {
//     String? fcmToken = ''/*await getDeviceToken()*/;
//     if(fcmToken==null)return false;
//     ResponseModel responseModel = await _updateFCMTokenUseCase(fcmToken: fcmToken);
//     return responseModel.isSuccess;
//   }
//
//   ///update screens status Function
//   void notify(bool loading, String? error) {
//     _loading = loading;
//     _error = error;
//     notifyListeners();
//   }
//
//   Future<bool> userLoginSuccessfully()async{
//     _isLogin = true;
//     ResponseModel profileResponseModel = await _getCurrentUser();
//     if (!profileResponseModel.isSuccess) {logOut();}
//     return profileResponseModel.isSuccess;
//   }
//
//
// }
