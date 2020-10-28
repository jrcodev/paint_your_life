import 'package:flutter/cupertino.dart';

class Line {
  final List<Offset> points = [];
  Paint paintingStyle;

  void addPoint(Offset point) => points.add(point);
}
