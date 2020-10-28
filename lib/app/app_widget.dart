import 'package:flutter/material.dart';
import 'package:paint_your_life/app/modules/painting/painting_page.dart';

class PaintYourLifeAppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Paint Your Life",
      home: PaintingPage(),
    );
  }
}
