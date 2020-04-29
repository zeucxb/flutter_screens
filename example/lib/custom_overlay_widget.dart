import 'package:flutter/material.dart';
import 'package:screens/screen_overlay.dart';

class CustomOverlayWidget implements ScreenOverlay {
  @override
  Widget build(data) => Container(
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
