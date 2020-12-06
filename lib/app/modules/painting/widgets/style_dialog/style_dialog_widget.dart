import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:paint_your_life/app/modules/painting/widgets/style_dialog/style_slider_widget.dart';

import '../../utils/utils.dart';
import 'style_dialog_viewmodel.dart';

class StyleDialogWidget extends StatefulWidget {
  @override
  _StyleDialogWidgetState createState() => _StyleDialogWidgetState();
}

class _StyleDialogWidgetState extends State<StyleDialogWidget> {
  final _viewmodel = GetIt.I.get<StyleDialogViewModel>();
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _viewmodel,
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
                            PencilPainter(_viewmodel.currentPaint)),
                  ),
                ),
                const SizedBox(
                  height: 16.0,
                ),
                StyleSliderWidget(
                  title: "Stroke",
                  onChangeValue: (width) {
                    _viewmodel.setCurrentPaint(_viewmodel.currentPaint
                        .copyWith(newStrokeWidth: width));
                  },
                  value: _viewmodel.currentPaint.strokeWidth,
                  color: Theme.of(context).primaryColor,
                  min: 1.0,
                  max: 7.0,
                ),
                Column(
                  children: [
                    const Text("Red"),
                    Slider(
                      activeColor:
                          Theme.of(context).primaryMaterialColor.shade600,
                      inactiveColor:
                          Theme.of(context).primaryMaterialColor.shade100,
                      onChanged: (red) {
                        Color currentColor = _viewmodel.currentPaint.color;
                        _viewmodel.setCurrentPaint(_viewmodel.currentPaint
                            .copyWith(
                                newColor: currentColor.withRed(red.floor())));
                      },
                      value: _viewmodel.currentPaint.color.red.toDouble(),
                      min: .0,
                      max: 255.0,
                    )
                  ],
                ),
                Column(
                  children: [
                    const Text("Green"),
                    Slider(
                      activeColor:
                          Theme.of(context).primaryMaterialColor.shade600,
                      inactiveColor:
                          Theme.of(context).primaryMaterialColor.shade100,
                      onChanged: (green) {
                        Color currentColor = _viewmodel.currentPaint.color;
                        _viewmodel.setCurrentPaint(_viewmodel.currentPaint
                            .copyWith(
                                newColor:
                                    currentColor.withGreen(green.floor())));
                      },
                      value: _viewmodel.currentPaint.color.green.toDouble(),
                      min: .0,
                      max: 255.0,
                    )
                  ],
                ),
                Column(
                  children: [
                    const Text("Blue"),
                    Slider(
                      activeColor:
                          Theme.of(context).primaryMaterialColor.shade600,
                      inactiveColor:
                          Theme.of(context).primaryMaterialColor.shade100,
                      onChanged: (blue) {
                        Color currentColor = _viewmodel.currentPaint.color;
                        _viewmodel.setCurrentPaint(_viewmodel.currentPaint
                            .copyWith(
                                newColor: currentColor.withBlue(blue.floor())));
                      },
                      value: _viewmodel.currentPaint.color.blue.toDouble(),
                      min: .0,
                      max: 255.0,
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
