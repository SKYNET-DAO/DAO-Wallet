import 'package:qmlkit/net/net_client.dart';
import 'package:qmlkit/net/net_request.dart';

NetRequest get netRequest => NetNative();

class NetNative extends NetRequest {
  NetNative() : super(NetClient());
}
