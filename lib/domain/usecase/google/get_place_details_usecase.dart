
import '../../../data/model/base/api_response.dart';
import '../../../data/model/base/base_model.dart';
import '../../../data/model/base/response_model.dart';
import '../../../data/model/response/place_details_model.dart';
import '../../repository/address_repo.dart';
import '../../repository/google_repo.dart';
import '../../request_body/address_body.dart';
import '../base_usecase/base_use_case_call.dart';
import '../base_usecase/base_usecase.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';


class GetPlaceDetailsUseCase {
  final _tag = 'GetPlaceDetailsUseCase';
  final GoogleRepository repository;

  GetPlaceDetailsUseCase({required this.repository});
  Future<ResponseModel> call( {required String placeId}) async {

    ResponseModel responseModel;
    ApiResponse apiResponse = await repository.getPlaceDetails(placeId: placeId);
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      try{
        PlaceDetails placeDetails = PlaceDetails.fromJson(apiResponse.response!.data);
        LatLng  latLng = LatLng(placeDetails.result!.geometry!.location!.lat!, placeDetails.result!.geometry!.location!.lng!);
        AddressBody body = AddressBody(title: placeDetails.result!.formattedAddress!, address: placeDetails.result!.formattedAddress!,latLng:latLng );
        responseModel = ResponseModel(true, 'successful', data: body);
      } catch (e) {
        responseModel = ResponseModel(false, 'error');
      }
    } else {
      if (apiResponse.response?.data["error_message"] != null) {
        var error = apiResponse.response?.data["error_message"];
        if (error == "This API project is not authorized to use this API.") error += " Make sure the Places API is activated on your Google Cloud Platform";
        responseModel = ResponseModel(false, error);
      } else {
        responseModel =
            ResponseModel(false, apiResponse.response?.data["error_message"]);
      }
    }
    return responseModel;
  }
}
