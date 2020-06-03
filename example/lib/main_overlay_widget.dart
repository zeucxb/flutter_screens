import 'package:example/custom_error_widget.dart';
import 'package:flutter/material.dart';
import 'package:screens/overlay_widget.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: OverlayWidget(
        Scaffold(
          body: Container(),
        ),
        errorOverlay: CustomErrorWidget(),
      )..errorStreamController.add('Something went really wrong!'),
    );
  }
}
