import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'models/path_with_paint.dart';
import 'snapshot/snapshot.dart';

class PaintingController extends ChangeNotifier implements Originator {
  List<PathWithPaint> paths = [];
  double currentX = .0, currentY = .0, eventX = .0, eventY = .0;
  AnimationController animationController;
  Animation translateButtonUp;
  Paint currentPaint = defaultPaint;
  static final Paint defaultPaint = Paint()
    ..color = Colors.black
    ..isAntiAlias = true
    ..style = PaintingStyle.stroke
    ..strokeCap = StrokeCap.round
    ..strokeJoin = StrokeJoin.round
    ..strokeWidth = 1
    ..isAntiAlias = true;

  CareTaker _caretaker;

  PaintingController() {
    _caretaker = CareTaker(this);
  }

  void onPaintStart(DragStartDetails details) {
    debugPrint('CAN UNDO: $canUndo');

    _caretaker.makeSnapshot();
    eventX = details.localPosition.dx;
    eventY = details.localPosition.dy;
    currentX = eventX;
    currentY = eventY;
    paths.add(PathWithPaint(currentPaint)..moveTo(eventX, eventY));
    animationController.forward();
  }

  void onPaintUpdate(DragUpdateDetails details) {
    eventX = details.localPosition.dx;
    eventY = details.localPosition.dy;
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

  void onPaintEnd(_) {
    animationController.reverse();
  }

  bool get canUndo => _caretaker.hasSnapshot;

  void undo() => _caretaker.undo();

  void setCurrentPaint(Paint newPaint) {
    currentPaint = newPaint;
    notifyListeners();
  }

  @override
  Snapshot save() {
    return Snapshot(List.from(paths), this);
  }

  @override
  void setState(List<PathWithPaint> state) {
    debugPrint('SET STATE: $state');
    paths = state;
    notifyListeners();
  }
}
