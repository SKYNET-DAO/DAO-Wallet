import 'package:flutter/material.dart';
import 'package:qmlkit/alert/alert_widget.dart';
import 'package:qmlkit/bean/net_resp.dart';
import 'package:qmlkit/button/base_button.dart';
import 'package:qmlkit/button/theme_button.dart';
import 'package:qmlkit/location/location_manager.dart';
import 'package:qmlkit/provider/net_widget.dart';
import 'package:qmlkit/pub/extensions/extensions.dart';
import 'package:qmlkit/calendar/month_card.dart';
import 'package:qmlkit/widgets/loading_widget.dart';

class TestPage extends StatefulWidget {
  const TestPage({Key? key}) : super(key: key);

  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  late NetProvider<int?> provider;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('QMLKit example app'),
      ),
      body: Column(
        children: [
          Tooltip(
            message: "按钮",
            child: LoadingWidget(
              child: "测试"
                  .toText(color: Colors.white, fontSize: 13)
                  .applyBackground(
                      padding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      color: Colors.red),
              loadFunc: () => Future.delayed(Duration(seconds: 2)),
            ),
          ),
          RespWidget(
            RespStatus.error,
          ),
          NetWidget<int>(
            () async => NetResp<int>(data: 1, code: 100, msg: "这个是模拟错误"),
            didGetProvider: (p) => provider = p,
            statusWidgetBuilder: (p) {
              if (p.status == RespStatus.error)
                return Text(
                  "异常(code:${provider.code},msg:${provider.msg})",
                  style: TextStyle(color: Color(0xff666666), fontSize: 13),
                );
              return Container();
            },
            builder: (_, __) => Container(),
          ),
          Container(
            height: 16,
          ),
          Tooltip(
            message: "这是个按钮",
            child: ThemeButton(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 5),
              childBuilder: () => "Alert".toText(),
            ),
          ),
          Container(
            height: 16,
          ),
          MonthCard(
            beforeStyle: TextStyle(color: Colors.red, fontSize: 14),
            afterStyle: TextStyle(color: Colors.green, fontSize: 14),
            showWeekTitle: true,
            footerBuilder: (dateTime) => Padding(
              padding: EdgeInsets.only(top: 5),
              child: Container(
                height: 4,
                width: 4,
                decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(100)),
              ),
            ),
            onDayClick: (dateTime) => debugPrint("$dateTime"),
          ),
        ],
      ),
    );
  }

  var locationBtnController = ButtonController(title: "点击获取位置");
  void getLocation() async {
    LocationManager.willResquestPermission = () async {
      int? idx = await AlertWidget.show(context,
          title: "提示",
          submit: "申请",
          message: "定位权限未开启，是否现在申请开启权限？",
          messageAlign: TextAlign.left);
      return idx == 1;
    };
    LocationManager.willResquestEnable = () async {
      int? idx = await AlertWidget.show(context,
          title: "提示",
          submit: "开启",
          message: "定位未开启，是否现在开启？",
          messageAlign: TextAlign.center);
      return idx == 1;
    };
    locationBtnController.title = "定位中";
    // bool enable = await LocationManager.requestEnabled(force: true);
    // if (!enable) {
    //   locationBtnController.title = "定位未开启";
    //   return;
    // }
    LocationManager.getLocation().then((value) {
      debugPrint("value:$value");
      if (value == null) {
        locationBtnController.title = "定位失败";
      } else {
        locationBtnController.title = value.area;
      }
      locationBtnController.commit();
    });
  }
}
