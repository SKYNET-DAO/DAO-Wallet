import 'package:dio/dio.dart';
import 'package:dio/native_imp.dart';

Dio get dioClient => NetClient();

class NetClient extends DioForNative {
  NetClient() : super();
}
