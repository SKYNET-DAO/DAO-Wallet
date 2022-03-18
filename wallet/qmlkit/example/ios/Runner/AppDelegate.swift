import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    let register:FlutterPluginRegistrar? = registrar(forPlugin: "QMStudio");
    FLocationManager.shared.makeConfig(register: register);
    AppPlugin.shared.makeConfig(register: register)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
