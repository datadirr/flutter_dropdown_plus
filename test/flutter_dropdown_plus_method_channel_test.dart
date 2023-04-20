import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_dropdown_plus/flutter_dropdown_plus_method_channel.dart';

void main() {
  MethodChannelFlutterDropdownPlus platform =
      MethodChannelFlutterDropdownPlus();
  const MethodChannel channel = MethodChannel('flutter_dropdown_plus');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await platform.getPlatformVersion(), '42');
  });
}
