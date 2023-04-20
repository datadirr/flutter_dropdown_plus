import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'flutter_dropdown_plus_platform_interface.dart';

/// An implementation of [FlutterDropdownPlusPlatform] that uses method channels.
class MethodChannelFlutterDropdownPlus extends FlutterDropdownPlusPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('flutter_dropdown_plus');

  @override
  Future<String?> getPlatformVersion() async {
    final version =
        await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
