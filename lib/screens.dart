library screens;

import 'package:flutter/material.dart';
import 'package:screens/overlay_widget.dart';
import 'package:screens/safe_area_config.dart';
import 'package:screens/custom_overlay.dart';
import 'package:screens/screen_widget.dart';

export 'package:screens/overlay_event.dart';

class Screens {
  final List<Widget> fixedOverlayWidgets = [];
  final Map<String, CustomOverlay> overlayEvents = {};
  final CustomOverlay errorOverlay;
  final Widget loaderWidget;

  Screens({
    fixedOverlayWidgets,
    overlayEvents,
    this.errorOverlay,
    this.loaderWidget,
  }) {
    if (fixedOverlayWidgets != null)
      this.fixedOverlayWidgets.addAll(fixedOverlayWidgets);
    if (overlayEvents != null) this.overlayEvents.addAll(overlayEvents);
  }

  ScreenWidget widget({
    GlobalKey<ScaffoldState> scaffoldKey,
    bool showAppBar = false,
    bool isAccent = false,
    bool isStatic = false,
    bool isDefaultScaffold = false,
    String appBarText = '',
    Widget appBarWidget,
    EdgeInsets padding,
    Widget child,
    List<Widget> children,
    Widget bottomNavigationBar,
    Brightness statusBarBrightness,
    Color backgroundColor,
    SafeAreaConfig safeAreaConfig = const SafeAreaConfig(),
    Widget floatingActionButton,
    FloatingActionButtonAnimator floatingActionButtonAnimator,
    FloatingActionButtonLocation floatingActionButtonLocation,
    List<Widget> fixedOverlayWidgets = const [],
    Map<String, CustomOverlay> overlayEvents = const {},
    CustomOverlay errorOverlay,
    Widget loaderWidget,
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
        statusBarBrightness: statusBarBrightness,
        backgroundColor: backgroundColor,
        safeAreaConfig: safeAreaConfig,
        floatingActionButton: floatingActionButton,
        floatingActionButtonAnimator: floatingActionButtonAnimator,
        floatingActionButtonLocation: floatingActionButtonLocation,
        errorOverlay: errorOverlay ?? this.errorOverlay,
        loaderWidget: loaderWidget ?? this.loaderWidget,
        overlayEvents: this.overlayEvents..addAll(overlayEvents),
        fixedOverlayWidgets: this.fixedOverlayWidgets
          ..addAll(fixedOverlayWidgets),
      );

  OverlayWidget overlay(
    Widget widget, {
    List<Widget> fixedOverlayWidgets = const [],
    Map<String, CustomOverlay> overlayEvents = const {},
    CustomOverlay errorOverlay,
    Widget loaderWidget,
  }) =>
      OverlayWidget(
        widget,
        errorOverlay: errorOverlay ?? this.errorOverlay,
        loaderWidget: loaderWidget ?? this.loaderWidget,
        overlayEvents: this.overlayEvents..addAll(overlayEvents),
        fixedOverlayWidgets: this.fixedOverlayWidgets
          ..addAll(fixedOverlayWidgets),
      );
}
