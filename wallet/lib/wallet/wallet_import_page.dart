// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:qmlkit/button/theme_button.dart';
import 'package:qmlkit/info/simple_input_widget.dart';
import 'package:qmlkit/qmlkit.dart';
import 'package:wallet/style/app_color.dart';
import 'package:wallet/style/widgets.dart';

class WalletImportPage extends StatefulWidget {
  WalletImportPage({Key? key}) : super(key: key);

  @override
  State<WalletImportPage> createState() => _WalletImportPageState();
}

class _WalletImportPageState extends State<WalletImportPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Widgets.buildAppBar(title: "Wallet Import"),
      body: [
        SimpleInputWidget(
          titleBuilder: () => "Wallet Name".toText(
            fontSize: 14,
            fontWeight: FontWeightEx.light,
            color: AppColor.COLOR_323232,
          ),
          hintText: "Wallet Name",
          maxLines: 1,
        ),
        "Mnemonic".toText(
          fontSize: 14,
          fontWeight: FontWeightEx.light,
          color: AppColor.COLOR_323232,
        ),
        4.inColumn,
        SimpleInputWidget(
          hintText: "Mnemonic",
        ).applyBackground(
          height: 150,
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            border: Border.all(
              color: AppColor.COLOR_DEDEDE,
              width: 0.5,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        8.inColumn,
        "Usually 12 (sometimes 24) words separated by a single space".toText(
          fontSize: 12,
          fontWeight: FontWeightEx.light,
          color: AppColor.COLOR_323232,
        ),
        32.inColumn,
        ThemeButton(
          childBuilder: () => "Import".toText(
            fontSize: 17,
            fontWeight: FontWeightEx.light,
            color: Colors.white,
          ),
          backgroundColor: AppColor.MAIN_COLOR,
          width: MediaQuery.of(context).size.width,
          height: 44,
          onClick: () {
            QML.dismissKeyboard();
          },
        ),
      ].toColumn(crossAxisAlignment: CrossAxisAlignment.start).applyBackground(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16)),
    ).onClick(
      () => QML.dismissKeyboard(),
    );
  }
}
