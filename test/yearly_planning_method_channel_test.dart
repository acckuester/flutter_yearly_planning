import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:yearly_planning/yearly_planning_method_channel.dart';

void main() {
  MethodChannelYearlyPlanning platform = MethodChannelYearlyPlanning();
  const MethodChannel channel = MethodChannel('yearly_planning');

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
    expect(await platform.getPlatformVersion(), '42');
  });
}
