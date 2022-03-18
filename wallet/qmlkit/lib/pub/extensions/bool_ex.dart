import 'package:flutter/material.dart';

extension BoolEx on bool {
  Widget toWidget(Widget Function() builder,
          {Widget? falseWidget, Widget Function()? falseBuilder}) =>
      this
          ? builder.call()
          : (falseBuilder?.call() ?? falseWidget ?? Container());
}
