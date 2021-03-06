import 'package:flutter/material.dart';
import 'package:screens/screen_widget.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ScreenWidget(
        statusBarBrightness: Brightness.dark,
        backgroundColor: Colors.brown,
        child: Container(),
      )..errorStreamController.add('Something went really wrong!'),
    );
  }
}
