import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:memento/memento.dart';
import 'app/app_widget.dart';
import 'app/modules/painting/models/path_with_paint.dart';
import 'app/modules/painting/painting_controller.dart';
import 'app/modules/painting/widgets/painting_area/painting_area_viewmodel.dart';
import 'app/modules/painting/widgets/style_dialog/style_dialog_viewmodel.dart';

final $i = GetIt.I;
void main() {
  $i.registerSingleton(PaintingAreaViewModel());
  $i.registerSingleton(StyleDialogViewModel());
  $i.registerSingleton(
    Caretaker($i.get<PaintingAreaViewModel>(), 25),
  );
  $i.registerSingleton(PaintingController(
      $i.get<PaintingAreaViewModel>(),
      $i.get<StyleDialogViewModel>(),
      $i.get<Caretaker<List<PathWithPaint>>>()));
  runApp(PaintYourLifeAppWidget());
}
