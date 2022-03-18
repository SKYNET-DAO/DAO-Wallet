import 'package:flutter/material.dart';
import 'package:qmlkit/pub/extensions/extensions.dart';
import 'package:qmlkit/pub/widget_default_builder.dart';

class NetResp<T> {
  static const int RESP_OK = 200;
  T? data;
  int code = -1;
  String msg = "通讯异常";
  Map<dynamic, dynamic>? originalData;
  bool Function(int code, String msg) respCheckFunc = ((c, _) => c == RESP_OK);
  bool get isOK => respCheckFunc.call(code, msg);
  String get info => "$msg {code:$code}";
  NetResp(
      {T? data,
      int code = -1,
      String msg = "通讯异常",
      Map<dynamic, dynamic>? originalData,
      bool Function(int code, String msg)? respCheckFunc}) {
    this.data = data;
    this.code = code;
    this.msg = msg;
    this.originalData = originalData;
    if (respCheckFunc != null) this.respCheckFunc = respCheckFunc;
  }
}

enum _RespStatus { ready, loading, ok, empty, error }

class RespStatus extends Object {
  static RespStatus ready = RespStatus(_RespStatus.ready, msg: "就绪");
  static RespStatus loading = RespStatus(_RespStatus.loading, msg: "加载中");
  static RespStatus ok = RespStatus(_RespStatus.ok, msg: "成功");
  static RespStatus empty = RespStatus(_RespStatus.empty, msg: "暂无数据");
  static RespStatus error = RespStatus(_RespStatus.error, msg: "网络异常");
  final _RespStatus status;
  String msg = "";
  int code = 0;

  RespStatus(this.status, {this.msg = ""});
  operator ==(Object p) {
    if (p is RespStatus) {
      return p.status == status;
    }
    return false;
  }

  @override
  int get hashCode => super.hashCode;
}

class RespProvider extends ChangeNotifier {
  RespStatus _status = RespStatus.ready;
  String _msg = "";
  int _code = 0;

  RespStatus get status => _status;
  set status(RespStatus status) {
    this._status = status;
    notifyListeners();
  }

  String get msg => _msg;
  set msg(value) => _msg = value;
  int get code => _code;
  set code(value) => _code = value;

  void commit() {
    notifyListeners();
  }
}

class RespWidget extends StatelessWidget {
  const RespWidget(this.status,
      {Key? key,
      this.sliver = false,
      this.builder,
      this.statusWidgetBuilder,
      this.onTap})
      : super(key: key);
  final bool sliver;
  final Widget Function(BuildContext context)? builder;
  final RespStatus status;
  final Widget? Function(RespStatus status)? statusWidgetBuilder;
  final void Function()? onTap;

  Widget buildStatusWidget() =>
      WidgetDefaultBuilder.respStatusWidgetBuilder.call(status) ?? Container();
  @override
  Widget build(BuildContext context) {
    if (status == RespStatus.ok) {
      return builder?.call(context) ?? Container();
    }
    var child = statusWidgetBuilder?.call(status) ?? buildStatusWidget();
    var finalChild = sliver ? SliverToBoxAdapter(child: child) : child;
    if (status == RespStatus.loading) {
      return finalChild;
    }
    if (onTap != null) {
      finalChild = finalChild.onClick(onTap!);
    }
    return finalChild;
  }
}
