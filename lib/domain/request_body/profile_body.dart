import 'package:easy_localization/easy_localization.dart';

import '../../core/utils/globals.dart';
import '../../generated/locale_keys.g.dart';
import '../../presentation/component/inputs/phone_country/countries.dart';
import '../../presentation/component/selector/gender_selector_widget.dart';
import '../entities/country_entity.dart';
import '../entities/drop_down_entity.dart';


class ProfileBody {
  String? _image;
  String? _name;
  String? _mobile;
  String? _email;
  GenderType _gender;
  CountryEntity?  _country;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    (_name ?? '').isNotEmpty ? data['name'] = _name : null;
    (_mobile ?? '').isNotEmpty ? data['mobile'] = _mobile : null;
    (_email ?? '').isNotEmpty ? data['email'] = _email : null;
     data['gender'] = _gender==GenderType.female?'female':'male';

    data['country_id'] = _country?.id;
    data['country_code'] = _country?.code;


    return data;
  }

  ProfileBody({
    String name = '',
    String? mobile,
    String? email,
    String? image,
    CountryEntity? country ,
   required GenderType gender ,
  })  : _name = name,
        _image = image,
        _mobile = mobile,
        _gender = gender,
        _email = email,
        _country = country;

  updateImage(String? image) {_image = image;}
  updateGender(GenderType gender) {
    _gender = gender;
  }


  updateCountry(CountryEntity? entity) {_country = entity;}


  void setData(
      {required String name, required String phone, required String email}) {
    _name = name;
    _mobile = phone;
    _email = email;
  }

  CountryEntity? get country => _country;
  String? get image => _image;
  String? get email => _email;
  String? get mobile => _mobile;
  String? get name => _name;
  GenderType get gender => _gender;

  static ProfileBody init() => ProfileBody(
        country: kUser?.country,
        // country: countries.firstWhere((country) => kUser?.countryCode == country.dialCode, orElse: () => _countryEg),
        email: kUser?.email,
        gender: kUser?.gender=='female'?GenderType.female:GenderType.male,
        image: kUser?.image,
        mobile: kUser?.mobile,
        name: kUser?.name ?? '',
      );
}
