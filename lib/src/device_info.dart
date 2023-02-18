
import 'package:device_info_plus/device_info_plus.dart';

class DeviceInfo {
  static Future<AndroidDeviceInfo> fetchAndroid() async {
    DeviceInfoPlugin plugin = DeviceInfoPlugin();
    return plugin.androidInfo;
  }

  static Future<IosDeviceInfo> fetchIos() async {
    DeviceInfoPlugin plugin = DeviceInfoPlugin();
    return plugin.iosInfo;
  }

  static Future<WebBrowserInfo> fetchWeb() async {
    DeviceInfoPlugin plugin = DeviceInfoPlugin();
    return plugin.webBrowserInfo;
  }

  static Future<WindowsDeviceInfo> fetchWindows() async {
    DeviceInfoPlugin plugin = DeviceInfoPlugin();
    return plugin.windowsInfo;
  }
}
