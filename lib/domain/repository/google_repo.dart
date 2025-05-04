

import '../../data/model/base/api_response.dart';
import '../request_body/vehicle_body.dart';

abstract class GoogleRepository {

  Future<ApiResponse> searchForPlaces({required String input});
  Future<ApiResponse> getDirection({required VehicleBody body});
  Future<ApiResponse> getPlaceDetails({required String placeId});

}
