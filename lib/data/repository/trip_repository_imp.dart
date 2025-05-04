import 'dart:async';
import 'package:dio/dio.dart';
import 'package:firebase_database/firebase_database.dart';
import '../../../domain/repository/trip_repo.dart';
import '../../../domain/request_body/rate_body.dart';
import '../../../domain/request_body/request_body.dart';
import '../../../domain/request_body/vehicle_body.dart';
import '../app_urls/app_url.dart';
import '../datasource/remote/dio/dio_client.dart';
import '../datasource/remote/exception/api_error_handler.dart';
import '../model/base/api_response.dart';
import '../model/response/payment_params.dart';



class TripRepositoryImp implements TripRepository {

  final DioClient _dioClient;
   final DatabaseReference  _referenceDriver;
   final DatabaseReference  _reference;
   final DatabaseReference  _referenceOffers;
  TripRepositoryImp({
    required DioClient dioClient,
  })  : _dioClient = dioClient,
        _reference = FirebaseDatabase.instance.ref().child('trips'),
        _referenceOffers = FirebaseDatabase.instance.ref().child('trip_offers'),
        _referenceDriver = FirebaseDatabase.instance.ref().child('drivers');
  @override
  Future<ApiResponse> getTrips({ DateTime? date}) async {
    try {
      Response response = await _dioClient.get(AppURL.kGetTripsURL,queryParameters: {'date':date});
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  @override
  Future<ApiResponse> getVehicles({required VehicleBody body}) async {
    try {
      Response response = await _dioClient.get(AppURL.kGetVehiclesURL,queryParameters: body.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
  @override
  Future<ApiResponse> storeTrip({required RequestBody body}) async {
    try {
      Response response = await _dioClient.post(AppURL.kStoreTripURL,queryParameters: body.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  @override
  Future<ApiResponse> cancelTrip({required String tripId,required int reasonId}) async {
    try {
      Response response = await _dioClient.post(AppURL.kCancelTripURL,queryParameters:{'trip_id':tripId,'reason_id':reasonId});
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
  @override
  Future<ApiResponse> getCancelReasons() async {
    try {
      Response response = await _dioClient.get(AppURL.kGetCancelReasonsURL);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }


  @override
  Stream<DatabaseEvent> getMyLiveDriver({required String driverId}) =>_referenceDriver.child(driverId).onValue;


  @override
  Stream<DatabaseEvent> getMyLiveTrip({required String tripId}) =>_reference.child(tripId).onValue;

  @override
  Stream<DatabaseEvent> getMyLiveTrips() =>_reference.onValue;

  @override
  Future<ApiResponse> rateTrip({required RateBody rateBody}) async {

    try {
      Response response = await _dioClient.post(AppURL.kRateTripURL,queryParameters: rateBody.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  @override
  Future<ApiResponse> getLastTrip() async {
    try {
      Response response = await _dioClient.get(AppURL.kGetLastTripURL);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  @override
  Future<ApiResponse> paymentTrip({required PaymentParams params}) async{
    try {
      Response response = await _dioClient.post(AppURL.kPaymentTripURL,queryParameters: params.toMap());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  @override
  Future<ApiResponse> reportTrip({required RateBody rateBody}) async{
    try {
      Response response = await _dioClient.post(AppURL.kReportTripURL,queryParameters: rateBody.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  @override
  Stream<DatabaseEvent> getMyOffersTrip({required String tripId}) =>_referenceOffers.child(tripId).onValue;

  @override
  Future<ApiResponse> acceptTrip({required String tripId, required String driverId, required String price}) async{
    try {
      Response response = await _dioClient.post(AppURL.kAcceptTripURL,queryParameters: {
        'trip_id':tripId,
        'driver_id':driverId,
        'price':price,
      });
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  @override
  Future<ApiResponse> getDestinationTrip({required String tripId, required String captainId})async {
    try {
      Response response = await _dioClient.post(AppURL.kGetDestanceTripURL,queryParameters: {
        'trip_id':tripId,
        'provider_id':captainId,
      });
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }







}
