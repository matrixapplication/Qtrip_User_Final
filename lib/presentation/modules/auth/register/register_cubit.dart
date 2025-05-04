import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:meta/meta.dart';
import '../../../../data/model/base/response_model.dart';
import 'package:q_trip_user/domain/request_body/register_body.dart';
import '../../../../domain/entities/country_entity.dart';
import '../../../../domain/usecase/auth/register_usecase.dart';
import '../../../../domain/usecase/local/save_data_usecase.dart';
import '../../../../generated/locale_keys.g.dart';


part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final _tag = 'RegisterViewModelCubit';
  final RegisterUseCase _registerUseCase;
  final SaveUserDataUseCase _saveUserDataUseCase;

  RegisterCubit({
    required RegisterUseCase registerUseCase,
    required SaveUserDataUseCase saveUserDataUseCase,
  })  : _registerUseCase = registerUseCase,
        _saveUserDataUseCase = saveUserDataUseCase, super(RegisterInitial());

  ///variables
  final RegisterBody _body =RegisterBody();
  String? _termsError;
  String? _countryError;

  ///getters
  RegisterBody get body => _body;
  String? get termsError => _termsError;
  String? get countryError => _countryError;


  ///update data
  //on accept or reject privacy and policy
  onChangeTerms(bool isConfirmed) {_body.updateConfirmTerms(isConfirmed);emit(RegisterInitial()); _termsError=null;emit(RegisterInitial());}
  //on update profile image
  onAttachImage(String? path) {_body.updateImage(path);emit(RegisterInitial());}
  //on update Country
  onCountry(CountryEntity entity  ){_body.updateCountry(entity);checkCountry();}


  bool checkCountry() {
    if (_body.country == null) {
      _countryError = tr(LocaleKeys.countryIsRequired);
    } else {
      _countryError = null;
    }
    emit(RegisterInitial());
    return _body.country != null;
  }

  bool checkTermsError(){
    if(_body.isConfirmTerms){
      _termsError=null;
      emit(RegisterInitial());
      return true;
    }else{
      _termsError = 'error';
      emit(RegisterInitial());
      return false;
    }
  }
  ///colling api functions
  //register user
  Future<ResponseModel> register(
      {required String name,
      required String phone,
      required String email,
      required String gender,
      required String password}) async {
    emit(RegisterLoading());
    _assignBody(name: name, phone: phone, email: email, password: password, gender: gender);
    ResponseModel responseModel = await _registerUseCase(body: _body);
    if (responseModel.isSuccess) {
      emit(RegisterSuccessfully());
    } else {
      emit(RegisterInitial());
    }

    return responseModel;
  }

  ///set user data
  void _assignBody( {
    required String name,
    required String phone,
    required String email,
    required String password,
    required String gender,
  }) {
    _body.setData(name: name,  phone: phone, email: email, password: password, gender: gender);
  }

}
