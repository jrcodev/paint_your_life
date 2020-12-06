import 'package:flutter/material.dart';

typedef OnChangeValueCallback = void Function(double);

class StyleSliderWidget extends StatelessWidget {
  final OnChangeValueCallback onChangeValue;
  final double value;
  final MaterialColor color;
  final double min;
  final double max;
  final String title;

  const StyleSliderWidget({
    @required this.title,
    @required this.onChangeValue,
    @required this.value,
    @required this.color,
    @required this.min,
    @required this.max,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(title),
        Slider(
          activeColor: color.shade600,
          inactiveColor: color.shade100,
          onChanged: onChangeValue,
          value: value,
          min: min,
          max: max,
        )
      ],
    );
  }
}
