import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextFieldBuilder {
  TextEditingController? controller;
  FocusNode? focusNode;
  String hintText = "";
  TextStyle? hintStyle;
  TextStyle? style;
  TextInputType inputType = TextInputType.text;
  TextInputAction? textInputAction;
  bool obscureText = false;
  bool autocorrect = false;
  bool enabled = true;
  TextAlign textAlign = TextAlign.left;
  int? maxLines;
  int? maxLength;
  bool expands = false;
  InputDecoration? decoration;
  void Function(String)? onChanged;
  void Function(String)? onSubmitted;
  void Function()? onTap;
  List<TextInputFormatter>? inputFormatters;

  TextField build() => TextField(
        inputFormatters: inputFormatters,
        controller: controller,
        focusNode: focusNode,
        autocorrect: autocorrect,
        obscureText: obscureText,
        style: style,
        textAlign: textAlign,
        enabled: enabled,
        keyboardType: inputType,
        onTap: onTap,
        expands: expands,
        maxLength: maxLength,
        maxLines: obscureText ? 1 : maxLines,
        textInputAction: textInputAction,
        decoration: decoration ??
            InputDecoration(
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
              hintText: hintText,
              hintStyle: hintStyle,
              isDense: true,
            ),
        onChanged: onChanged,
        onSubmitted: onSubmitted,
        buildCounter: (
          BuildContext context, {
          required int currentLength,
          int? maxLength,
          required bool isFocused,
        }) =>
            null,
      );
  TextFieldBuilder({
    this.controller,
    this.focusNode,
    this.hintText = "",
    this.hintStyle,
    this.style,
    this.inputType = TextInputType.text,
    this.textInputAction,
    this.obscureText = false,
    this.autocorrect = false,
    this.expands = false,
    this.enabled = true,
    this.textAlign = TextAlign.left,
    this.maxLines = 1,
    this.maxLength,
    this.onChanged,
    this.decoration,
    this.onSubmitted,
    this.onTap,
    this.inputFormatters,
  });
}
