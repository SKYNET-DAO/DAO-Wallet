import 'dart:async';

import 'package:flutter/material.dart';
import 'package:qmlkit/button/base_button.dart';
import 'package:qmlkit/qmlkit.dart';

class CodeWidget extends StatefulWidget {
  final bool Function()? getCodeFun;
  final String? Function(int)? getTitleFun;
  final TextStyle style;
  final int countdown;
  CodeWidget({
    Key? key,
    this.getCodeFun,
    this.getTitleFun,
    this.style = const TextStyle(
      color: Color(0xFF09AEB0),
      fontSize: 14,
    ),
    this.countdown = 60,
  }) : super(key: key);

  @override
  _CodeWidgetState createState() => _CodeWidgetState();
}

class _CodeWidgetState extends State<CodeWidget> {
  @override
  Widget build(BuildContext context) {
    return BaseButton(
      controller: controller,
      padding: EdgeInsets.zero,
      onClick: tryToGetCode,
      descBuilder: (_) => ButtonDesc(
        childBuilder: (title) => (title ?? "").toText(style: widget.style),
      ),
    );
  }

  late ButtonController controller =
      ButtonController(title: getTitleFun.call(0));
  Timer? timer;
  late String? Function(int) getTitleFun =
      widget.getTitleFun ?? (time) => time > 0 ? '${time}s' : '获取验证码';
  static DateTime? startTime;
  void tryToGetCode() {
    if (timer != null && timer!.isActive) return;
    if (widget.getCodeFun?.call() ?? false) {
      startTime = DateTime.now();
      startTimer();
    }
  }

  void startTimer() {
    if (timer == null) {
      timerRun();
      timer = Timer.periodic(Duration(seconds: 1), (timer) {
        timerRun();
      });
    }
  }

  void timerRun() {
    DateTime now = DateTime.now();
    int duration = now.difference(startTime!).inSeconds;
    if (duration >= widget.countdown) {
      controller.title = getTitleFun.call(0);
      timer?.cancel();
      timer = null;
    } else {
      controller.title = getTitleFun.call(60 - duration);
    }
    controller.commit();
  }

  @override
  void dispose() {
    timer?.cancel();
    timer = null;
    super.dispose();
  }
}
