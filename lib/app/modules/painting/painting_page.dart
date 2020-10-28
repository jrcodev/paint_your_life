import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:paint_your_life/app/modules/painting/painting_controller.dart';
import 'package:paint_your_life/app/modules/painting/widgets/painting_area/painting_area_widget.dart';
import 'package:paint_your_life/app/modules/painting/widgets/style_dialog/painting_style_dialog_widget.dart';
import 'package:path_provider/path_provider.dart';

class PaintingPage extends StatefulWidget {
  @override
  _PaintingPageState createState() => _PaintingPageState();
}

class _PaintingPageState extends State<PaintingPage> {
  final PaintingController controller = PaintingController();
  GlobalKey _globalKey = new GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Paint Your Life"),
          elevation: .0,
          actions: [
            StreamBuilder(
              stream: controller.undoStream,
              initialData: false,
              builder: (context, snapshot) {
                return IconButton(
                  icon: Icon(Icons.undo),
                  onPressed: snapshot.data
                      ? () {
                          controller.undo();
                        }
                      : null,
                );
              },
            ),
            IconButton(
              icon: Icon(Icons.palette),
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (_) => PaintingStyleDialogWidget(
                          controller: controller,
                        ));
              },
            ),
            Builder(
                builder: (context) => IconButton(
                      icon: Icon(Icons.save),
                      onPressed: () {
                        _save().then((value) async {
                          var path = await getExternalStorageDirectory();
                          print(path);
                          File file = File(
                              '${path.path}/${DateTime.now().millisecondsSinceEpoch}.png');
                          file.writeAsBytes(value);
                          Scaffold.of(context).showSnackBar(SnackBar(
                            content: Text("Done!"),
                          ));
                        });
                      },
                    )),
          ],
        ),
        body: SafeArea(
          child: RepaintBoundary(
              key: _globalKey,
              child: PaintingAreaWidget(controller: controller)),
        ));
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  // ignore: missing_return
  Future<Uint8List> _save() async {
    try {
      RenderRepaintBoundary boundary =
          _globalKey.currentContext.findRenderObject();
      var image = await boundary.toImage(pixelRatio: 3.0);
      ByteData byteData = await image.toByteData(format: ImageByteFormat.png);
      var pngBytes = byteData.buffer.asUint8List();
      var bs64 = base64Encode(pngBytes);
      print(pngBytes);
      print(bs64);
      setState(() {});
      return pngBytes;
    } catch (e) {
      print(e);
    }
  }
}
