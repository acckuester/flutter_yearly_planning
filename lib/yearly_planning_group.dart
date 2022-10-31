part of 'yearly_planning.dart';

class YearlyPlanningGroup {
  YearlyPlanningGroup({
    required this.label,
    required this.color,
    required this.onColor,
    required this.items,
    this.priority = 0,
  });

  final String label;
  final Color color;
  final Color onColor;
  final List<YearlyPlanningItem> items;
  final int priority;
}
