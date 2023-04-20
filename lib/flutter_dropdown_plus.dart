import 'flutter_dropdown_plus_platform_interface.dart';

class FlutterDropdownPlus {
  Future<String?> getPlatformVersion() {
    return FlutterDropdownPlusPlatform.instance.getPlatformVersion();
  }
}
