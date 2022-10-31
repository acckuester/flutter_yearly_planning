import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'yearly_planning_method_channel.dart';

abstract class YearlyPlanningPlatform extends PlatformInterface {
  /// Constructs a YearlyPlanningPlatform.
  YearlyPlanningPlatform() : super(token: _token);

  static final Object _token = Object();

  static YearlyPlanningPlatform _instance = MethodChannelYearlyPlanning();

  /// The default instance of [YearlyPlanningPlatform] to use.
  ///
  /// Defaults to [MethodChannelYearlyPlanning].
  static YearlyPlanningPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [YearlyPlanningPlatform] when
  /// they register themselves.
  static set instance(YearlyPlanningPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
