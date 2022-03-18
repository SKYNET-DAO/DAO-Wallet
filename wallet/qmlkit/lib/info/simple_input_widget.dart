import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:qmlkit/qmlkit.dart';
import 'package:qmlkit/widgets/code_widget.dart';

enum SimpleInputType {
  normal,
  password,
  code,
}

class SimpleInputWidget extends StatefulWidget {
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final String hintText;
  final bool obscureText;
  final bool enable;
  final TextInputType inputType;
  final Widget? left;
  final Widget? right;
  final Widget? bottom;
  final Color tintColor;
  final Color? bottomLineColor;
  final TextStyle inputTextStyle;
  final TextStyle inputHintStyle;
  final TextStyle codeTextStyle;
  final SimpleInputType type;
  final bool Function()? getCodeFun;
  final Widget? Function()? titleBuilder;

  final void Function(String)? onChanged;
  final void Function(String)? onSubmitted;
  final int? maxLines;
  SimpleInputWidget({
    Key? key,
    this.controller,
    this.focusNode,
    this.hintText = "",
    this.obscureText = false,
    this.enable = true,
    this.inputType = TextInputType.text,
    this.left,
    this.right,
    this.tintColor = Colors.white,
    this.bottomLineColor,
    this.inputTextStyle = const TextStyle(color: Colors.black, fontSize: 14),
    this.inputHintStyle =
        const TextStyle(color: const Color(0xFFA6AAAD), fontSize: 14),
    this.codeTextStyle =
        const TextStyle(color: const Color(0xFF09AEB0), fontSize: 14),
    this.type = SimpleInputType.normal,
    this.onChanged,
    this.onSubmitted,
    this.getCodeFun,
    this.titleBuilder,
    this.bottom,
    this.maxLines,
  }) : super(key: key);

  @override
  State<SimpleInputWidget> createState() => _SimpleInputWidgetState();
}

class _SimpleInputWidgetState extends State<SimpleInputWidget> {
  String _openEyes = '''
<svg width="18px" height="14px" viewBox="0 0 18 14" version="1.1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">
    <g id="页面-1" stroke="none" stroke-width="1" fill="none" fill-rule="evenodd">
        <g id="登录" transform="translate(-338.000000, -365.000000)">
            <rect  x="0" y="0" width="375" height="812"></rect>
            <g id="密码" transform="translate(20.000000, 332.000000)" stroke="#979797">
                <g id="编组" transform="translate(318.849090, 34.294493)">
                    <path d="M-2.84217094e-14,5.71153915 C3.07177912,1.90384638 5.70390032,2.27373675e-13 7.89636361,2.27373675e-13 C10.0888269,2.27373675e-13 12.7062849,1.78053605 15.7487376,5.34160816 C13.3340389,9.55993514 10.7165809,11.6690986 7.89636361,11.6690986 C5.07614634,11.6690986 2.44402513,9.68324547 -2.84217094e-14,5.71153915 Z" id="路径-3"></path>
                    <circle id="椭圆形" cx="8.15091034" cy="5.70550658" r="2.5"></circle>
<!--                    <line x1="15.5" y1="0.5" x2="0.5" y2="11.5" id="直线-10" stroke-linecap="round"></line>-->
                </g>
            </g>
        </g>
    </g>
</svg>
  ''';
  String _closeEyes = '''
<svg width="18px" height="14px" viewBox="0 0 18 14" version="1.1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">
    <g id="页面-1" stroke="none" stroke-width="1" fill="none" fill-rule="evenodd">
        <g id="登录" transform="translate(-338.000000, -365.000000)">
            <rect  x="0" y="0" width="375" height="812"></rect>
            <g id="密码" transform="translate(20.000000, 332.000000)" stroke="#979797">
                <g id="编组" transform="translate(318.849090, 34.294493)">
                    <path d="M-2.84217094e-14,5.71153915 C3.07177912,1.90384638 5.70390032,2.27373675e-13 7.89636361,2.27373675e-13 C10.0888269,2.27373675e-13 12.7062849,1.78053605 15.7487376,5.34160816 C13.3340389,9.55993514 10.7165809,11.6690986 7.89636361,11.6690986 C5.07614634,11.6690986 2.44402513,9.68324547 -2.84217094e-14,5.71153915 Z" id="路径-3"></path>
                    <circle id="椭圆形" cx="8.15091034" cy="5.70550658" r="2.5"></circle>
                    <line x1="15.5" y1="0.5" x2="0.5" y2="11.5" id="直线-10" stroke-linecap="round"></line>
                </g>
            </g>
        </g>
    </g>
</svg>
  ''';
  Widget? buildSimpleRightWidget() {
    if (widget.type == SimpleInputType.password) {
      return SvgPicture.string(
        obscureText ? _closeEyes : _openEyes,
        color: widget.inputTextStyle.color,
      )
          .applyPadding(
            EdgeInsets.only(left: 8),
          )
          .onClick(() => setState(() => obscureText = !obscureText));
    }
    if (widget.type == SimpleInputType.code) {
      return CodeWidget(
        getCodeFun: widget.getCodeFun,
        style: widget.codeTextStyle,
      );
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return [
      widget.titleBuilder?.call() ?? Container(),
      QML.buildTextFiled(
        controller: widget.controller,
        focusNode: widget.focusNode,
        style: widget.inputTextStyle,
        enable: widget.enable,
        obscureText: obscureText,
        inputType: widget.inputType,
        onSubmitted: widget.onSubmitted,
        onChanged: widget.onChanged,
        maxLines: widget.maxLines,
        decoration: InputDecoration(
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          hintText: widget.hintText,
          hintStyle: widget.inputHintStyle,
          isDense: true,
        ),
        right: widget.right ?? buildSimpleRightWidget(),
        left: widget.left,
      ),
      widget.bottom ?? Container(),
      (widget.bottomLineColor != null)
          .toWidget(() => widget.bottomLineColor!.toDivider()),
    ].toColumn(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min);
  }

  late bool obscureText = widget.obscureText;
}
