// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:wallet/style/app_color.dart';
import 'package:wallet/token/token.dart';
import 'package:qm_widget/qm_widget.dart';

class TokenListItemWidget extends StatefulWidget {
  final Token token;
  TokenListItemWidget({Key? key, required this.token}) : super(key: key);

  @override
  State<TokenListItemWidget> createState() => _TokenListItemWidgetState();
}

class _TokenListItemWidgetState extends State<TokenListItemWidget> {
  @override
  Widget build(BuildContext context) {
    return [
      widget.token.buildIconWidget(30),
      12.inRow,
      widget.token.name.toText(
        fontSize: 16,
        fontWeight: FontWeightEx.light,
        color: AppColor.COLOR_323232,
        textAlign: TextAlign.right,
      ),
      8.inRow,
      "-- ${widget.token.symbol.toUpperCase()}"
          .toText(
            fontSize: 16,
            fontWeight: FontWeightEx.light,
            color: AppColor.COLOR_323232,
            textAlign: TextAlign.right,
          )
          .expanded,
    ].toRow().applyBackground(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          color: Colors.white,
        );
  }
}
