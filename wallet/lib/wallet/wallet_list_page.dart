// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:wallet/style/app_style.dart';
import 'package:wallet/style/widgets.dart';
import 'package:qmlkit/qmlkit.dart';
import 'package:wallet/wallet/wallet_add_page.dart';

class WalletListPage extends StatefulWidget {
  WalletListPage({Key? key}) : super(key: key);

  @override
  State<WalletListPage> createState() => _WalletListPageState();
}

class _WalletListPageState extends State<WalletListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Widgets.buildAppBar(title: "Wallet", actions: [
        Icon(
          Icons.add,
          color: Colors.white,
          size: 24,
        )
            .applyPadding(EdgeInsets.symmetric(horizontal: 12))
            .onClick(() => App.push(WalletAddPage())),
      ]),
    );
  }
}
