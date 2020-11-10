import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class PaintingArea extends StatefulWidget {
  @override
  _PaintingAreaState createState() => _PaintingAreaState();
}

class _PaintingAreaState extends State<PaintingArea> {
  List<Path> paths = [];
  double currentX = .0, currentY = .0, eventX = .0, eventY = .0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanStart: _onPanStart,
      onPanUpdate: _onPanUpdate,
      child: CustomPaint(
        foregroundPainter: PaintingAreaPainter(paths),
        child: Container(
          color: Colors.white,
        ),
      ),
    );
  }

  void _onPanStart(DragStartDetails details) {
    eventX = details.localPosition.dx;
    eventY = details.localPosition.dy;
    currentX = eventX;
    currentY = eventY;
    paths.add(Path()..moveTo(eventX, eventY));
  }

  void _onPanUpdate(DragUpdateDetails details) {
    setState(() {
      print(paths);
      eventX = details.localPosition.dx;
      eventY = details.localPosition.dy;
      paths.last.quadraticBezierTo(
          currentX, currentY, (eventX + currentX) / 2, (eventY + currentY) / 2);
      currentX = eventX;
      currentY = eventY;
    });
  }
}

class PaintingAreaPainter extends CustomPainter {
  final List<Path> paths;
  var painting = Paint()
    ..color = Colors.black
    ..style = PaintingStyle.stroke
    ..strokeCap = StrokeCap.round
    ..strokeJoin = StrokeJoin.round
    ..strokeWidth = 3.0
    ..isAntiAlias = true;

  PaintingAreaPainter(this.paths);
  @override
  void paint(Canvas canvas, Size size) {
    print(paths);
    for (Path path in paths) {
      canvas.drawPath(path, painting);
    }
  }

  @override
  bool shouldRepaint(PaintingAreaPainter oldDelegate) => true;

  @override
  bool shouldRebuildSemantics(PaintingAreaPainter oldDelegate) => false;
}
