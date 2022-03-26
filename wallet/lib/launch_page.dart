// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:qm_widget/qm_widget.dart';
import 'package:wallet/main_page.dart';
import 'package:wallet/storage/data_storage.dart';
import 'package:wallet/style/app_color.dart';
import 'package:wallet/wallet/wallet_add_page.dart';

class LaunchPage extends StatefulWidget {
  LaunchPage({Key? key}) : super(key: key);

  @override
  State<LaunchPage> createState() => _LaunchPageState();
}

class _LaunchPageState extends State<LaunchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CircularProgressIndicator(
        strokeWidth: 1.5,
        valueColor: AlwaysStoppedAnimation<Color>(AppColor.MAIN_COLOR),
      ).applyBackground(height: 20, width: 20).toCenter(),
    );
  }

  @override
  void initState() {
    super.initState();
    DataStorage.getLatestKey().then((key) {
      if (key.isEmpty) {
        App.replace(WalletAddPage());
      } else {
        App.replace(MainPage());
      }
    });
  }
}
