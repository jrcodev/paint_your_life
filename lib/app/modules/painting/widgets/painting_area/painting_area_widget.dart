import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:paint_your_life/app/modules/painting/models/line.dart';
import 'package:paint_your_life/app/modules/painting/painting_controller.dart';

class PaintingAreaWidget extends StatefulWidget {
  final PaintingController controller;

  const PaintingAreaWidget({Key key, this.controller}) : super(key: key);

  @override
  _PaintingAreaWidgetState createState() =>
      _PaintingAreaWidgetState(controller);
}

class _PaintingAreaWidgetState extends State<PaintingAreaWidget> {
  final PaintingController controller;
  _PaintingAreaWidgetState(this.controller);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onPanStart: (_) {
          controller.onPaint();
          controller.areaViewModel.createNewLine();
          controller.areaViewModel.lines.last.paintingStyle =
              controller.styleViewModel.currentPaint;
        },
        onPanUpdate: (details) =>
            controller.areaViewModel.addPoint(details.localPosition),
        child: StreamBuilder(
          stream: controller.areaViewModel.pointsStream,
          initialData: <Line>[],
          builder: (_, snapshot) {
            return CustomPaint(
              foregroundPainter: _PaintingAreaPainter(snapshot.data),
              child: Container(
                color: Colors.white,
              ),
            );
          },
        ));
  }
}

class _PaintingAreaPainter extends CustomPainter {
  final List<Line> lines;
  _PaintingAreaPainter(this.lines);

  @override
  void paint(Canvas canvas, Size size) {
    for (Line line in lines) {
      canvas.drawPoints(PointMode.polygon, line.points, line.paintingStyle);
    }
  }

  @override
  bool shouldRepaint(_PaintingAreaPainter oldDelegate) => true;

  @override
  bool shouldRebuildSemantics(_PaintingAreaPainter oldDelegate) => false;
}
