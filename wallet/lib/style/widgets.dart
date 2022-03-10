import 'package:flutter/material.dart';
import 'package:qmlkit/qmlkit.dart';

class Widgets {
  static AppBar buildAppBar({String? title, List<Widget>? actions}) => AppBar(
        title: (title ?? "").toText(
          color: Colors.white,
          fontSize: 17,
          fontWeight: FontWeightEx.light,
        ),
        actions: actions,
      );
}
