
import '../../data/app_urls/app_url.dart';

class Constants {
  static const String empty = "";
  static const int connectTimeout = 30000;

  static const String  kGoogleMapKey= 'AIzaSyDQgLpPTFBKVjLvIGeoRWx1pK2mX-OncCk';
  // static const String  kGoogleMapKey= 'AIzaSyB-uADMlF6PqwccIr3q6Vpyl0wJgJNsxOM';


}
double convertToDouble(var d) => d / 1 ;

String convertListToString(List<String?> list) =>list.join(',');

enum ShareType{ event , group }
enum AddressType{ home , work, favorite }
enum UpdatePlace { from, to }

enum UpdateTripStatus {arrived,start,end,endDone}

const double kZoomCamera = 14.0; // for camera using
const double kTiltCamera = 50; // for camera using