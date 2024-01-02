import 'package:flutter_test/flutter_test.dart';
import 'package:ultrasonic_sensor/ultrasonic_sensor.dart';
import 'package:ultrasonic_sensor/ultrasonic_sensor_platform_interface.dart';
import 'package:ultrasonic_sensor/ultrasonic_sensor_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockUltrasonicSensorPlatform
    with MockPlatformInterfaceMixin
    implements UltrasonicSensorPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final UltrasonicSensorPlatform initialPlatform = UltrasonicSensorPlatform.instance;

  test('$MethodChannelUltrasonicSensor is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelUltrasonicSensor>());
  });

  test('getPlatformVersion', () async {
    UltrasonicSensor ultrasonicSensorPlugin = UltrasonicSensor();
    MockUltrasonicSensorPlatform fakePlatform = MockUltrasonicSensorPlatform();
    UltrasonicSensorPlatform.instance = fakePlatform;

    expect(await ultrasonicSensorPlugin.getPlatformVersion(), '42');
  });
}
