import 'package:flutter/material.dart';
import 'package:paint_your_life/app/modules/painting/painting_controller.dart';
import 'package:paint_your_life/app/modules/painting/widgets/brush_indicator/brush_indicator_widget.dart';

class PaintingStyleDialogWidget extends StatefulWidget {
  final PaintingController controller;

  const PaintingStyleDialogWidget({Key key, this.controller}) : super(key: key);

  @override
  _PaintingStyleDialogWidgetState createState() =>
      _PaintingStyleDialogWidgetState(controller);
}

class _PaintingStyleDialogWidgetState extends State<PaintingStyleDialogWidget> {
  final PaintingController controller;

  _PaintingStyleDialogWidgetState(this.controller);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        padding: const EdgeInsets.all(25.0),
        color: Colors.white,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            BrushIndicatorWidget(
              controller: controller,
            ),
            Divider(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Stroke Size"),
                StreamBuilder<double>(
                  stream: controller.styleViewModel.strokeStream,
                  builder: (context, snapshot) {
                    return Slider(
                        onChanged: controller.styleViewModel.strokeEvent.add,
                        value: snapshot.data ?? 1.0,
                        divisions: 2,
                        min: 1.0,
                        max: 3.0,
                        label: snapshot.data.toString());
                  },
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Red"),
                StreamBuilder<double>(
                    stream: controller.styleViewModel.redStream,
                    initialData: .0,
                    builder: (context, snapshot) {
                      return Slider(
                        min: .0,
                        max: 255,
                        value: snapshot.data,
                        onChanged: controller.styleViewModel.redEvent.add,
                      );
                    })
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Green"),
                StreamBuilder<double>(
                    stream: controller.styleViewModel.greenStream,
                    initialData: .0,
                    builder: (context, snapshot) {
                      return Slider(
                        min: .0,
                        max: 255,
                        value: snapshot.data,
                        onChanged: controller.styleViewModel.greenEvent.add,
                      );
                    })
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Blue"),
                StreamBuilder<double>(
                    stream: controller.styleViewModel.blueStream,
                    initialData: .0,
                    builder: (context, snapshot) {
                      return Slider(
                        min: .0,
                        max: 255,
                        value: snapshot.data,
                        onChanged: controller.styleViewModel.blueEvent.add,
                      );
                    })
              ],
            )
          ],
        ),
      ),
    );
  }
}
