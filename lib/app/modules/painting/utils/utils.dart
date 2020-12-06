import 'dart:ui';

import 'package:flutter/material.dart';

extension CopyWith on Paint {
  Paint copyWith({Color newColor, double newStrokeWidth}) {
    return Paint()
      ..color = newColor ?? color
      ..strokeWidth = newStrokeWidth ?? strokeWidth
      ..style = style
      ..isAntiAlias = isAntiAlias
      ..strokeCap = strokeCap
      ..strokeJoin = strokeJoin;
  }
}

extension ColorsMaterial on ThemeData {
  MaterialColor get primaryMaterialColor => primaryColor as MaterialColor;
}
