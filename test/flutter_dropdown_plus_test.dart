import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_dropdown_plus/flutter_dropdown_plus.dart';
import 'package:flutter_dropdown_plus/flutter_dropdown_plus_platform_interface.dart';
import 'package:flutter_dropdown_plus/flutter_dropdown_plus_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockFlutterDropdownPlusPlatform
    with MockPlatformInterfaceMixin
    implements FlutterDropdownPlusPlatform {
  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final FlutterDropdownPlusPlatform initialPlatform =
      FlutterDropdownPlusPlatform.instance;

  test('$MethodChannelFlutterDropdownPlus is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelFlutterDropdownPlus>());
  });

  test('getPlatformVersion', () async {
    FlutterDropdownPlus flutterDropdownPlusPlugin = FlutterDropdownPlus();
    MockFlutterDropdownPlusPlatform fakePlatform =
        MockFlutterDropdownPlusPlatform();
    FlutterDropdownPlusPlatform.instance = fakePlatform;

    expect(await flutterDropdownPlusPlugin.getPlatformVersion(), '42');
  });
}
