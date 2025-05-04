import '../entities/country_entity.dart';

class LoginBody{
  String _phone;
  CountryEntity? _country;
  String _password;
  String _deviceToken;

  LoginBody({
    required String phone,
    CountryEntity? countryEntity ,
    required String password,
    required String deviceToken,
  })  : _phone = phone,
        _password = password,
        _deviceToken = deviceToken;




  String get deviceToken => _deviceToken;
  String get password => _password;
  String get phone => _phone;

  CountryEntity? get country => _country;

  Map<String, dynamic> toJson() {
    return {
      "mobile_number": _phone,
      "password": _password,
      "country_id": _country?.id,
      "fcm_token": _deviceToken,
    };
  }
  setData({
    required String phone,
    required String password,
    required String deviceToken,
  }){
    _phone = phone;
    _password = password;
    _deviceToken = deviceToken;
  }

  updateCountry(CountryEntity entity)=>
      _country = entity;
}
