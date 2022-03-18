//
//  AppPlugin.swift
//  Runner
//
//  Created by Myron on 2021/2/6.
//

import Foundation
import AdSupport
class AppPlugin: NSObject {
    static let shared = AppPlugin()
    var register:FlutterPluginRegistrar?
    func makeConfig(register:FlutterPluginRegistrar?){
        self.register = register;
        methodChannel?.setMethodCallHandler{[weak self] in
            self?.methonCallHander(call: $0, result: $1)
        }
    }
    lazy var methodChannel:FlutterMethodChannel? = {
        if let reg = self.register{
            let channel = FlutterMethodChannel(name: "com.qmstudio.qmlkit", binaryMessenger: reg.messenger())
            return channel
        }
        return Optional.none
    }()
    func methonCallHander(call:FlutterMethodCall,result:@escaping FlutterResult) {
        switch call.method {
        case "device.getInfo":
            getDeviceInfo(result: result);
        default:
            break;
        }
    }
    func getModel()->String{
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
                    return identifier + String(UnicodeScalar(UInt8(value)))
                }
        return  identifier;
    }
    func getDeviceInfo(result:@escaping FlutterResult){
        let device = UIDevice.current;
        let model = device.model ;
        let name = device.name
        let systemName = device.systemName
        let systemVersion = device.systemVersion
        let localizedModel = device.localizedModel
        let info = Bundle.main.infoDictionary;
        let uuid = ASIdentifierManager.shared().advertisingIdentifier.uuidString;

        let appName = info?["CFBundleDisplayName"] ?? "";
        let appVersion = info?["CFBundleShortVersionString"] ?? "";
        let buildVerison = info?["CFBundleVersion"] ?? "";
        
        
        print("name:\(name)  model:\(model)  localizedModel:\(localizedModel)  systemName:\(systemName)  systemVersion:\(systemVersion)  appName:\(appName)  buildVerison:\(buildVerison)  appVersion:\(appVersion)  ")
        result([
            "name":name,
            "localizedModel":localizedModel,
            "model":getModel(),
            "sysVersion":systemVersion,
            "sysName":systemName,
            "brand":"Apple",
            "appName":appName,
            "appVersion":"\(appVersion)+\(buildVerison)",
            "uuid":uuid,
        ]);
    }
}
