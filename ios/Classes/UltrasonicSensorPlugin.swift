import Flutter
import UIKit
import AVFoundation


public class UltrasonicSensorPlugin: NSObject, FlutterPlugin {
  var demo: AudioAnalyzer?
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "ultrasonic_sensor", binaryMessenger: registrar.messenger())
    let instance = UltrasonicSensorPlugin()
    instance.demo = AudioAnalyzer()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
    case "getPlatformVersion":
      result("iOS " + UIDevice.current.systemVersion)
      break
    case "getReadings":
      result("\(demo!._maxFrequency),\(demo!._maxMagnitude)")
      break
    default:
      result(FlutterMethodNotImplemented)
    }
  }
}
