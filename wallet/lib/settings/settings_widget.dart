// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:wallet/style/app_color.dart';
import 'package:qmlkit/qmlkit.dart';
import 'package:wallet/wallet/wallet_list_page.dart';

class SettingsWidget extends StatefulWidget {
  SettingsWidget({Key? key}) : super(key: key);

  @override
  State<SettingsWidget> createState() => _SettingsWidgetState();
}

class _SettingsWidgetState extends State<SettingsWidget> {
  Widget buildItemWidget(int idx) => [
        menus[idx]
            .toText(
              fontWeight: FontWeightEx.light,
              color: AppColor.COLOR_323232,
              fontSize: 16,
            )
            .expanded,
        RotatedBox(
          quarterTurns: 2,
          child: Icon(
            Icons.arrow_back_ios,
            color: AppColor.COLOR_323232,
            size: 16,
          ),
        )
      ].toRow().applyBackground(
            height: 44,
            padding: EdgeInsets.symmetric(horizontal: 16),
          );
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        padding: EdgeInsets.zero,
        itemBuilder: (_, idx) => buildItemWidget(idx).onClick(() {
              if (menus[idx] == "Wallet") {
                App.push(WalletListPage());
              }
            }),
        separatorBuilder: (_, __) =>
            AppColor.COLOR_DEDEDE.toDivider(height: 0.5),
        itemCount: menus.length);
  }

  List<String> menus = [
    "Wallet",
    "Settings",
  ];
}
