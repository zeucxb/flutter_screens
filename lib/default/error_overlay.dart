import 'package:flutter/material.dart';
import 'package:screens/custom_overlay.dart';
import 'package:screens/error_dialog_widget.dart';
import 'package:screens/screen_widget.dart';
import 'package:screens/overlay_widget.dart';

class DefaultCustomErrorWidget implements CustomOverlay {
  @override
  Widget build(OverlayWidget overlayWidget, data,
          {ScreenWidget? screenWidget}) =>
      Material(
        child: ErrorDialog(
          errorMessage: data,
          previousStatusBarWhiteForeground: !screenWidget!.isAccent,
          closeFunction: () {
            overlayWidget.errorStreamController.add(null);
          },
        ),
      );
}
