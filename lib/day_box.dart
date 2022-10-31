part of 'yearly_planning.dart';

class _DayBox extends StatelessWidget {
  const _DayBox(
    this.date,
    this.daySize,
    this.groups,
    this.aspectRatio,
    this.selection,
    this.selectionColor,
    this.onSelectionColor,
    this.borderColor,
    this.backgroundColor,
    this.textColor,
    this.weekendColor,
    this.onWeekendColor,
    this.dayStyle,
    this.onDatePressed, {
    Key? key,
  }) : super(key: key);

  final DateTime date;
  final double daySize;
  final List<YearlyPlanningGroup> groups;
  final double aspectRatio;
  final YearlyPlanningSelection? selection;
  final Color? selectionColor;
  final Color? borderColor;
  final Color? backgroundColor;
  final Color? textColor;
  final Color? weekendColor;
  final TextStyle? dayStyle;
  final void Function(DateTime)? onDatePressed;
  final Color? onWeekendColor;
  final Color? onSelectionColor;

  bool get isSelection {
    if (selection == null) {
      return false;
    }

    final DateTime? selectionStart = selection!.startDate;
    final DateTime? selectionEnd = selection!.endDate;

    if (selectionStart != null && date.isSameDay(selectionStart)) {
      return true;
    }
    if (selectionEnd != null && date.isSameDay(selectionEnd)) {
      return true;
    }

    if (selectionStart != null &&
        selectionEnd != null &&
        date.isAfter(selectionStart) &&
        date.isBefore(selectionEnd)) {
      return true;
    }

    return false;
  }

  bool get isWeekend =>
      date.weekday == DateTime.saturday || date.weekday == DateTime.sunday;

  YearlyPlanningGroup? get group {
    final List<YearlyPlanningGroup> groupsWithDate = groups
        .where((YearlyPlanningGroup group) => group.items
            .map<DateTime>((YearlyPlanningItem e) => e.date)
            .contains(date))
        .toList();

    groupsWithDate.sort(
      (
        YearlyPlanningGroup a,
        YearlyPlanningGroup b,
      ) =>
          a.priority.compareTo(b.priority),
    );

    if (groupsWithDate.isEmpty) {
      return null;
    }

    return groupsWithDate.first;
  }

  @override
  Widget build(BuildContext context) {
    final Color? foregroundColor = isSelection
        ? onSelectionColor
        : isWeekend
            ? onWeekendColor
            : group?.onColor ?? textColor;

    return InkWell(
      onTap: onDatePressed == null ? null : () => onDatePressed!(date),
      child: Container(
        height: daySize * aspectRatio,
        width: daySize,
        decoration: _getDecoration(context),
        child: Center(
          child: Text(
            date.day.toString(),
            style: dayStyle?.copyWith(color: foregroundColor) ??
                Theme.of(context).textTheme.bodyText2!.copyWith(
                      fontSize: 7,
                      fontWeight: FontWeight.w100,
                      color: foregroundColor,
                    ),
          ),
        ),
      ),
    );
  }

  BoxDecoration _getDecoration(BuildContext context) {
    Color? color;
    bool isHalfDate = false;

    if (isWeekend) {
      color = weekendColor ?? Theme.of(context).primaryColor.withAlpha(50);
    }

    final YearlyPlanningGroup? yearlyPlanningGroup = group;
    if (yearlyPlanningGroup != null) {
      final YearlyPlanningItem item = yearlyPlanningGroup.items.firstWhere(
        (YearlyPlanningItem x) => x.date.isSameDay(date),
      );

      isHalfDate = item.isHalfDay;
      color = yearlyPlanningGroup.color;
    }

    if (isSelection) {
      final DateTime? selectionStart = selection!.startDate;
      final DateTime? selectionEnd = selection!.endDate;

      if (selectionStart != null && date.isSameDay(selectionStart)) {
        isHalfDate = selection!.isStartDateHalfDate;
      }
      if (selectionEnd != null && date.isSameDay(selectionEnd)) {
        isHalfDate = selection!.isEndDateHalfDate;
      }

      color = selectionColor;
    }

    if (color != null && isHalfDate) {
      return BoxDecoration(
        border: Border.all(
          color: borderColor ?? Theme.of(context).primaryColor.withAlpha(50),
        ),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: const <double>[0.0, 0.5, 0.5, 1],
          colors: <Color>[
            color,
            color,
            color.withAlpha(50),
            color.withAlpha(50),
          ],
        ),
      );
    }

    return BoxDecoration(
      border: Border.all(
          color: borderColor ?? Theme.of(context).primaryColor.withAlpha(50)),
      color: color,
    );
  }
}
