import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:evry_sim_in_phone/evry_sim_in_phone.dart';

void main() {
  const MethodChannel channel = MethodChannel('evry_sim_in_phone');

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
    expect(await EvrySimInPhone.platformVersion, '42');
  });
}
