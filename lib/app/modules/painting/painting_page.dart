import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:paint_your_life/app/modules/painting/widgets/pencil_dialog/pencil_dialog_widget.dart';
import 'painting_controller.dart';

import 'widgets/painting_area/painting_area_widget.dart';

/*
  TODO: PENSAR EM COMO MANIPULAR AS CORES E TAMANHO DO PINCEL
  TODO: APERFEIÇOAR ANIMAÇÕES
  TODO: IMPLEMENTAR PADRÃO SNAPSHOT
  TODO: IMPLEMENTAR SALVAR IMAGEM NA GALERIA
*/

class PaintingPage extends StatefulWidget {
  @override
  _PaintingPageState createState() => _PaintingPageState();
}

class _PaintingPageState extends State<PaintingPage>
    with TickerProviderStateMixin {
  final _controller = PaintingController();

  @override
  void initState() {
    _controller.animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );
    super.initState();
  }

  @override
  void didChangeDependencies() {
    _controller.translateButtonUp = Tween<double>(
      begin: .0,
      end: 100.0,
    ).animate(_controller.animationController);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: Stack(
            children: [
              PaintingAreaWidget(_controller),
              Positioned(
                  left: 16,
                  bottom: 16,
                  child: AnimatedBuilder(
                      animation: _controller,
                      builder: (_, __) {
                        return AnimatedBuilder(
                          animation: _controller.translateButtonUp,
                          child: AnimatedOpacity(
                            opacity: _controller.canUndo ? 1 : .0,
                            duration: Duration(milliseconds: 300),
                            child: FloatingActionButton(
                              elevation: .0,
                              child: Icon(Icons.undo),
                              backgroundColor: Theme.of(context)
                                  .primaryMaterialColor
                                  .shade600,
                              onPressed:
                                  _controller.canUndo ? _controller.undo : null,
                            ),
                          ),
                          builder: (_, child) {
                            return Transform.translate(
                              offset: Offset(
                                  0, _controller.translateButtonUp.value),
                              child: child,
                            );
                          },
                        );
                      }))
            ],
          ),
        ),
        floatingActionButton: AnimatedBuilder(
            animation: _controller.translateButtonUp,
            child: SpeedDial(
              animatedIcon: AnimatedIcons.menu_close,
              closeManually: false,
              overlayColor: Colors.black,
              overlayOpacity: .1,
              elevation: .0,
              shape: CircleBorder(),
              backgroundColor: Theme.of(context).primaryMaterialColor,
              children: [
                SpeedDialChild(
                    child: Icon(Icons.brush),
                    backgroundColor:
                        Theme.of(context).primaryMaterialColor.shade600,
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (context) =>
                              PencilDialogWidget(_controller));
                    }),
                SpeedDialChild(
                    child: Icon(Icons.save),
                    backgroundColor:
                        Theme.of(context).primaryMaterialColor.shade700)
              ],
            ),
            builder: (_, child) {
              return Transform.translate(
                offset: Offset(0, _controller.translateButtonUp.value),
                child: child,
              );
            }));
  }

  // ignore: missing_return
//   Future<Uint8List> _save() async {
//     try {
//       RenderRepaintBoundary boundary =
//           _globalKey.currentContext.findRenderObject();
//       var image = await boundary.toImage(pixelRatio: 3.0);
//       ByteData byteData = await image.toByteData(format: ImageByteFormat.png);
//       var pngBytes = byteData.buffer.asUint8List();
//       var bs64 = base64Encode(pngBytes);
//       print(pngBytes);
//       print(bs64);
//       setState(() {});
//       return pngBytes;
//     } catch (e) {
//       print(e);
//     }
//   }
}

extension on ThemeData {
  MaterialColor get primaryMaterialColor => primaryColor as MaterialColor;
}
