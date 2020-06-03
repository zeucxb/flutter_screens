import 'package:flutter/material.dart';
import 'package:screens/custom_overlay.dart';
import 'package:screens/screen_widget.dart';

class CustomOverlayWidget implements CustomOverlay {
  @override
  Widget build(_, data, {ScreenWidget screenWidget}) => Container(
        alignment: Alignment.bottomCenter,
        child: Container(
          padding: EdgeInsets.all(50),
          color: Colors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(data),
              Icon(data),
              Icon(data),
              Icon(data),
            ],
          ),
        ),
      );
}
