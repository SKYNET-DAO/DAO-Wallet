import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:qmlkit/event/event_bus.dart';

class AppPlugin {
  static const _CHANNEL_NAME = "com.qmstudio.qmlkit";
  static const App_Plugin_HAS_INVOKE = "App_Plugin_HAS_INVOKE";
  static MethodChannel channel = MethodChannel(_CHANNEL_NAME)
    ..setMethodCallHandler(AppPlugin._methodCallHandler);
  static Future _methodCallHandler(MethodCall call) async {
    debugPrint("methodCall call:${call.method} arguments:${call.arguments}");
    switch (call.method) {
      default:
        EventBus.post(
          App_Plugin_HAS_INVOKE,
          object: call,
        );
    }
  }

  static Future<T?> invokeMethod<T>(String method, [dynamic arguments]) async {
    debugPrint("invokeMethod method:$method arguments:$arguments");
    try {
      var result = await channel.invokeMethod<T>(method, arguments);
      return result;
    } catch (e) {
      return null;
    }
  }
}
