import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StyleDialogViewModel extends ChangeNotifier {
  Paint currentPaint = defaultPaint;
  

  static final Paint defaultPaint = Paint()
    ..color = Colors.black
    ..style = PaintingStyle.stroke
    ..strokeCap = StrokeCap.round
    ..strokeWidth = 1
    ..isAntiAlias = true;

  void setCurrentPaint(Paint newPaint) {
    currentPaint = newPaint;
    notifyListeners();
  }
}
