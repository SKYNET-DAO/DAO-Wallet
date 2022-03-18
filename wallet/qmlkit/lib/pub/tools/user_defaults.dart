import 'package:qmlkit/device/device.dart';
import 'package:qmlkit/device/device_info.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserDefaults {
  static const _IS_FIRST = "IS_FIRST";
  static Future<bool> isFirst() async {
    DeviceInfo info = await Device.current.getInfo();
    String key = _IS_FIRST + "_${info.appVersion ?? ""}";
    SharedPreferences pre = await SharedPreferences.getInstance();
    return pre.getBool(key) ?? true;
  }

  static Future setIsFirst(bool isFirst) async {
    DeviceInfo info = await Device.current.getInfo();
    String key = _IS_FIRST + "_${info.appVersion ?? ""}";
    SharedPreferences pre = await SharedPreferences.getInstance();
    pre.setBool(key, isFirst);
  }

  static const _LASTEST_TOKEN = "LASTEST_TOKEN";
  static Future<String> lastestToken() async {
    SharedPreferences pre = await SharedPreferences.getInstance();
    return pre.getString(_LASTEST_TOKEN) ?? "";
  }

  static Future setLastestToken(String token) async {
    SharedPreferences pre = await SharedPreferences.getInstance();
    pre.setString(_LASTEST_TOKEN, token);
  }

  static const _AGREE_DEFALUT = "AGREE_DEFALUT";
  static Future<bool> agreeDefault() async {
    DeviceInfo info = await Device.current.getInfo();
    String key = _AGREE_DEFALUT + "_${info.appVersion ?? ""}";
    SharedPreferences pre = await SharedPreferences.getInstance();
    return pre.getBool(key) ?? false;
  }

  static Future setAgreeDefault(bool agreeDefault) async {
    DeviceInfo info = await Device.current.getInfo();
    String key = _AGREE_DEFALUT + "_${info.appVersion ?? ""}";
    SharedPreferences pre = await SharedPreferences.getInstance();
    pre.setBool(key, agreeDefault);
  }

  static const _LOGIN_SOURCE = "LOGIN_SOURCE";
  static const _LOGIN_AUTH_INFO = "_LOGIN_AUTH_INFO";
  static const _LOGIN_TYPE = "LOGIN_TYPE";
  static Future<String> loginSource() async {
    SharedPreferences pre = await SharedPreferences.getInstance();
    return pre.getString(_LOGIN_SOURCE) ?? "";
  }

  static Future<String> loginType() async {
    SharedPreferences pre = await SharedPreferences.getInstance();
    return pre.getString(_LOGIN_TYPE) ?? "";
  }

  static Future<void> setLoginType(String type) async {
    SharedPreferences pre = await SharedPreferences.getInstance();
    pre.setString(_LOGIN_TYPE, type);
  }

  static Future<String> loginAuthInfo() async {
    SharedPreferences pre = await SharedPreferences.getInstance();
    return pre.getString(_LOGIN_AUTH_INFO) ?? "";
  }

  static Future setLoginInfo(String source,
      {String type = "", String authInfo = ""}) async {
    SharedPreferences pre = await SharedPreferences.getInstance();
    pre.setString(_LOGIN_SOURCE, source);
    pre.setString(_LOGIN_TYPE, type);
    pre.setString(_LOGIN_AUTH_INFO, authInfo);
  }
}
