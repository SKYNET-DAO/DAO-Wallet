import 'package:qmlkit/net/net_client_web.dart';
import 'package:qmlkit/net/net_request.dart';

NetRequest get netRequest => NetWeb();

class NetWeb extends NetRequest {
  NetWeb() : super(NetClientWeb());
}
