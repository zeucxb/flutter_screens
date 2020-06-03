import 'package:flutter/material.dart';
import 'package:screens/custom_overlay.dart';
import 'package:screens/screen_widget.dart';
import 'package:screens/overlay_widget.dart';

class CustomErrorWidget implements CustomOverlay {
  @override
  Widget build(OverlayWidget overlayWidget, data,
          {ScreenWidget screenWidget}) =>
      Material(
        child: Container(
          height: 200,
          color: Colors.red,
          child: Center(
            child: Text(
              data,
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      );
}
