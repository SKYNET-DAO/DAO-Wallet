// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:wallet/style/app_color.dart';
import 'package:wallet/style/widgets.dart';
import 'package:wallet/token/token.dart';
import 'package:qm_widget/qm_widget.dart';

class TokenDetailPage extends StatefulWidget {
  final Token token;
  TokenDetailPage({Key? key, required this.token}) : super(key: key);

  @override
  State<TokenDetailPage> createState() => _TokenDetailPageState();
}

class _TokenDetailPageState extends State<TokenDetailPage> {
  Widget buildButton(IconData icon) => ThemeButton(
        childBuilder: () => Icon(
          icon,
          size: 20,
          color: Colors.white,
        ),
        backgroundColor: AppColor.MAIN_COLOR,
        highlightColor: AppColor.MAIN_COLOR.applyOpacity(0.7),
        padding: EdgeInsets.zero,
        width: 44,
        height: 44,
        borderRadius: 100,
      );
  Widget buildHandleWidget() => [
        RotatedBox(
          quarterTurns: 2,
          child: buildButton(Icons.call_received_rounded),
        ),
        20.inRow,
        RotatedBox(
          quarterTurns: 3,
          child: buildButton(Icons.call_received_rounded),
        ),
        20.inRow,
        buildButton(Icons.copy),
      ].toRow(mainAxisAlignment: MainAxisAlignment.center);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Widgets.buildAppBar(title: widget.token.name),
      body: [
        36.inColumn,
        widget.token.buildIconWidget(60),
        12.inColumn,
        "-- ${widget.token.symbol.toUpperCase()}".toText(
          fontSize: 16,
          fontWeight: FontWeightEx.light,
          color: AppColor.COLOR_323232,
        ),
        8.inColumn,
        "≈ \$--.--".toText(
          fontSize: 13,
          fontWeight: FontWeightEx.light,
          color: AppColor.COLOR_323232,
        ),
        12.inColumn,
        buildHandleWidget(),
        12.inColumn,
        AppColor.COLOR_DEDEDE
            .toDivider(height: 0.5)
            .applyPadding(EdgeInsets.symmetric(horizontal: 16)),
      ].toColumn(),
    );
  }
}
