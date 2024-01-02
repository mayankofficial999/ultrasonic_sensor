import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ultrasonic_sensor/ultrasonic_sensor_method_channel.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  MethodChannelUltrasonicSensor platform = MethodChannelUltrasonicSensor();
  const MethodChannel channel = MethodChannel('ultrasonic_sensor');

  setUp(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(
      channel,
      (MethodCall methodCall) async {
        return '42';
      },
    );
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(channel, null);
  });

  test('getPlatformVersion', () async {
    expect(await platform.getPlatformVersion(), '42');
  });
}
