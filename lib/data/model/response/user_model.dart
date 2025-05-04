
import 'package:q_trip_user/domain/entities/country_entity.dart';
import 'package:q_trip_user/domain/entities/user_entity.dart';

import 'country_model.dart';
import 'driver_state_model.dart';



class UserModel extends UserEntity{

  const UserModel({
    required int id,
    required String name,
    required String mobile,
    required String email,
    required String gender,
    required String deliveryType,
    required bool isOnline,
    required CountryEntity? country,
    required String accessToken,
    required String status,
    required String image,
     dynamic rate,
    required List<String> driverLicenseImages,
    required List<String> nationalIdImages,
    required String driverLicenseDueDate,
    required String driverLicenseNumber,
    required DriverStateModel driverStateModel,
  }) : super(
      id : id,
      name : name,
      mobile : mobile,
      email : email,
      rate : rate,
      driverLicenseDueDate : driverLicenseDueDate,
      driverLicenseNumber : driverLicenseNumber,
      nationalIdImages : nationalIdImages,
      driverLicenseImages : driverLicenseImages,
      isOnline : isOnline,
      country : country,
      gender : gender,
      deliveryType : deliveryType,
      image : image,
      status : status,
      driverStateEntity : driverStateModel,
      accessToken : accessToken);



  factory UserModel.fromJson(Map<String, dynamic>? json ) {
    return UserModel(
      id: json?["id"] ?? 0,
      name: json?["name"] ?? '',
      isOnline: (json?["is_online"] ?? "no") == 'yes',
      gender: json?["gender"] ?? '',
      deliveryType: json?["driver_type"] ?? '',
      rate: json?["rate"] ?? '0',

      driverLicenseDueDate: json?["driver_license_due_date"]??'',
      driverLicenseNumber: json?["driver_license_number"]??'',
      driverLicenseImages: List<String>.from((json?["driver_license_image"]??[]).map((x) => x)),
      nationalIdImages: List<String>.from((json?["national_id_image"]??[]).map((x) => x)),

      mobile: json?["mobile_number"] ?? '',
      email: json?["email"] ?? '',
      accessToken: json?["token"].toString() ?? '',
      image: json?["image"] ?? '',
      status: json?["status"] ?? '',
      driverStateModel: DriverStateModel.fromJson(json?["stats"] ),
      country: CountryModel.fromJson(json?["country"] ),
    );
  }

}
