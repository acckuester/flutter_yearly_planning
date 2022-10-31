import 'package:flutter_test/flutter_test.dart';
import 'package:yearly_planning/yearly_planning.dart';
import 'package:yearly_planning/yearly_planning_platform_interface.dart';
import 'package:yearly_planning/yearly_planning_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockYearlyPlanningPlatform
    with MockPlatformInterfaceMixin
    implements YearlyPlanningPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final YearlyPlanningPlatform initialPlatform = YearlyPlanningPlatform.instance;

  test('$MethodChannelYearlyPlanning is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelYearlyPlanning>());
  });

  test('getPlatformVersion', () async {
    YearlyPlanningPlugin yearlyPlanningPlugin = YearlyPlanningPlugin();
    MockYearlyPlanningPlatform fakePlatform = MockYearlyPlanningPlatform();
    YearlyPlanningPlatform.instance = fakePlatform;

    expect(await yearlyPlanningPlugin.getPlatformVersion(), '42');
  });
}
