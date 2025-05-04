


import '../entities/country_entity.dart';

enum CheckOTPType { register , reset ,login}

class CheckOTPBody {
  final String _phone;
  // final CountryEntity _countryEntity;
  final String _otp;
  final CheckOTPType _type;

  const CheckOTPBody({
    required String phone,
    // required CountryEntity countryEntity,
    required String otp,
    required CheckOTPType type,
  })  : _phone = phone,
        // _countryEntity = countryEntity,
        _otp = otp,
        _type = type;


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['mobile_number'] = _phone;
    // data['country_id'] = _countryEntity.id;
    data['otp'] = _otp;
    data['type'] = _type.name;
    return data;
  }
}