import 'dart:async';
import 'dart:ui';

import 'package:paint_your_life/app/modules/painting/models/line.dart';
import 'package:paint_your_life/app/modules/painting/snapshot/snapshot.dart';

class PaintingAreaViewModel implements Originator {
  var lines = <Line>[];

  final _streamController = StreamController<List<Line>>();
  Stream get pointsStream => _streamController.stream;

  void addPoint(Offset point) {
    _streamController.add(lines..last.addPoint(point));
  }

  void createNewLine() => lines.add(Line());

  void dispose() {
    _streamController.close();
  }

  @override
  Snapshot save() {
    return Snapshot(List.from(lines), this);
  }

  @override
  void setState(List<Line> state) {
    lines = state;
    _streamController.add(lines);
  }
}
