import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'ultrasonic_sensor_method_channel.dart';

abstract class UltrasonicSensorPlatform extends PlatformInterface {
  /// Constructs a UltrasonicSensorPlatform.
  UltrasonicSensorPlatform() : super(token: _token);

  static final Object _token = Object();

  static UltrasonicSensorPlatform _instance = MethodChannelUltrasonicSensor();

  /// The default instance of [UltrasonicSensorPlatform] to use.
  ///
  /// Defaults to [MethodChannelUltrasonicSensor].
  static UltrasonicSensorPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [UltrasonicSensorPlatform] when
  /// they register themselves.
  static set instance(UltrasonicSensorPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
