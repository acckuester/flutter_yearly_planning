part of 'yearly_planning.dart';

class YearlyPlanningItem {
  const YearlyPlanningItem(
    this.date, {
    this.isHalfDay = false,
  });

  final DateTime date;
  final bool isHalfDay;
}
