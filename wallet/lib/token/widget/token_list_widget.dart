// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:wallet/storage/data_storage.dart';
import 'package:wallet/style/app_color.dart';
import 'package:wallet/token/chain.dart';
import 'package:wallet/token/token.dart';
import 'package:wallet/token/widget/token_detail_page.dart';
import 'package:wallet/token/widget/token_list_item_widget.dart';
import 'package:qmlkit/qmlkit.dart';

class TokenListWidget extends StatefulWidget {
  TokenListWidget({Key? key}) : super(key: key);

  @override
  State<TokenListWidget> createState() => _TokenListWidgetState();
}

class _TokenListWidgetState extends State<TokenListWidget> {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        padding: EdgeInsets.zero,
        itemBuilder: (_, idx) => TokenListItemWidget(token: tokens[idx])
            .onClick(() => App.push(TokenDetailPage(token: tokens[idx]))),
        separatorBuilder: (_, __) =>
            AppColor.COLOR_DEDEDE.toDivider(height: 0.5),
        itemCount: tokens.length);
  }

  @override
  void initState() {
    super.initState();

    DataStorage.getLatestWallet().then((wallet) {
      if (wallet != null) {
        tokens = wallet.tokens;
        debugPrint("tokens:$tokens");
        setState(() {});
      } else {
        debugPrint("tokens:is null");
      }
    });
  }

  List<Token> tokens = [];
}
