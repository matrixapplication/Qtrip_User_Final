

import '../entities/country_entity.dart';

class RegisterBody {
  String? _image;
  String? _name;
  String? _mobile;
  String? _email;
  String _password;
  String _gender;
  CountryEntity?  _country;



  bool _isConfirmTerms;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    (_name ?? '').isNotEmpty ? data['name'] = _name : null;
    (_mobile ?? '').isNotEmpty ? data['mobile_number'] = _mobile : null;
    (_email ?? '').isNotEmpty ? data['email'] = _email : null;
    (_gender ?? '').isNotEmpty ? data['gender'] = _gender : null;

    data['password'] = _password;
    data['country_id'] = _country?.id;

    return data;
  }

  RegisterBody({
    String name = '',
    String? mobile,
    String? email,
    String? image,
    String? gender,

    String password = '',
    CountryEntity? country ,
    String confirmPassword = '',
    bool isConfirmTerms = false,
  })  : _name = name,
        _mobile = mobile,
        _gender =   gender??'male',
        _email = email,
        _image = image,
        _country = country,
        _password = password,
        _isConfirmTerms = isConfirmTerms;

  updateImage(String? image) {_image = image;}

  updateConfirmTerms(bool isConfirmed){_isConfirmTerms =isConfirmed;}
  updateCountry(CountryEntity? entity) {_country = entity;}

  void setData(
      {required String name,
        required String phone,
        required String email,
        required String gender,
        required String password}) {
    _name = name;
    _mobile = phone;
    _gender = gender;
    _email = email;
    _password = password;
  }
  String? get image => _image;
  String? get gender => _gender;

  CountryEntity? get country => _country;
  bool get isConfirmTerms => _isConfirmTerms;
// String? get image => _image;
}
