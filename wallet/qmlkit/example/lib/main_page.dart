import 'package:flutter/material.dart';
import 'package:qmlkit/pub/extensions/extensions.dart';
import 'package:qmlkit_example/banner_page.dart';

import 'device_info_page.dart';

class MainPage extends StatefulWidget {
  MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("QMLKit")),
      backgroundColor: Color(0xffefefef),
      body: ListView(
        children: ["Banner", "DeviceInfo"]
            .map((e) => [
                  e
                      .toText(
                        color: Color(0xff333333),
                        fontSize: 14,
                      )
                      .applyBackground(
                        width: double.infinity,
                        color: Colors.white,
                        padding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                      ),
                  Color(0xffdedede).toDivider(height: 0.5),
                ].toColumn().onClick(() => gotoDetail(e)))
            .toList(),
      ),
    );
  }

  void gotoDetail(String title) {
    if (title == "Banner") {
      var route =
          MaterialPageRoute(builder: (BuildContext context) => BannerPage());
      Navigator.push(context, route);
    }
    if (title == "DeviceInfo") {
      var route = MaterialPageRoute(
          builder: (BuildContext context) => DeviceInfoPage());
      Navigator.push(context, route);
    }
  }
}
