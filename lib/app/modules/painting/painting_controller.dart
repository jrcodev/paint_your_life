import 'dart:async';

import 'package:paint_your_life/app/modules/painting/snapshot/snapshot.dart';
import 'package:paint_your_life/app/modules/painting/widgets/painting_area/painting_area_viewmodel.dart';
import 'package:paint_your_life/app/modules/painting/widgets/style_dialog/painting_style_viewmodel.dart';

class PaintingController {
  final areaViewModel = PaintingAreaViewModel();
  final styleViewModel = PaintingStyleViewModel();
  final _undoStreamController = StreamController<bool>();
  Stream get undoStream => _undoStreamController.stream;
  CareTaker _careTaker;

  PaintingController() {
    _careTaker = CareTaker(areaViewModel);
  }

  void onPaint() {
    _careTaker.makeSnapshot();
    _undoStreamController.add(true);
  }

  void undo() {
    _careTaker.undo();
    if (!_careTaker.hasSnapshot) {
      _undoStreamController.add(false);
    }
  }

  void dispose() {
    areaViewModel.dispose();
    styleViewModel.dispose();
    _undoStreamController.close();
  }
}
