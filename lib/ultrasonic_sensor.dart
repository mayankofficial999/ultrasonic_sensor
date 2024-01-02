
import 'ultrasonic_sensor_platform_interface.dart';

class UltrasonicSensor {
  Future<String?> getPlatformVersion() {
    return UltrasonicSensorPlatform.instance.getPlatformVersion();
  }
}
