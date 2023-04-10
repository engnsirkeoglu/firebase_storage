import 'package:device_info_plus/device_info_plus.dart';

mixin AndroidDeviceInfoMixin {
  final DeviceInfoPlugin _deviceInfo = DeviceInfoPlugin();

  Future<int> androidSdkVersion() async {
    AndroidDeviceInfo androidInfo = await _deviceInfo.androidInfo;
    return androidInfo.version.sdkInt;
  }
}
