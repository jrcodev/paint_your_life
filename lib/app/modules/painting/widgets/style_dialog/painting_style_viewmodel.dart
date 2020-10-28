import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class PaintingStyleViewModel {
  final _strokeSizeStreamController = BehaviorSubject.seeded(1.0);
  final _redStreamController = BehaviorSubject.seeded(.0);
  final _greenStreamController = BehaviorSubject.seeded(.0);
  final _blueStreamController = BehaviorSubject.seeded(.0);
  var currentPaint;

  PaintingStyleViewModel() {
    currentPaint = defaultPaintingStyle;
    paintStream.listen((paint) {
      currentPaint = paint;
    });
  }

  Sink get strokeEvent => _strokeSizeStreamController.sink;
  Sink get redEvent => _redStreamController.sink;
  Sink get greenEvent => _greenStreamController.sink;
  Sink get blueEvent => _blueStreamController.sink;
  Stream<double> get redStream => _redStreamController.stream;
  Stream<double> get greenStream => _greenStreamController.stream;
  Stream<double> get blueStream => _blueStreamController.stream;
  Stream<double> get strokeStream => _strokeSizeStreamController.stream;

  Stream<Paint> get paintStream => Rx.combineLatest4(
      strokeStream,
      redStream,
      greenStream,
      blueStream,
      (double a, double r, double g, double b) => Paint()
        ..color = Color.fromARGB(255, r.floor(), g.floor(), b.floor())
        ..strokeWidth = a
        ..strokeJoin = StrokeJoin.round
        ..strokeCap = StrokeCap.round);

  Paint get defaultPaintingStyle => Paint()
    ..color = Colors.black
    ..strokeWidth = 1.0
    ..strokeJoin = StrokeJoin.round
    ..strokeCap = StrokeCap.round
    ..style = PaintingStyle.stroke;

  void dispose() {
    _strokeSizeStreamController.close();
    _redStreamController.close();
    _greenStreamController.close();
    _blueStreamController.close();
  }
}
