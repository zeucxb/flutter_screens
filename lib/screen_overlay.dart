import 'package:flutter/material.dart';
import 'package:screens/screen_widget.dart';

abstract class ScreenOverlay {
  Widget build(ScreenWidget screenWidget, dynamic data);
}
