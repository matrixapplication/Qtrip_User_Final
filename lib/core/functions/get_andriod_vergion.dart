
import 'package:device_info_plus/device_info_plus.dart';

Future<String> getAndroidVersion() async {
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
  return androidInfo.version.release;
}