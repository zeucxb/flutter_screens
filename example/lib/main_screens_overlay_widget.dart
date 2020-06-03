import 'package:example/custom_error_widget.dart';
import 'package:flutter/material.dart';
import 'package:screens/screens.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Screens(
        errorOverlay: CustomErrorWidget(),
      ).overlay(
        Scaffold(
          body: Container(),
        ),
      )..errorStreamController.add('Something went really wrong!'),
    );
  }
}
