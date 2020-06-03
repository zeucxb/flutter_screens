import 'package:flutter/material.dart';
import 'package:screens/overlay_widget.dart';
import 'package:screens/screen_widget.dart';

abstract class CustomOverlay {
  Widget build(OverlayWidget overlayWidget, dynamic data,
      {ScreenWidget screenWidget});
}
