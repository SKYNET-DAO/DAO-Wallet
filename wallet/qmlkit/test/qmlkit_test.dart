import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:qmlkit/qmlkit.dart';

void main() {
  const MethodChannel channel = MethodChannel('qmlkit');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    print(10.3.awesome(2));
    print(01.30.awesome(2));
    print(0.030.awesome(2));
    print(0.0.awesome(2));
  });
}
