import 'package:flutter/material.dart';
import 'package:screens/screen_overlay.dart';

class CustomErrorWidget implements ScreenOverlay {
  @override
  Widget build(_, data) => Material(
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
