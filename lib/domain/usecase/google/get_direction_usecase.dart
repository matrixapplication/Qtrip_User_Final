
import '../../../data/model/base/api_response.dart';
import '../../../data/model/base/base_model.dart';
import '../../../data/model/base/response_model.dart';
import '../../entities/direction_details_entity.dart';
import '../../repository/address_repo.dart';
import '../../repository/google_repo.dart';
import '../../request_body/vehicle_body.dart';
import '../base_usecase/base_use_case_call.dart';
import '../base_usecase/base_usecase.dart';


class GetDirectionUseCase {
  final _tag = 'GetDirectionUseCase';
  final GoogleRepository repository;

  GetDirectionUseCase({required this.repository});
  Future<ResponseModel<DirectionDetailsEntity>> call( {required VehicleBody body}) async {
    ResponseModel<DirectionDetailsEntity> responseModel;
    ApiResponse apiResponse = await repository.getDirection(body: body);

    if (apiResponse.response?.data["error_message"] != null) {
      var error = apiResponse.response?.data["error_message"];
      if (error == "This API project is not authorized to use this API.") error += " Make sure the Places API is activated on your Google Cloud Platform";
      throw Exception(error);
    }else {


      DirectionDetailsEntity entity = DirectionDetailsEntity(
        distanceText: apiResponse.response?.data['routes'][0]['legs'][0]['distance']['text'] ?? '0',
        distanceValue: apiResponse.response?.data['routes'][0]['legs'][0]['distance']['value'] ?? 0,
        durationText:  apiResponse.response?.data['routes'][0]['legs'][0]['duration']['text'] ?? '0',
        durationValue: apiResponse.response?.data['routes'][0]['legs'][0]['duration']['value'] ?? 0,
        encodedPoints: apiResponse.response?.data['routes'][0]['overview_polyline']['points']
      );

      responseModel = ResponseModel(true, 'successful', data: entity);
    }

    return responseModel;
  }
}


