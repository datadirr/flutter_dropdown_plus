import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'flutter_dropdown_plus_method_channel.dart';

abstract class FlutterDropdownPlusPlatform extends PlatformInterface {
  /// Constructs a FlutterDropdownPlusPlatform.
  FlutterDropdownPlusPlatform() : super(token: _token);

  static final Object _token = Object();

  static FlutterDropdownPlusPlatform _instance =
      MethodChannelFlutterDropdownPlus();

  /// The default instance of [FlutterDropdownPlusPlatform] to use.
  ///
  /// Defaults to [MethodChannelFlutterDropdownPlus].
  static FlutterDropdownPlusPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [FlutterDropdownPlusPlatform] when
  /// they register themselves.
  static set instance(FlutterDropdownPlusPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
