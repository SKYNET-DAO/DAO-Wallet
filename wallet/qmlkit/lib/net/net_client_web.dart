import 'package:dio/dio.dart';
import 'package:dio/browser_imp.dart';

Dio get getDioClient => NetClientWeb();

class NetClientWeb extends DioForBrowser {
  NetClientWeb() : super();
}
