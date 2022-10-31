part of 'yearly_planning.dart';

class YearlyPlanningSelection {
  YearlyPlanningSelection({
    this.startDate,
    this.endDate,
    this.isStartDateHalfDate = false,
    this.isEndDateHalfDate = false,
  });

  final DateTime? startDate;
  final DateTime? endDate;
  final bool isStartDateHalfDate;
  final bool isEndDateHalfDate;
}
