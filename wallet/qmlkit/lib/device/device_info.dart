import 'package:qmlkit/device/device.dart';
import 'package:flutter/material.dart';

class DeviceInfo {
  String? uuid;
  String? name;
  String? model;
  String? localizedModel;
  String? brand;
  String? sysName;
  String? sysVersion;
  String? appVersion;
  static DeviceInfo ins(Map info) {
    DeviceInfo device = DeviceInfo();
    device.uuid = info["uuid"];
    device.name = info["name"];
    device.model = info["model"];
    device.localizedModel = info["localizedModel"];
    device.brand = info["brand"];
    device.sysName = info["sysName"];
    device.sysVersion = info["sysVersion"];
    device.appVersion = info["appVersion"];
    return device;
  }
}
