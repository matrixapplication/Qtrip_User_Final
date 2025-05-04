


import '../../data/model/base/api_response.dart';
import '../request_body/profile_body.dart';

abstract class ProfileRepository {

  Future<ApiResponse> getProfile();
  Future<ApiResponse> updateProfile({required ProfileBody profileBody});
  Future<ApiResponse> updateStatus();
  Future<ApiResponse> updateProfileImage({required String path});
}
