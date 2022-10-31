part of 'yearly_planning.dart';

class _LabelBox extends StatelessWidget {
  const _LabelBox({
    required this.color,
    required this.daySize,
    required this.label,
    required this.aspectRatio,
    this.borderColor,
    this.textColor,
    Key? key,
  }) : super(key: key);

  factory _LabelBox.short({
    required BuildContext context,
    required Color color,
    required double daySize,
    required String label,
    required TextStyle? style,
    required double aspectRatio,
    required Color? borderColor,
    required Color? textColor,
  }) {
    return _LabelBox(
      color: color,
      daySize: daySize,
      label: Text(
        label,
        style: style?.copyWith(color: textColor) ??
            Theme.of(context).textTheme.bodyText2!.copyWith(
                  fontSize: 10,
                  color: textColor,
                ),
      ),
      aspectRatio: aspectRatio,
      borderColor: borderColor,
      textColor: textColor,
    );
  }

  final Color color;
  final double daySize;
  final Widget label;
  final double aspectRatio;
  final Color? borderColor;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        const SizedBox(width: 4),
        Container(
          height: daySize * aspectRatio,
          width: daySize,
          decoration: BoxDecoration(
            border: Border.all(
                color: borderColor ??
                    Theme.of(context).primaryColor.withAlpha(50)),
            color: color,
          ),
        ),
        const SizedBox(width: 2),
        label,
      ],
    );
  }
}
