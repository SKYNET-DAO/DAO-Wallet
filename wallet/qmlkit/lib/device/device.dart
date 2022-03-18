import 'package:qmlkit/device/device_info.dart';
import 'package:qmlkit/plugin/app_plugin.dart';
import 'package:flutter/material.dart';

class Device {
  static final current = Device._();
  Device._();
  DeviceInfo? _info;
  Future<DeviceInfo> getInfo() async {
    if (_info != null) return _info!;
    Map info = await AppPlugin.invokeMethod("device.getInfo") ?? {};
    debugPrint("device.getInfo:$info");
    return _info ??= DeviceInfo.ins(info);
  }

  void clear() => _info = null;
}
