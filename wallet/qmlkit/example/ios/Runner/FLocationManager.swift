//
//  FLocationManager.swift
//  Runner
//
//  Created by Myron on 2020/12/24.
//

import Foundation
import CoreLocation

class FLocationManager: NSObject,CLLocationManagerDelegate {
    class Defines{
        static let CHANNEL_NAME = "com.qmstudio.qmlkit.location"
    }
    class MethodName {
        static let ENABLE = "LOCATION_METHOD_NAME_ENABLE";
        static let REQUEST_ENABLE = "LOCATION_METHOD_NAME_REQUEST_ENABLE";
        static let HAS_PERMISSION = "LOCATION_METHOD_NAME_HAS_PERMISSION";
        static let REQUEST_PERMISSION = "LOCATION_METHOD_NAME_REQUEST_PERMISSION";
        static let GET_LOCATION = "LOCATION_METHOD_NAME_GET_LOCATION";
        
        static let DID_GET_LOCATION = "LOCATION_METHOD_NAME_DID_GET_LOCATION";
        static let IS_STARTED = "LOCATION_METHOD_NAME_IS_STARTED";
        static let START = "LOCATION_METHOD_NAME_START";
        static let STOP = "LOCATION_METHOD_NAME_STOP";
    }
    static let shared = FLocationManager()
    
    var register:FlutterPluginRegistrar?
    func makeConfig(register:FlutterPluginRegistrar?){
        print("makeConfig:\(String(describing: register))")
        self.register = register;
        print("makeConfig:\(String(describing: methodChannel))")
        methodChannel?.setMethodCallHandler{[weak self] in
            self?.methonCallHander(call: $0, result: $1)
        }
    }
    lazy var locationManager:CLLocationManager = {
        var locationManager = CLLocationManager()
        locationManager.distanceFilter = 300;
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.delegate = self
        return locationManager
        
    }()
    lazy var methodChannel:FlutterMethodChannel? = {
        if let reg = self.register{
            let channel = FlutterMethodChannel(name: Defines.CHANNEL_NAME, binaryMessenger: reg.messenger())
            return channel
        }
        return Optional.none
    }()
    var reqEnableResult:FlutterResult?
    var reqPermissionResult:FlutterResult?
    var getLocationResult:FlutterResult?
    func methonCallHander(call:FlutterMethodCall,result:@escaping FlutterResult) {
        print("methonCallHander:\(call.method)  arguments:\(String(describing: call.arguments))")
        switch call.method {
        case MethodName.ENABLE:
            let enable = CLLocationManager.locationServicesEnabled()
            result(enable)
            break
        case MethodName.REQUEST_ENABLE:
            let permission = CLLocationManager.authorizationStatus();
            if permission == .authorizedWhenInUse || permission == .authorizedAlways {
                result(true)
            }else{
                reqEnableResult = result
                locationManager.requestWhenInUseAuthorization()
            }
            break
        case MethodName.HAS_PERMISSION:
            let permission = CLLocationManager.authorizationStatus()
            result(permission == .authorizedWhenInUse || permission == .authorizedAlways)
            break
        case MethodName.REQUEST_PERMISSION:
            let permission = CLLocationManager.authorizationStatus();
            if permission == .authorizedWhenInUse || permission == .authorizedAlways {
                result(true)
                return
            }
            reqPermissionResult = result
            locationManager.requestWhenInUseAuthorization()
            break
        case MethodName.GET_LOCATION:
            if isStarted {
                if let info = lastLocationInfo {
                    result(info);
                    return;
                }
            }
            getLocationResult = result
            start()
            break
        case MethodName.IS_STARTED:
            result(isStarted)
            break
        case MethodName.START:
            start()
            break
        case MethodName.STOP:
            stop()
            break
        default:
            break
        }
    }
    var isStarted = false;
    func start()  {
        isStarted = true;
        locationManager.startUpdatingLocation()
    }
    func stop()  {
        locationManager.startUpdatingLocation()
        isStarted = false;
    }
    func authorizationDidChange() {
        var status:CLAuthorizationStatus;
        if #available(iOS 14.0, *) {
            status = locationManager.authorizationStatus
        } else {
            status = CLLocationManager.authorizationStatus()
        }
        if status != .notDetermined {
            reqPermissionResult?(status == .authorizedWhenInUse || status == .authorizedAlways);
            reqPermissionResult = Optional.none;
            reqEnableResult?(status == .authorizedWhenInUse || status == .authorizedAlways);
            reqEnableResult = Optional.none;
        }
    }
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        authorizationDidChange()
    }
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus){
        authorizationDidChange()
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        stop();
        getLocationResult?(Optional.none)
        getLocationResult = Optional.none
    }
    var lastLocationInfo:[String:Any]?
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if locations.count>0 {
            var map:[String:Any] = [:];
            let location  = locations[0];
            let lat = location.coordinate.latitude;
            let lng = location.coordinate.longitude;
            map["latitude"] = lat;
            map["longitude"] = lng;
            let geocoder = CLGeocoder()
            geocoder.reverseGeocodeLocation(location) { [weak self](res:[CLPlacemark]?, _) in
                if (res ?? []).count > 0{
                    let place = res![0];
                    let addressInfo = place.addressDictionary;
                    let province = addressInfo?["State"] as? String ?? "";
                    let city = addressInfo?["City"] as? String ?? "";
                    let area = addressInfo?["SubLocality"] as? String ?? "";
                    let name = addressInfo?["Name"] as? String ?? "";
                    map["province"] = province;
                    map["city"] = city;
                    map["area"] = area;
                    map["detailAddress"] = name;
                    map["fullAddress"] = province + city + area + name;
                }
                self?.lastLocationInfo = map;
                self?.getLocationResult?(map)
                self?.getLocationResult = Optional.none
                self?.methodChannel?.invokeMethod(MethodName.DID_GET_LOCATION, arguments: map)
            }
        }
    }
}

