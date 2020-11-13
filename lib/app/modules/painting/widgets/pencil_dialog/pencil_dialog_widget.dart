import 'package:flutter/material.dart';
import 'package:paint_your_life/app/modules/painting/painting_controller.dart';
import '../../utils/utils.dart';

class PencilDialogWidget extends StatefulWidget {
  final PaintingController _controller;

  const PencilDialogWidget(this._controller);
  @override
  _PencilDialogWidgetState createState() =>
      _PencilDialogWidgetState(_controller);
}

class _PencilDialogWidgetState extends State<PencilDialogWidget> {
  final PaintingController _controller;

  _PencilDialogWidgetState(this._controller);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (BuildContext context, Widget child) {
        return Dialog(
          elevation: .0,
          child: Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ClipPath(
                  child: Container(
                    height: 64,
                    width: double.infinity,
                    child: CustomPaint(
                        foregroundPainter:
                            PencilPainter(_controller.currentPaint)),
                  ),
                ),
                const SizedBox(
                  height: 16.0,
                ),
                Column(
                  children: [
                    Text("Stroke"),
                    Slider(
                      activeColor:
                          Theme.of(context).primaryMaterialColor.shade600,
                      inactiveColor:
                          Theme.of(context).primaryMaterialColor.shade100,
                      label: "${_controller.currentPaint.strokeWidth}",
                      onChanged: (width) {
                        _controller.setCurrentPaint(_controller.currentPaint
                            .copyWith(newStrokeWidth: width));
                      },
                      value: _controller.currentPaint.strokeWidth,
                      min: 1.0,
                      max: 7.0,
                    )
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class PencilPainter extends CustomPainter {
  final Paint currentPaint;

  PencilPainter(this.currentPaint);

  @override
  void paint(Canvas canvas, Size size) {
    print(size);
    canvas.drawPath(
        Path()
          ..moveTo(16.0, size.height / 2)
          ..quadraticBezierTo(
            size.width * .3,
            size.height * .9,
            size.width * .6,
            size.height / 2,
          )
          ..quadraticBezierTo(
            size.width * .9,
            size.height * .1,
            size.width - 16.0,
            size.height / 2,
          ),
        currentPaint);
  }

  @override
  bool shouldRepaint(PencilPainter oldDelegate) => false;

  @override
  bool shouldRebuildSemantics(PencilPainter oldDelegate) => false;
}

extension on ThemeData {
  MaterialColor get primaryMaterialColor => primaryColor as MaterialColor;
}
