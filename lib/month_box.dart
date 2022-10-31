part of 'yearly_planning.dart';

class _MonthBox extends StatelessWidget {
  const _MonthBox(
    this.year,
    this.monthOfYear,
    this.weekDayOffset,
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
    this.monthToString,
    this.dayStyle,
    this.onDatePressed, {
    Key? key,
  }) : super(key: key);

  final int year;
  final int monthOfYear;
  final int weekDayOffset;
  final double daySize;
  final List<YearlyPlanningGroup> groups;
  final double aspectRatio;
  final YearlyPlanningSelection? selection;
  final Color? selectionColor;
  final Color? onSelectionColor;
  final Color? borderColor;
  final Color? backgroundColor;
  final Color? textColor;
  final Color? weekendColor;
  final Color? onWeekendColor;
  final String Function(BuildContext, DateTime)? monthToString;
  final TextStyle? dayStyle;
  final void Function(DateTime)? onDatePressed;

  DateTime get month => DateTime(year, monthOfYear);

  @override
  Widget build(BuildContext context) {
    final int daysInMonth = month.daysInMonth();

    final int weekdayOfFirstDateOfMonth = month.weekday;
    final int offset = weekDayOffset > weekdayOfFirstDateOfMonth
        ? (7 - weekDayOffset) + weekdayOfFirstDateOfMonth
        : weekdayOfFirstDateOfMonth - weekDayOffset;

    final List<Widget> days = List<Widget>.generate(
      daysInMonth + offset,
      (int index) {
        final int day = index - offset + 1;
        if (day <= 0) {
          return SizedBox(height: daySize, width: daySize);
        }

        final DateTime date = DateTime(year, monthOfYear, day);

        return _DayBox(
            date,
            daySize,
            groups,
            aspectRatio,
            selection,
            selectionColor,
            onSelectionColor,
            borderColor,
            backgroundColor,
            textColor,
            weekendColor,
            onWeekendColor,
            dayStyle,
            onDatePressed);
      },
    );

    return Row(
      children: <Widget>[
        SizedBox(
          width: 14,
          child: Text(
            monthToString == null
                ? month.month.toString()
                : monthToString!(context, month),
            style: Theme.of(context).textTheme.bodyText2!.copyWith(
                  fontSize: 8,
                  color: textColor,
                ),
          ),
        ),
        const SizedBox(width: 2),
        ...days,
      ],
    );
  }
}
