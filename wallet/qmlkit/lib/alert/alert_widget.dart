import 'package:flutter/material.dart';
import 'package:qmlkit/button/theme_button.dart';
import 'package:qmlkit/pub/qml_color.dart';
import '../pub/extensions/extensions.dart';

abstract class AlertDelegate<T> {
  T getResult();
}

class AlertWidget extends StatelessWidget {
  static Future<int?> show(BuildContext context,
      {String? title = AlertDefines.STR_TITLE,
      String? message,
      Widget? content,
      TextAlign messageAlign = AlertDefines.ALIGN_MESSAGE,
      String cancel = AlertDefines.STR_CANCEL,
      String submit = AlertDefines.STR_CONFIRM,
      bool dismissCancel = false,
      bool barrierDismissible = false,
      void Function()? onCancel,
      bool Function()? willCancel,
      void Function()? onSubmit,
      bool Function()? willSubmit}) {
    var actions = [
      AlertAction.doneAction(title: submit)
        ..action = () {
          if (willSubmit?.call() ?? true) {
            Navigator.of(context).pop(AlertDefines.RES_CONFIRM);
            onSubmit?.call();
          }
        },
    ];
    if (!dismissCancel) {
      actions.insert(
          0,
          AlertAction.cancelAction(title: cancel)
            ..action = () {
              if (willCancel?.call() ?? true) {
                Navigator.of(context).pop(AlertDefines.RES_CANCEL);
                onCancel?.call();
              }
            });
    }
    return showDialog<int>(
        barrierDismissible: barrierDismissible,
        context: context,
        builder: (_) => AlertWidget(
              title: title,
              message: message,
              content: content,
              messageAlign: messageAlign,
              actions: actions,
            ));
  }

  const AlertWidget({
    Key? key,
    this.title,
    this.message,
    this.content,
    this.actions,
    this.titleStyle = AlertDefines.STYLE_TITLE,
    this.messageStyle = AlertDefines.STYLE_MESSAGE,
    this.contentPadding = AlertDefines.PADDING_CONTENT,
    this.widgetSpan = AlertDefines.SPAN_WIDGET,
    this.messageAlign = AlertDefines.ALIGN_MESSAGE,
    this.titleAlign = TextAlign.left,
    this.lineColor = AlertDefines.COLOR_LINE,
    this.lineWidth = AlertDefines.WIDTH_LINE,
    this.backgroundColor = Colors.white,
    this.borderRadius = AlertDefines.RADIUS_ALERT,
    this.width = AlertDefines.WIDTH_ALERT,
  }) : super(key: key);
  final String? title;
  final TextStyle titleStyle;
  final TextAlign titleAlign;
  final String? message;
  final Widget? content;
  final TextStyle messageStyle;
  final List<AlertAction>? actions;
  final EdgeInsets contentPadding;
  final double widgetSpan;
  final TextAlign messageAlign;
  final Color? lineColor;
  final double lineWidth;
  final Color backgroundColor;
  final double borderRadius;
  final double width;

  @override
  Widget build(BuildContext context) {
    Widget? titleWidget =
        title?.toText(style: titleStyle, textAlign: titleAlign);

    Widget? messageWidget = content ??
        message?.toText(textAlign: messageAlign, style: messageStyle);
    List<Widget> children = [];
    if (titleWidget != null) children.add(titleWidget);
    if (messageWidget != null)
      children.add(messageWidget.expanded.toRow().toScrollView().flexible);
    if (children.length > 1) {
      children.insert(1, widgetSpan.inColumn);
    }
    var contentWidget = children
        .toColumn(mainAxisSize: MainAxisSize.min)
        .applyBackground(padding: contentPadding, color: backgroundColor)
        .flexible;
    List<Widget> handleChildren = [];
    if (lineColor != null) {
      handleChildren.add(
          (lineColor ?? AlertDefines.COLOR_LINE).toDivider(height: lineWidth));
    }
    List<AlertAction> finalActions = actions ?? [];
    if (finalActions.length == 0) {
      finalActions.add(
          AlertAction.doneAction()..action = () => Navigator.of(context).pop());
    }
    if (finalActions.length > 2) {
      var handleWidget = (finalActions.expand<Widget>((e) {
        List<Widget> handles = [
          e.build().expanded.toRow(),
        ];
        if (finalActions.indexOf(e) != finalActions.length - 1) {
          handles.add((lineColor ?? AlertDefines.COLOR_LINE)
              .toDivider(height: lineWidth));
        }
        return handles;
      }).toList())
          .toColumn();
      handleChildren.add(handleWidget);
    } else if (finalActions.length == 2) {
      List<Widget> handles =
          finalActions.map<Widget>((e) => e.build().expanded).toList();
      if (lineColor != null) {
        handles.insert(
            1,
            (lineColor ?? AlertDefines.COLOR_LINE).toContainer(
                width: lineWidth, height: AlertDefines.HEIGHT_ACTION));
      }
      handleChildren.add(handles.toRow());
    } else {
      AlertAction action = finalActions[0];
      handleChildren.add(action.build().expanded.toRow());
    }

    return [
      contentWidget,
      handleChildren.toColumn(mainAxisSize: MainAxisSize.min)
    ]
        .toColumn(mainAxisSize: MainAxisSize.min)
        .applyBackground(
            constraints: BoxConstraints(maxHeight: AlertDefines.HEIGHT_MAX),
            width: width,
            color: backgroundColor)
        .applyRadius(borderRadius)
        .applyUnconstrainedBox();
  }
}

