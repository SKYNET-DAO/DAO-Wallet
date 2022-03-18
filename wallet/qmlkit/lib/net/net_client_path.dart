//ignore: uri_does_not_exist
export 'net_client_stub.dart'
    if (dart.library.io) 'net_client.dart'
    if (dart.library.html) 'net_client_web.dart';
