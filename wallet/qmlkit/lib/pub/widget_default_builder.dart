import 'package:flutter/material.dart';
import 'package:qmlkit/bean/net_resp.dart';
import 'extensions/extensions.dart';

typedef RespStatusWidgetBuilder = Widget? Function(RespStatus status);

class WidgetDefaultBuilder {
  static String _respStatusDesc(RespStatus status) => status.msg;

  static RespStatusWidgetBuilder respStatusWidgetBuilder = (status) =>
      _respStatusDesc(status).toText(color: Color(0xff666666), fontSize: 13);
}
