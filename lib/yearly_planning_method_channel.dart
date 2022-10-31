import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'yearly_planning_platform_interface.dart';

/// An implementation of [YearlyPlanningPlatform] that uses method channels.
class MethodChannelYearlyPlanning extends YearlyPlanningPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('yearly_planning');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
