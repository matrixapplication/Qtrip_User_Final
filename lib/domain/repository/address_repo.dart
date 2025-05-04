
import '../../data/model/base/api_response.dart';
import '../request_body/address_body.dart';

abstract class AddressRepository {

  Future<ApiResponse> getAddresses();
  Future<ApiResponse> storeAddress({required AddressBody body});
  Future<ApiResponse> updateAddress({required AddressBody body});
  Future<ApiResponse> deleteAddress({required int addressId});



}
