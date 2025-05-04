import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:meta/meta.dart';
import 'package:q_trip_user/core/utils/show_toast.dart';
import 'package:q_trip_user/data/datasource/remote/exception/error_widget.dart';
import '../../../../core/notification/device_token.dart';
import '../../../../domain/entities/country_entity.dart';
import '../../../../domain/usecase/auth/send_otp_usecase.dart';
import '../../../../domain/usecase/auth/sign_in_usecase.dart';
import '../../../../domain/usecase/local/save_data_usecase.dart';
import 'package:q_trip_user/core/utils/globals.dart';
import 'package:q_trip_user/domain/request_body/login_body.dart';
import 'package:q_trip_user/domain/entities/user_entity.dart';

import '../../../../data/model/base/response_model.dart';
import '../../../../generated/locale_keys.g.dart';


part 'login_state.dart';

class LoginViewModel extends Cubit<LoginViewModelState> {


  final SignInUseCase _signInUseCase ;
  final SaveUserDataUseCase _saveUserDataUseCase ;
 final SendOtpUseCase sendOtpUseCase;

  LoginViewModel({
    required this.sendOtpUseCase,
    required SignInUseCase signInUseCase,
    required SaveUserDataUseCase saveUserDataUseCase,
  })  : _signInUseCase = signInUseCase,
        _saveUserDataUseCase = saveUserDataUseCase, super(LoginViewInitial());



  ///variables
  final LoginBody _body = LoginBody(phone: "", password: "", deviceToken: '');
  String? _countryError;

  ///getters
  LoginBody get body => _body;
  String? get countryError => _countryError;

  onCountry(CountryEntity entity  ){
    _body.updateCountry(entity);
    checkCountry();
  }


  bool checkCountry() {
    if (_body.country == null) {
      _countryError = tr(LocaleKeys.countryIsRequired);
    } else {
      _countryError = null;
    }
    emit(LoginViewInitial());
    return _body.country != null;
  }

 Future<ResponseModel?> sendOtp({required String phone})async{
  try{
    emit(SendOtpLoading());
    final res =await sendOtpUseCase.call(phone: phone);
    if(res.isSuccess){
      showToast(text: '${res.message}');
      emit(SendOtpSuccess());
    }else{
      emit(SendOtpError());

    }
    return res;
  }catch(e){
    emit(SendOtpError());
  }
 }

  ///calling APIs Functions
  Future<ResponseModel> login(String phone, String password) async {
    String? fcmToken= await getDeviceToken();
    if(fcmToken==null){
      return ResponseModel(false, tr(LocaleKeys.error));
    }
    emit(LoginViewLoading()) ;

    _assignLoginBody(phone, password, fcmToken);
    ResponseModel responseModel = await _signInUseCase(loginBody: body);
    if (responseModel.isSuccess) {
      UserEntity userEntity = responseModel.data;
      kUser = userEntity;
      String token = userEntity.accessToken;
      if (token.isNotEmpty) {
        await _saveUserDataUseCase(token: token);
      }
      emit(LoginViewSuccessfully()) ;

    }else{
      emit(LoginViewError(error: responseModel.error)) ;
    }


    return responseModel;
  }

  void _assignLoginBody(String userName,String password,String fcmToken) {
    body.setData(phone: userName, password: password, deviceToken: fcmToken);
  }

}
