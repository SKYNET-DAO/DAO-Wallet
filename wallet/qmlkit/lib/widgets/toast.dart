import 'package:flutter/material.dart';
import 'package:qmlkit/pub/app.dart';
import 'package:qmlkit/qmlkit.dart';

class Toast {
  static bool _showing = false;
  static void show(String message,
      {BuildContext? context, int second = 2}) async {
    BuildContext? ctx = context ?? App.navigatorKey.currentState?.context;
    if (ctx == null) return;
    _showing = false;
    double bottom = MediaQuery.of(ctx).viewInsets.bottom +
        MediaQuery.of(ctx).padding.bottom;
    OverlayEntry entry = OverlayEntry(builder: (context) {
      return Container(
        color: Colors.transparent,
        margin: EdgeInsets.only(
          bottom: 20 + bottom,
          left: 16,
          right: 16,
        ),
        alignment: Alignment.bottomCenter,
        child: AnimatedOpacity(
          opacity: _showing ? 1.0 : 0.0,
          duration: Duration(milliseconds: 250),
          child: Container(
            color: Colors.black.applyOpacity(0.7),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: message.toText(color: Colors.white, fontSize: 12),
            ),
          ).applyRadius(5),
        ),
      );
    });

    App.navigatorKey.currentState?.overlay?.insert(entry);
    _showing = true;
    entry.markNeedsBuild();

    await Future.delayed(Duration(seconds: second));
    _showing = false;
    entry.markNeedsBuild();
    await Future.delayed(Duration(milliseconds: 250));
    entry.remove();
  }
}
