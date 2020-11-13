import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../../models/path_with_paint.dart';
import '../../painting_controller.dart';

class PaintingAreaWidget extends StatefulWidget {
  final PaintingController _controller;

  const PaintingAreaWidget(this._controller);
  @override
  _PaintingAreaWidgetState createState() =>
      _PaintingAreaWidgetState(_controller);
}

class _PaintingAreaWidgetState extends State<PaintingAreaWidget> {
  final PaintingController _controller;

  _PaintingAreaWidgetState(this._controller);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onPanStart: _controller.onPaintStart,
        onPanUpdate: _controller.onPaintUpdate,
        onPanEnd: _controller.onPaintEnd,
        child: AnimatedBuilder(
          animation: _controller,
          builder: (_, __) {
            return CustomPaint(
              foregroundPainter: PaintingAreaPainter(_controller.paths),
              child: Container(
                color: Colors.white,
              ),
            );
          },
        ));
  }
}

class PaintingAreaPainter extends CustomPainter {
  final List<PathWithPaint> paths;

  PaintingAreaPainter(this.paths);
  @override
  void paint(Canvas canvas, Size size) {
    for (PathWithPaint path in paths) {
      canvas.drawPath(path, path.paint);
    }
  }

  @override
  bool shouldRepaint(PaintingAreaPainter oldDelegate) => true;

  @override
  bool shouldRebuildSemantics(PaintingAreaPainter oldDelegate) => false;
}
