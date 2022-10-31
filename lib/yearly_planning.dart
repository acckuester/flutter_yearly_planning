import 'package:flutter/material.dart';
import 'package:yearly_planning/yearly_planning_extensions.dart';

export 'yearly_planning_extensions.dart';
import 'yearly_planning_platform_interface.dart';

part 'month_box.dart';
part 'label_box.dart';
part 'day_box.dart';
part 'yearly_planning_group.dart';
part 'yearly_planning_item.dart';
part 'yearly_planning_plugin.dart';
part 'yearly_planning_selection.dart';

class YearlyPlanning extends StatelessWidget {
  const YearlyPlanning({
    required this.groups,
    required this.year,
    required this.title,
    this.aspectRatio = 1.5,
    this.selection,
    this.selectionColor,
    this.backgroundColor,
    this.dayBorderColor,
    this.textColor,
    this.weekendColor,
    this.monthToString,
    this.width,
    this.weekendLabel,
    this.selectionLabel,
    this.padding = const EdgeInsets.all(8),
    this.borderRadius,
    this.border,
    this.labelStyle,
    this.margin = EdgeInsets.zero,
    this.dayStyle,
    this.onDatePressed,
    this.onSelectionColor,
    this.onWeekendColor,
    Key? key,
  }) : super(key: key);

  final List<YearlyPlanningGroup> groups;
  final int year;
  final double aspectRatio;
  final Widget? title;
  final YearlyPlanningSelection? selection;
  final Color? selectionColor;
  final Color? dayBorderColor;
  final Color? backgroundColor;
  final Color? textColor;
  final Color? weekendColor;
  final double? width;
  final EdgeInsets padding;
  final EdgeInsets margin;
  final BorderRadiusGeometry? borderRadius;
  final BoxBorder? border;
  final TextStyle? labelStyle;
  final String Function(BuildContext, DateTime)? monthToString;
  final String? weekendLabel;
  final String? selectionLabel;
  final TextStyle? dayStyle;
  final void Function(DateTime)? onDatePressed;
  final Color? onWeekendColor;
  final Color? onSelectionColor;

  DateTime get firstDayOfYear => DateTime(year);
  int get weekDayOffset => firstDayOfYear.weekday;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      padding: padding,
      margin: margin,
      decoration: BoxDecoration(
        borderRadius: borderRadius,
        color: backgroundColor ?? Theme.of(context).colorScheme.surface,
        border: border,
      ),
      child: LayoutBuilder(
        builder: (_, BoxConstraints constraints) {
          final double daySize = (constraints.maxWidth - 16) / 37;
          return Column(
            children: <Widget>[
              title ??
                  Text(
                    year.toString(),
                    style: Theme.of(context).textTheme.headline6!.copyWith(
                          color: textColor,
                        ),
                  ),
              const SizedBox(height: 6),
              Wrap(children: _getLabels(context, daySize).toList()),
              const SizedBox(height: 8),
              ...List<Widget>.generate(
                12,
                (int index) => _MonthBox(
                  year,
                  index + 1,
                  weekDayOffset,
                  daySize,
                  groups,
                  aspectRatio,
                  selection,
                  _getSelectionColor(context),
                  onSelectionColor,
                  dayBorderColor,
                  backgroundColor,
                  textColor,
                  _getWeekendColor(context),
                  onWeekendColor,
                  monthToString,
                  dayStyle,
                  onDatePressed,
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Iterable<_LabelBox> _getLabels(BuildContext context, double daySize) sync* {
    yield _LabelBox.short(
      context: context,
      color: _getWeekendColor(context),
      daySize: daySize,
      label: weekendLabel == null ? 'Weekend' : weekendLabel!,
      style: labelStyle,
      aspectRatio: aspectRatio,
      borderColor: dayBorderColor,
      textColor: textColor,
    );

    if (selection != null) {
      yield _LabelBox.short(
        context: context,
        color: _getSelectionColor(context),
        daySize: daySize,
        label: selectionLabel == null ? 'Selection' : selectionLabel!,
        style: labelStyle,
        aspectRatio: aspectRatio,
        borderColor: dayBorderColor,
        textColor: textColor,
      );
    }

    for (final YearlyPlanningGroup group in groups) {
      yield _LabelBox.short(
        context: context,
        color: group.color,
        daySize: daySize,
        label: group.label,
        style: labelStyle,
        aspectRatio: aspectRatio,
        borderColor: dayBorderColor,
        textColor: textColor,
      );
    }
  }

  Color _getWeekendColor(BuildContext context) {
    return weekendColor ?? Theme.of(context).primaryColor.withAlpha(50);
  }

  Color _getSelectionColor(BuildContext context) {
    return selectionColor ?? Theme.of(context).colorScheme.secondary;
  }
}
