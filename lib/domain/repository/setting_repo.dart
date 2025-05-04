


import '../../data/model/base/api_response.dart';
import '../request_body/contact_us_request_body.dart';

abstract class SettingRepository {

  Future<ApiResponse> getCities();
  Future<ApiResponse> getCategories();

  Future<ApiResponse> contactUsRequest(ContactUsRequestsBody body);
  Future<ApiResponse> getFQAs();

  Future<ApiResponse> getAbout();
  Future<ApiResponse> getTerms();
  Future<ApiResponse> getPrivacy();
  Future<ApiResponse> getCountries();
}
