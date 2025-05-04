import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:meta/meta.dart';
import 'package:q_trip_user/core/utils/validators.dart';
import 'package:q_trip_user/domain/entities/drop_down_entity.dart';
import 'package:q_trip_user/domain/entities/user_entity.dart';

import '../../../../core/utils/alerts.dart';
import '../../../../core/utils/globals.dart';
import '../../../../data/model/base/response_model.dart';
import '../../../../domain/entities/country_entity.dart';
import '../../../../domain/request_body/profile_body.dart';
import '../../../../domain/usecase/local/save_data_usecase.dart';
import '../../../../domain/usecase/profile/update_profile_image_usecase.dart';
import '../../../../domain/usecase/profile/update_profile_usecase.dart';
import '../../../../generated/locale_keys.g.dart';
import '../../../component/inputs/phone_country/countries.dart';
import '../../../component/selector/gender_selector_widget.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {

  final UpdateProfileUseCase _updateProfileUseCase;
  final UpdateProfileImageUseCase _updateProfileImageUseCase ;

  ProfileCubit({
    required UpdateProfileUseCase updateProfileUseCase,
    required UpdateProfileImageUseCase updateProfileImageUseCase,
  })  : _updateProfileUseCase = updateProfileUseCase,
        _updateProfileImageUseCase = updateProfileImageUseCase,
        super(ProfileInitial());

  ///variables
  final ProfileBody _body = ProfileBody.init();
  String? _countryError;

  ///getters
  ProfileBody get body => _body;
  String? get countryError => _countryError;


  ///update data
  //on update profile image
  onAttachImage(String? path) {_body.updateImage(path);emit(ProfileInitial());}
  //on update Country
  onCountry(CountryEntity entity  ){_body.updateCountry(entity);checkCountry();}

  onGenderChange(GenderType gender){_body.updateGender(gender); emit(ProfileInitial());}
  // onDeliveryTypeChange(DropDownEntity deliveryType){_body.updateDeliveryType(deliveryType); emit(ProfileInitial());}


  bool checkCountry() {
    if (_body.country == null) {
      _countryError = tr(LocaleKeys.countryIsRequired);
    } else {
      _countryError = null;
    }
    emit(ProfileInitial());
    return _body.country != null;
  }


  ///calling APIs Functions
  Future<ResponseModel> updateProfile(
      {required String name,
      required String phone,
      required String email}) async {
    emit(ProfileLoading());

    _assignBody(name: name, phone: phone, email: email);
    // body.updateDeliveryType(const DropDownEntity(id: 0, title: 'Trip'));

    ResponseModel<UserEntity> responseModel = await _updateProfileInfo();
    if (_body.image != null && !Validators.isURL(_body.image))
    { await _updateProfileImage();}
    Alerts.showSnackBar(responseModel.message??'',alertsType: AlertsType.success);

    emit(ProfileInitial());
    return responseModel;
  }

  Future<ResponseModel<UserEntity>> _updateProfileInfo() async {
    final res = await _updateProfileUseCase(body: _body);
    kUser =res.data;
    emit(ProfileSuccess2());
    return res;
  }
  ///calling APIs Functions
  Future<bool?> _updateProfileImage() async {
    print('sdfdsafsdfsdf _updateProfileImage');
    final res= await _updateProfileImageUseCase(path: _body.image!);
    print('res _updateProfileImageres.data ${res.data}');

    kUser =res.data;
    print('res _updateProfileImage ${kUser.toString()}');

    emit(ProfileLoading2());
    // try{
    //   final res= await _updateProfileImageUseCase(path: _body.image!);
    //   if(res.isSuccess){
    //     kUser =res.data;
    //     emit(ProfileSuccess2());
    //     return true;
    //   }else{
    //     emit(ProfileError2());
    //     return false;
    //
    //   }
    // }catch(e){
    //   emit(ProfileError2());
    //   return false;
    // }
  }

  ///set user data
  void _assignBody( {required String name, required String phone, required String email,}) {_body.setData(name: name,  phone: phone, email: email);}
}
