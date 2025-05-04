import 'dart:async';
import 'package:dio/dio.dart';
import 'package:q_trip_user/core/routing/navigation_services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../app.dart';
import '../../../core/utils/constants.dart';
import '../../../domain/repository/google_repo.dart';
import '../../../domain/request_body/vehicle_body.dart';
import '../../../domain/logger.dart';
import '../datasource/remote/exception/api_error_handler.dart';
import '../model/base/api_response.dart';
import 'package:uuid/uuid.dart';


class GoogleRepositoryImp implements GoogleRepository {


 static String _tag = 'GoogleRepositoryImp';
 static String _baseUrl = 'https://maps.googleapis.com/maps/api/';
 static String _sessionToken = '12223444';
 static String _basePlacesUrl ='${_baseUrl}place/autocomplete/json';
 static String _baseDirectionUrl ='${_baseUrl}directions/json';
 static String _basePlaceDetailsUrl ='${_baseUrl}place/details/json';



  @override
  Future<ApiResponse> searchForPlaces({required String input}) async {
  // String? country =  WidgetsBinding.instance.window.locale.countryCode;
  // String? locale = await Devicelocale.currentLocale;
  // Locale myLocale = Localizations.localeOf(appContext!);
  // final Locale? locale = CountryCodes.getDeviceLocale();

  final SharedPreferences pref = await SharedPreferences.getInstance();
  String country = pref.getString("country")??'CH';


  try {
      _sessionToken = Uuid().v4();
      String url = "$_basePlacesUrl?input=$input&key=${Constants.kGoogleMapKey}&sessiontoken=$_sessionToken&language=${appContext?.locale.languageCode??'en'}";/*${(locale?.countryCode??'').toLowerCase()*/
      // String url = "$_basePlacesUrl?input=$input&key=${Constants.kGoogleMapKey}&sessiontoken=$_sessionToken&language=${appContext?.locale.languageCode??'en'}&components=country:$country";/*${(locale?.countryCode??'').toLowerCase()*/
      log(_tag, 'url::  $url');
      Response response  = await Dio().get(url);

      log(_tag, 'response::  ${response.data}');

      return ApiResponse.withSuccess(response);
    } catch (e) {

    return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }


  @override
  Future<ApiResponse> getDirection({required VehicleBody body}) async{
    try {
    final lang=  NavigationService.navigationKey.currentContext!.locale.languageCode;
      String url = '$_baseDirectionUrl?origin=${body.from.latitude},${body.from.longitude}&destination=${body.to.latitude},${body.to.longitude}&mode=driving&language=$lang&key=${Constants.kGoogleMapKey}';
      log(_tag, 'getDirection:: response::  $url');

      Response response  =await Dio().get(url);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  @override
  Future<ApiResponse> getPlaceDetails({required String placeId}) async{
    try {
      String url = '$_basePlaceDetailsUrl?placeid=$placeId&key=${Constants.kGoogleMapKey}';
      Response response  =await Dio().get(url);
      log(_tag, 'getPlaceDetails:: response::  ${response.data}');

      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}
