import 'package:flutter/material.dart';
import 'package:qmlkit/card/info_card.dart';
import 'package:qmlkit/device/device.dart';
import 'package:qmlkit/device/device_info.dart';
import 'package:qmlkit/qmlkit.dart';

class DeviceInfoPage extends StatefulWidget {
  @override
  _DeviceInfoPageState createState() => _DeviceInfoPageState();
}

class _DeviceInfoPageState extends State<DeviceInfoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Device Info"),
      ),
      body: (deviceInfo != null)
          .toWidget(() => InfoCard(
                items: [
                  InfoCardItem(
                    flag: "uuid",
                    value: deviceInfo?.uuid ?? "",
                  ),
                  InfoCardItem(
                    flag: "name",
                    value: deviceInfo?.name ?? "",
                  ),
                  InfoCardItem(
                    flag: "brand",
                    value: deviceInfo?.brand ?? "",
                  ),
                  InfoCardItem(
                    flag: "model",
                    value: deviceInfo?.model ?? "",
                  ),
                  InfoCardItem(
                    flag: "localizedModel",
                    value: deviceInfo?.localizedModel ?? "",
                  ),
                  InfoCardItem(
                    flag: "sysName",
                    value: deviceInfo?.sysName ?? "",
                  ),
                  InfoCardItem(
                    flag: "sysVersion",
                    value: deviceInfo?.sysVersion ?? "",
                  ),
                  InfoCardItem(
                    flag: "appVersion",
                    value: deviceInfo?.appVersion ?? "",
                  ),
                ],
              ))
          .applyPadding(EdgeInsets.only(top: 12)),
    );
  }

  DeviceInfo? deviceInfo;
  @override
  void initState() {
    super.initState();
    Device.current
        .getInfo()
        .then((value) => setState(() => deviceInfo = value));
  }
}
