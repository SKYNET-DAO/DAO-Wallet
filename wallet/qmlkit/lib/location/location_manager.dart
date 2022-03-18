import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qmlkit/event/event_bus.dart';
import 'package:qmlkit/location/location_defines.dart';

import 'location.dart';

class LocationManager {
  static bool _hasRequestPermission = false;
  static bool _hasRequestEnable = false;

  static String _msg = "";

  static Location? _location;
  static void Function(Location)? _onGetLocation;
  static MethodChannel _channel = MethodChannel(LocationDefines.CHANNEL_NAME)
    ..setMethodCallHandler(LocationManager._methodCallHandler);

  static set onGetLocation(void Function(Location) value) =>
      _onGetLocation = value;
  static Location? get location => _location;
  static Future<bool> Function() willResquestEnable = () async => true;
  static Future<bool> Function() willResquestPermission = () async => true;

  static Future<bool> get enabled async {
    try {
      return await _channel.invokeMethod(MethodName.ENABLE);
    } catch (e) {}
    return false;
  }

  static Future<bool> requestEnabled({bool force = false}) async {
    if (_hasRequestEnable && !force) return false;
    _hasRequestEnable = true;
    try {
      debugPrint("requestEnabled");
      return await _channel.invokeMethod(MethodName.REQUEST_ENABLE);
    } catch (e) {}
    return false;
  }

  static Future<bool> get hasPermission async {
    try {
      return await _channel.invokeMethod(MethodName.HAS_PERMISSION);
    } catch (e) {}
    return false;
  }

  static Future<bool> requestPermission({bool force = false}) async {
    if (_hasRequestPermission && !force) return false;
    _hasRequestPermission = true;
    try {
      return await _channel.invokeMethod(MethodName.REQUEST_PERMISSION);
    } catch (e) {}
    return false;
  }

  static Future<bool> isStarted() async {
    try {
      return await _channel.invokeMethod(MethodName.IS_STARTED);
    } catch (e) {}
    return false;
  }

  static Future start() async {
    try {
      await _channel.invokeMethod(MethodName.START);
    } catch (e) {}
  }

  static Future stop() async {
    try {
      await _channel.invokeMethod(MethodName.STOP);
    } catch (e) {}
  }

  static Future<Location?> _getLocation({bool force = false}) async {
    try {
      bool _enable = await enabled;
      if (!_enable) {
        if (await willResquestEnable.call()) {
          debugPrint("请求开启定位");
          await requestEnabled(force: force);
          _enable = await enabled;
        }
      }
      if (!_enable) {
        _msg = "location unable";
        print("location:$_msg");
        _didGetLocationFuture = null;
        return null;
      }
      debugPrint("开启定位成功");
      bool _hasPermission = await hasPermission;
      if (!_hasPermission) {
        if (await willResquestPermission.call()) {
          debugPrint("请求开启定位权限");
          await requestPermission(force: force);
          _hasPermission = await hasPermission;
        }
      }
      if (!_hasPermission) {
        _msg = "permission refused";
        print("location:$_msg");
        _didGetLocationFuture = null;
        return null;
      }
      debugPrint("开启定位权限成功");
      debugPrint("获取定位");
      var info = await _channel.invokeMethod(MethodName.GET_LOCATION);
      if (info == null || info.length == 0) {
        _msg = "FAILTURE";
        print("location:$_msg");
        _didGetLocationFuture = null;
        return null;
      }
      debugPrint("获取定位成功:$info");
      _setLocation(Location.ins(info));
      _didGetLocationFuture = null;
      return _location;
    } catch (e) {
      print(e.toString());
    }
    _msg = "Exception";
    print("location:$_msg");
    _didGetLocationFuture = null;
    return null;
  }

  static Future<Location?>? _didGetLocationFuture;
  static Future<Location?> getLocation({bool force = false}) =>
      _didGetLocationFuture ??= _getLocation(force: force);

  static Future _methodCallHandler(MethodCall call) async {
    print("location:method call:${call.method} arguments:${call.arguments}");
    switch (call.method) {
      case MethodName.DID_GET_LOCATION:
        _didGetLocation(call.arguments);
        break;
    }
  }

  static void _didGetLocation(Map info) {
    _setLocation(Location.ins(info));
  }

  static void _setLocation(Location location) {
    _location = location;
    if (_onGetLocation != null) {
      _onGetLocation?.call(location);
      return;
    }
    EventBus.post(MethodName.DID_GET_LOCATION, object: _location);
  }
}
