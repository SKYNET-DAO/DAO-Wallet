import 'package:flutter/material.dart';
import 'package:qmlkit/pub/extensions/extensions.dart';

class ItemHelper {
  final String? iconName;
  final String? title;
  final String? subTitle;

  ItemHelper(this.iconName, this.title, this.subTitle);
  ItemHelper.only({this.iconName, this.title, this.subTitle});
}

extension ItemHelperEx on ItemHelper {
  Widget toRow(double iconSize, TextStyle textStyle, double span,
          {bool reversed = false,
          CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.center}) =>
      [
        (this.iconName ?? "").isNotEmpty.toWidget(() =>
            this.iconName!.toAssetImage(width: iconSize, height: iconSize)),
        span.inRow,
        (this.title ?? "").toText(style: textStyle),
      ].toRow(
          reversed: reversed,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: crossAxisAlignment);
  Widget toColumn(double iconSize, TextStyle textStyle, double span,
          {bool reversed = false,
          CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.center}) =>
      [
        (this.iconName ?? "").isNotEmpty.toWidget(() =>
            this.iconName!.toAssetImage(width: iconSize, height: iconSize)),
        span.inColumn,
        (this.title ?? "").toText(style: textStyle),
      ].toColumn(
          reversed: reversed,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: crossAxisAlignment);
}
