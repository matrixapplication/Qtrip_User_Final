
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../data/model/base/api_response.dart';
import '../../../data/model/base/response_model.dart';
import '../../repository/google_repo.dart';
import '../../request_body/address_body.dart';

class GetPlacesUseCase {
  final _tag = 'GetPlacesUseCase';
  final GoogleRepository repository;

  GetPlacesUseCase({required this.repository});
  Future<ResponseModel> call(BuildContext context, String input) async {

    ResponseModel responseModel;
    ApiResponse apiResponse = await repository.searchForPlaces(input: input);
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      try{
        var map = apiResponse.response!.data;
        List<AddressBody> _list = [];

        for(var json in map?["predictions"]){
          _list.add(AddressBody.fromJsonFromGoogle(json));
          // _list.add(AddressBody(title:  json['description'], address:  json['description'],placeId:json['place_id'] ));
        }

        responseModel = ResponseModel(true, 'successful', data: _list);
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


