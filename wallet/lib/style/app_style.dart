import 'package:flutter/material.dart';
import 'package:wallet/style/app_color.dart';
import 'package:qmlkit/qmlkit.dart';

class AppStyle {
  static BoxDecoration get tabDecoration => BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: AppColor.COLOR_040829.applyOpacity(0.06),
            offset: const Offset(0, -5),
            blurRadius: 8,
          ),
        ],
      );
}