class AlertAction {
  AlertAction({this.text, this.style, this.action, this.backgroundColor});
  final String? text;
  final TextStyle? style;
  final Color? backgroundColor;
  void Function()? action;
  factory AlertAction.ins(String title, Color color, double fontSize,
          {Function()? action}) =>
      AlertAction(
          text: title,
          style: TextStyle(
              decoration: TextDecoration.none,
              color: color,
              fontSize: fontSize,
              fontWeight: FontWeight.normal),
          action: action);
  static AlertAction doneAction(
          {String title = AlertDefines.STR_CONFIRM,
          Color color = AlertDefines.COLOR_CONFIRM,
          double fontSize = AlertDefines.FONT_SIZE_ACTION,
          Color? backgroundColor,
          Function()? action}) =>
      AlertAction(
          text: title,
          style: TextStyle(
              decoration: TextDecoration.none,
              color: color,
              fontSize: fontSize,
              fontWeight: FontWeight.normal),
          backgroundColor: backgroundColor,
          action: action);
  static AlertAction cancelAction(
          {String title = AlertDefines.STR_CANCEL,
          Color color = AlertDefines.COLOR_CANCEL,
          double fontSize = AlertDefines.FONT_SIZE_ACTION,
          Color? backgroundColor,
          Function()? action}) =>
      AlertAction(
          text: title,
          style: TextStyle(
              decoration: TextDecoration.none,
              color: color,
              fontSize: fontSize,
              fontWeight: FontWeight.normal),
          backgroundColor: backgroundColor,
          action: action);
  ThemeButton build() => ThemeButton(
        borderRadius: 0,
        height: AlertDefines.HEIGHT_ACTION,
        backgroundColor: backgroundColor ?? Colors.white,
        highlightColor: backgroundColor?.applyOpacity(0.7) ?? Color(0xffE5E5E5),
        childBuilder: () => (this.text ?? "")
            .toText(style: this.style, textAlign: TextAlign.center),
        onClick: () => this.action?.call(),
      );
}

class AlertDefines {
  static const String STR_TITLE = "提示";
  static const String STR_CANCEL = "取消";
  static const String STR_CONFIRM = "确定";

  static const TextAlign ALIGN_MESSAGE = TextAlign.center;

  static const TextStyle STYLE_TITLE = const TextStyle(
      fontSize: 16,
      color: QMLColor.COLOR_171F26,
      decoration: TextDecoration.none,
      fontWeight: FontWeight.bold);
  static const TextStyle STYLE_MESSAGE = const TextStyle(
      fontSize: 14,
      color: QMLColor.COLOR_3D454D,
      decoration: TextDecoration.none,
      fontWeight: FontWeight.normal);

  static const EdgeInsets PADDING_CONTENT = const EdgeInsets.all(16);

  static const Color COLOR_LINE = QMLColor.COLOR_EFF3FA;
  static const Color COLOR_BG = Colors.white;
  static const Color COLOR_CONFIRM = QMLColor.COLOR_0080FF;
  static const Color COLOR_CANCEL = QMLColor.COLOR_5A6066;

  static const double SPAN_WIDGET = 12;

  static const double WIDTH_LINE = 0.5;
  static const double WIDTH_ALERT = 270;

  static const double HEIGHT_MAX = 500;
  static const double HEIGHT_ACTION = 44;

  static const double RADIUS_ALERT = 8;

  static const double FONT_SIZE_ACTION = 14;

  static const int RES_CANCEL = 0;
  static const int RES_CONFIRM = 1;
}
