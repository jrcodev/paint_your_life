import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'widgets/painting_area/painting_area_widget.dart';

class PaintingPage extends StatefulWidget {
  @override
  _PaintingPageState createState() => _PaintingPageState();
}
// TODO: Create customizing tab for brushes, undo, and other options

class _PaintingPageState extends State<PaintingPage> {
  @override
  void initState() {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
    SystemChrome.setEnabledSystemUIOverlays([]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: PaintingArea(),
    ));
  }

  @override
  void dispose() {
    super.dispose();
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
