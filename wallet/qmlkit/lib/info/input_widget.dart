import 'package:flutter/material.dart';
import 'package:qmlkit/info/info_widget.dart';
import 'package:qmlkit/info/text_field_builder.dart';

class InputWidget extends StatelessWidget {
  const InputWidget({Key? key, this.left, this.right, required this.builder})
      : super(key: key);
  final Widget? left;
  final Widget? right;
  final TextFieldBuilder builder;

  @override
  Widget build(BuildContext context) {
    return InfoWidget(
      left: left,
      right: right,
      center: builder.build(),
    );
  }
}
