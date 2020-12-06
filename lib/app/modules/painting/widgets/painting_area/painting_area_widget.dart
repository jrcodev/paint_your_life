import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get_it/get_it.dart';
import 'package:rxdart/rxdart.dart';

import '../../models/path_with_paint.dart';
import '../../painting_controller.dart';

class PaintingAreaWidget extends StatefulWidget {
  @override
  _PaintingAreaWidgetState createState() => _PaintingAreaWidgetState();
}

class _PaintingAreaWidgetState extends State<PaintingAreaWidget> {
  final _controller = GetIt.I.get<PaintingController>();
  final _panStreamController = BehaviorSubject<bool>();
  StreamSubscription<bool> _subscription;

  Stream<bool> get panStream =>
      _panStreamController.debounceTime(Duration(milliseconds: 400));

  @override
  void initState() {
    super.initState();
    _subscription = panStream.listen((endEvent) {
      if (endEvent) _controller.animationController.reverse();
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onPanStart: (details) {
          _controller.onStartPaint(details);
          _controller.animationController.forward();
          _panStreamController.add(false);
        },
        onPanUpdate: _controller.onUpdatePaint,
        onPanEnd: (_) {
          _panStreamController.add(true);
        },
        child: AnimatedBuilder(
          animation: _controller.paintingViewModel,
          builder: (_, __) {
            return CustomPaint(
              foregroundPainter: PaintingAreaPainter(
                _controller.paintingViewModel.paths,
              ),
              child: Container(
                color: Colors.white,
              ),
            );
          },
        ));
  }

  @override
  void dispose() {
    _subscription.cancel();
    _panStreamController.close();
    super.dispose();
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
