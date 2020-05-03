import 'package:example/custom_error_widget.dart';
import 'package:example/custom_loader_widget.dart';
import 'package:example/custom_overlay_widget.dart';
import 'package:flutter/material.dart';
import 'package:screens/screens.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Screens(
        fixedOverlayWidgets: [
          Banner(
            message: 'Test',
            location: BannerLocation.topStart,
          )
        ],
        screenEvents: {
          'icons': CustomOverlayWidget(),
        },
        loaderWidget: CustomLoaderWidget(),
        errorOverlay: CustomErrorWidget(),
      ).widget(
        statusBerBrightness: Brightness.light,
        backgroundColor: Colors.brown,
        child: Container(),
      )
        ..eventsStreamController.add(
          ScreenEvent('icons', Icons.access_alarm),
        )
        ..loaderStreamController.add(true)
        ..errorStreamController.add('Something went really wrong!'),
    );
  }
}
