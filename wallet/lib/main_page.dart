// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:qm_widget/qm_widget.dart';
import 'package:wallet/settings/settings_widget.dart';
import 'package:wallet/style/app_color.dart';
import 'package:wallet/style/app_style.dart';
import 'package:wallet/style/widgets.dart';
import 'package:wallet/token/widget/token_list_widget.dart';

class MainPage extends StatefulWidget {
  MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: Widgets.buildAppBar(title: titles[index]),
      body: TabWidget(
        tabBuilder: (tab) => tab.applyBackground(
          height: 50,
          decoration: AppStyle.tabDecoration,
        ),
        indicatorSize: TabBarIndicatorSize.label,
        indicatorColor: Colors.transparent,
        labelStyle: const TextStyle(fontSize: 10),
        labelColor: AppColor.MAIN_COLOR,
        unselectedLabelStyle: const TextStyle(fontSize: 10),
        unselectedLabelColor: AppColor.COLOR_959595,
        tabs: List.generate(
            titles.length,
            (index) => Tab(
                  // icon: SvgPicture.asset(
                  //   icons[index],
                  //   width: 16,
                  //   height: 16,
                  //   color: index == this.index
                  //       ? AppColor.MAIN_COLOR
                  //       : AppColor.COLOR_959595,
                  // ).applyRadius(100),
                  iconMargin: EdgeInsets.only(bottom: 2),
                  text: titles[index],
                ).applyBackground(
                    width: MediaQuery.of(context).size.width / 4)),
        bodyBuilder: (idx) {
          if (idx == 1) return SettingsWidget();
          return TokenListWidget();
        },
        loadFunc: (idx) async => refList[idx].value = RefStatus.load,
        reversed: true,
        onIndexChanged: (idx, state) {
          index = idx;
          setState(() {});
        },
        // onCreated: (controller) => tabController = controller,
      ).toSafe(top: false),
    );
  }

  int index = 0;

  late List<String> titles = [
    "Token",
    "Settings",
  ];
  List<ValueNotifier<RefStatus>> refList = [
    ValueNotifier(RefStatus.normal),
    ValueNotifier(RefStatus.normal),
    ValueNotifier(RefStatus.normal),
    ValueNotifier(RefStatus.normal),
  ];
}
