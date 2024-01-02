import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'ultrasonic_sensor_platform_interface.dart';

/// An implementation of [UltrasonicSensorPlatform] that uses method channels.
class MethodChannelUltrasonicSensor extends UltrasonicSensorPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('ultrasonic_sensor');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
