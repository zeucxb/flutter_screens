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
        brightness: Brightness.dark,
        backgroundColor: Colors.black,
        child: Container(),
      ),
    );
  }
}
