library screens;

import 'package:flutter/material.dart';
import 'package:screens/safe_area_config.dart';
import 'package:screens/screen_overlay.dart';
import 'package:screens/screen_widget.dart';

export 'package:screens/screen_event.dart';

class Screens {
  final List<Widget> fixedOverlayWidgets;
  final Map<String, ScreenOverlay> screenEvents;
  final ScreenOverlay errorOverlay;
  final Widget loaderWidget;

  Screens({
    this.fixedOverlayWidgets,
    this.screenEvents,
    this.errorOverlay,
    this.loaderWidget,
  });

  ScreenWidget widget({
    GlobalKey<ScaffoldState> scaffoldKey,
    bool showAppBar = false,
    bool isAccent = false,
    bool isStatic = false,
    bool isDefaultScaffold = false,
    String appBarText = '',
    AppBar appBarWidget,
    EdgeInsets padding,
    Widget child,
    List<Widget> children,
    BottomNavigationBar bottomNavigationBar,
    Brightness brightness,
    Color backgroundColor,
    SafeAreaConfig safeAreaConfig = const SafeAreaConfig(),
  }) =>
      ScreenWidget(
        scaffoldKey: scaffoldKey,
        showAppBar: showAppBar,
        isAccent: isAccent,
        isStatic: isStatic,
        isDefaultScaffold: isDefaultScaffold,
        appBarText: appBarText,
        appBarWidget: appBarWidget,
        padding: padding,
        child: child,
        children: children,
        bottomNavigationBar: bottomNavigationBar,
        brightness: brightness,
        backgroundColor: backgroundColor,
        safeAreaConfig: safeAreaConfig,
        errorOverlay: this.errorOverlay,
        loaderWidget: this.loaderWidget,
        screenEvents: this.screenEvents,
        fixedOverlayWidgets: this.fixedOverlayWidgets,
      );
}
