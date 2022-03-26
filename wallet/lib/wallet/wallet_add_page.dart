// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables

import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:qm_widget/qm_widget.dart';
import 'package:wallet/main_page.dart';
import 'package:wallet/storage/data_storage.dart';
import 'package:wallet/style/app_color.dart';
import 'package:wallet/token/chain.dart';
import 'package:wallet/token/token.dart';
import 'package:wallet/wallet/wallet.dart';
import 'package:wallet/wallet/wallet_import_page.dart';
import 'package:bip39/bip39.dart';

class WalletAddPage extends StatefulWidget {
  WalletAddPage({Key? key}) : super(key: key);

  @override
  State<WalletAddPage> createState() => _WalletAddPageState();
}

class _WalletAddPageState extends State<WalletAddPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: [
        ThemeButton(
          childBuilder: () => "Create".toText(
            fontSize: 17,
            fontWeight: FontWeightEx.light,
            color: Colors.white,
          ),
          backgroundColor: AppColor.MAIN_COLOR,
          width: MediaQuery.of(context).size.width,
          height: 44,
          onClick: () => generateWallet(),
        ).applyPadding(EdgeInsets.symmetric(horizontal: 30)),
        TextBtn(
          title: "Import",
          fontSize: 15,
          fontWeight: FontWeightEx.light,
          onClick: () => App.push(WalletImportPage()),
        ),
        20.inColumn,
      ].toColumn(mainAxisAlignment: MainAxisAlignment.center),
    );
  }

  void generateWallet() async {
    QM.showLoading();
    // String mnemonic = generateMnemonic();
    String mnemonic =
        "process forget believe wealth tennis ski radio coral swim home clay topple";
    Wallet wallet = Wallet.fromMnemonic(mnemonic);
    wallet.multiple = true;
    wallet.tokens = [
      Token(
        chain: ChainType.bitcoin,
        symbol: "BTC",
        name: "Bitcoin",
        path: "m/84'/0'/0'/0/0",
      ),
      Token(
        chain: ChainType.cmc,
        symbol: "CMC",
        name: "Skynet",
        path: "m/44'/0'/0'/0/0",
      ),
      Token(
        chain: ChainType.eth,
        symbol: "ETH",
        name: "Ethereum",
        path: "m/60'/0'/0'/0/0",
      ),
      Token(
        chain: ChainType.doge,
        symbol: "DOGE",
        name: "Dogecoin",
        path: "m/84'/0'/0'/0/0",
      ),
      Token(
        chain: ChainType.usdt,
        symbol: "USDT",
        name: "Tether",
        path: "m/60'/0'/0'/0/0",
      ),
    ];
    String hash = md5.convert(utf8.encode(mnemonic)).toString();
    bool success = (await DataStorage.setWallet(hash, wallet)) &&
        (await DataStorage.setLatestKey(hash));
    QM.dismissLoading();
    if (success) {
      Toast.show("Create Successful");
      App.replace(MainPage());
    }
  }
}
