import 'package:flutter/cupertino.dart';
import 'package:paint_your_life/app/modules/painting/models/path_with_paint.dart';

const SIZE_LIMIT_STACK = 20;

class Snapshot {
  final List<PathWithPaint> _state;
  final Originator _originator;

  Snapshot(this._state, this._originator);

  void restore() => _originator.setState(_state);
}

abstract class Originator {
  Snapshot save();
  void setState(List<PathWithPaint> state);
}

class CareTaker {
  final Originator _originator;
  final _snapshots = <Snapshot>[];

  CareTaker(this._originator);

  bool get hasSnapshot => _snapshots.isNotEmpty;

  void makeSnapshot() {
    if (_snapshots.length > SIZE_LIMIT_STACK) {
      _snapshots
        ..removeAt(0)
        ..add(_originator.save());
    } else {
      _snapshots.add(_originator.save());
    }
    debugPrint('MAKE SNAPSHOT: $_snapshots');
  }

  void undo() {
    debugPrint('UNDO: $_snapshots');
    if (_snapshots.isNotEmpty) {
      _snapshots.removeLast()..restore();
    }
  }
}
