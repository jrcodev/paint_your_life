import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:memento/memento.dart';
import '../../models/path_with_paint.dart';

class PaintingAreaViewModel extends ChangeNotifier
    implements Originator<List<PathWithPaint>> {
  List<PathWithPaint> paths = [];

  double currentX = .0, currentY = .0, eventX = .0, eventY = .0;

  void startPainting(Offset point, Paint currentPaint) {
    eventX = point.dx;
    eventY = point.dy;
    currentX = eventX;
    currentY = eventY;
    paths.add(PathWithPaint(currentPaint)..moveTo(eventX, eventY));
  }

  void updatePainting(Offset point) {
    eventX = point.dx;
    eventY = point.dy;
    paths.last.quadraticBezierTo(
      currentX,
      currentY,
      (eventX + currentX) / 2,
      (eventY + currentY) / 2,
    );
    currentX = eventX;
    currentY = eventY;
    notifyListeners();
  }

  @override
  Memento<List<PathWithPaint>> save() {
    return Memento(List.from(paths), this);
  }

  @override
  void setState(List<PathWithPaint> state) {
    paths = state;
    notifyListeners();
  }
}
