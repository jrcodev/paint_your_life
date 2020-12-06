import 'package:flutter/animation.dart';
import 'package:flutter/gestures.dart';
import 'package:memento/memento.dart';

import 'models/path_with_paint.dart';
import 'widgets/painting_area/painting_area_viewmodel.dart';
import 'widgets/style_dialog/style_dialog_viewmodel.dart';

class PaintingController {
  final PaintingAreaViewModel paintingViewModel;
  final StyleDialogViewModel stylingViewModel;
  final Caretaker<List<PathWithPaint>> _caretaker;
  AnimationController animationController;
  Animation translateButtonUp;

  PaintingController(
    this.paintingViewModel,
    this.stylingViewModel,
    this._caretaker,
  );

  void onStartPaint(DragStartDetails details) {
    _caretaker.makeSnapshot();
    paintingViewModel.startPainting(
      details.localPosition,
      stylingViewModel.currentPaint,
    );
  }

  void onUpdatePaint(DragUpdateDetails details) {
    paintingViewModel.updatePainting(details.localPosition);
  }

  void onEndPaint(_) {}

  void undo() => _caretaker.undo();

  bool get canUndo => _caretaker.hasMemento;
}
