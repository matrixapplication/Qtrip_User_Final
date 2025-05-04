import 'package:firebase_database/firebase_database.dart';
import '../../data/model/base/api_response.dart';
import '../../data/model/response/payment_params.dart';
import '../request_body/rate_body.dart';
import '../request_body/request_body.dart';
import '../request_body/vehicle_body.dart';

abstract class TripRepository {

  Future<ApiResponse> getVehicles({required VehicleBody body});
  Future<ApiResponse> storeTrip({required RequestBody body});
  Stream<DatabaseEvent> getMyLiveTrip({required String tripId});
  Stream<DatabaseEvent> getMyLiveTrips();
  Stream<DatabaseEvent> getMyLiveDriver({required String driverId});
  Stream<DatabaseEvent> getMyOffersTrip({required String tripId});
  Future<ApiResponse> cancelTrip({required String tripId,required int reasonId});
  Future<ApiResponse> acceptTrip({required String tripId,required String driverId,required String price});
  Future<ApiResponse> getCancelReasons();
  Future<ApiResponse> paymentTrip({required PaymentParams params});
  Future<ApiResponse> getLastTrip();
  Future<ApiResponse> getDestinationTrip({required String tripId ,required String captainId});
  Future<ApiResponse> rateTrip({required RateBody rateBody});
  Future<ApiResponse> reportTrip({required RateBody rateBody});
  Future<ApiResponse> getTrips({ DateTime? date});

}
