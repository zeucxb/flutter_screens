import 'dart:async';

import 'package:flutter/material.dart';
import 'package:screens/overlay_event.dart';
import 'package:screens/custom_overlay.dart';
import 'package:screens/screen_widget.dart';

class OverlayWidget extends StatefulWidget {
  final Widget child;

  final CustomOverlay? errorOverlay;
  final Widget? loaderWidget;
  final Map<String, CustomOverlay>? overlayEvents;
  final List<Widget>? fixedOverlayWidgets;

  OverlayWidget(
    this.child, {
    Key? key,
    this.errorOverlay,
    this.loaderWidget,
    this.overlayEvents,
    this.fixedOverlayWidgets,
    this.screenWidget,
  }) : super(key: key);

  // ignore: close_sinks
  final StreamController<OverlayEvent?> eventsStreamController =
      StreamController();

  // ignore: close_sinks
  final StreamController<String?> errorStreamController = StreamController();

  // ignore: close_sinks
  final StreamController<bool> loaderStreamController = StreamController();

  final ScreenWidget? screenWidget;

  @override
  _OverlayWidgetState createState() => _OverlayWidgetState();
}

class _OverlayWidgetState extends State<OverlayWidget> {
  get overlayEvents => widget.overlayEvents;
  get errorOverlay => widget.errorOverlay;
  get loaderWidget => widget.loaderWidget;
  List<Widget> get fixedOverlayWidgets => widget.fixedOverlayWidgets ?? [];

  @override
  dispose() {
    widget.eventsStreamController.close();
    widget.errorStreamController.close();
    widget.loaderStreamController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        widget.child,
      ]
        ..addAll(fixedOverlayWidgets)
        ..addAll([
          _buildOverlayEvent(context),
          _buildErrorDialog(context),
          _buildLoader(context),
        ]),
    );
  }

  Widget _buildOverlayEvent(BuildContext context) =>
      StreamBuilder<OverlayEvent?>(
        stream: widget.eventsStreamController.stream,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          final OverlayEvent? overlayEvent = snapshot.data;

          if (overlayEvent == null || overlayEvents == null) {
            return Container();
          }

          return (overlayEvents[snapshot.data.event] != null)
              ? overlayEvents[snapshot.data.event].build(
                  widget, snapshot.data.data,
                  screenWidget: widget.screenWidget)
              : Container();
        },
      );

  Widget _buildErrorDialog(BuildContext context) => StreamBuilder<String?>(
        stream: widget.errorStreamController.stream,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.data == null || snapshot.data.isEmpty) {
            return Container();
          }

          return (errorOverlay != null)
              ? errorOverlay.build(widget, snapshot.data,
                  screenWidget: widget.screenWidget)
              : Container();
        },
      );

  Widget _buildLoader(BuildContext context) => StreamBuilder<bool>(
        stream: widget.loaderStreamController.stream,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.data == null || !snapshot.data) {
            return Container();
          }

          return loaderWidget ?? Container();
        },
      );
}
