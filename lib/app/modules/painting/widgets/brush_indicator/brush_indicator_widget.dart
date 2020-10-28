import 'package:flutter/material.dart';

import '../../painting_controller.dart';

class BrushIndicatorWidget extends StatefulWidget {
  final PaintingController controller;

  const BrushIndicatorWidget({Key key, this.controller}) : super(key: key);

  @override
  _BrushIndicatorWidgetState createState() =>
      _BrushIndicatorWidgetState(controller);
}

class _BrushIndicatorWidgetState extends State<BrushIndicatorWidget> {
  final PaintingController controller;

  _BrushIndicatorWidgetState(this.controller);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Paint>(
        stream: controller.styleViewModel.paintStream,
        initialData: controller.styleViewModel.defaultPaintingStyle,
        builder: (context, snapshot) {
          return Container(
            height: 3 * 15.0,
            child: AnimatedContainer(
              width: snapshot.data.strokeWidth * 15.0,
              height: snapshot.data.strokeWidth * 15.0,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: snapshot.data.color,
              ),
              duration: Duration(milliseconds: 200),
              curve: Curves.decelerate,
            ),
          );
        });
  }
}
