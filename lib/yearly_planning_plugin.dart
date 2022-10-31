part of 'yearly_planning.dart';

class YearlyPlanningPlugin {
  Future<String?> getPlatformVersion() {
    return YearlyPlanningPlatform.instance.getPlatformVersion();
  }
}
