import 'dart:async';

import 'package:flutter/material.dart';
import 'package:screens/error_dialog_widget.dart';
import 'package:screens/screen_event.dart';
import 'package:screens/screen_overlay.dart';

class ScreenWidget extends StatefulWidget {
  // ignore: close_sinks
  final StreamController<ScreenEvent> eventsStreamController =
      StreamController();
  // ignore: close_sinks
  final StreamController<String> errorStreamController = StreamController();
  // ignore: close_sinks
  final StreamController<bool> loaderStreamController = StreamController();

  final Widget child;
  final List<Widget> children;
  final bool showAppBar;
  final String appBarText;
  final Widget appBarWidget;
  final bool isAccent;
  final bool isStatic;
  final EdgeInsetsGeometry padding;
  final BottomNavigationBar bottomNavigationBar;
  final Brightness brightness;
  final Color backgroundColor;
  final GlobalKey<ScaffoldState> scaffoldKey;
  final bool isDefaultScaffold;
  final ScreenOverlay errorOverlay;
  final Widget loaderWidget;
  final Map<String, ScreenOverlay> screenEvents;
  final List<Widget> fixedOverlayWidgets;

  ScreenWidget({
    Key key,
    this.scaffoldKey,
    this.showAppBar = false,
    this.isAccent = false,
    this.isStatic = false,
    this.isDefaultScaffold = false,
    this.appBarText = '',
    this.appBarWidget,
    this.padding,
    this.child,
    this.children,
    this.bottomNavigationBar,
    this.brightness,
    this.backgroundColor,
    this.errorOverlay,
    this.loaderWidget,
    this.screenEvents,
    this.fixedOverlayWidgets,
  })  : assert(child != null || children != null),
        super(key: key);

  @override
  _ScreenWidgetState createState() => _ScreenWidgetState();
}

class _ScreenWidgetState extends State<ScreenWidget> {
  double _height;

  get screenEvents => widget.screenEvents;
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

  _setHeight(double height) {
    if (_height == null) {
      _height = height;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final _appBar = widget.showAppBar
        ? AppBar(
            brightness: widget.brightness,
            backgroundColor: widget.isAccent
                ? theme.accentColor
                : theme.scaffoldBackgroundColor,
            centerTitle: true,
            title: Text(
              widget.appBarText,
            ),
          )
        : PreferredSize(
            preferredSize: Size.zero,
            child: AppBar(
              elevation: 0,
              brightness: widget.brightness,
              backgroundColor: Colors.transparent,
            ),
          );

    return Stack(
      children: <Widget>[
        Scaffold(
          key: widget.scaffoldKey,
          backgroundColor: widget.backgroundColor ??
              (widget.isAccent ? theme.accentColor : null),
          appBar: widget.appBarWidget ?? _appBar,
          body: SafeArea(
            child: widget.isDefaultScaffold
                ? Padding(
                    padding: widget.padding,
                    child: widget.child,
                  )
                : (widget.child != null)
                    ? LayoutBuilder(
                        builder:
                            (BuildContext context, BoxConstraints constraints) {
                          _setHeight(constraints.constrainHeight(
                              MediaQuery.of(context).size.height));
                          return SingleChildScrollView(
                            child: widget.isStatic
                                ? Container(
                                    padding: widget.padding,
                                    height: _height,
                                    child: widget.child,
                                  )
                                : widget.child,
                          );
                        },
                      )
                    : ListView(children: widget.children),
          ),
          bottomNavigationBar: widget.bottomNavigationBar,
        ),
        _buildScreenEvent(context),
        _buildErrorDialog(context),
        _buildLoader(context),
      ]..addAll(fixedOverlayWidgets),
    );
  }

  Widget _buildScreenEvent(BuildContext context) => StreamBuilder<ScreenEvent>(
        stream: widget.eventsStreamController.stream,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          final ScreenEvent screenEvent = snapshot.data;
          if (screenEvent == null) {
            return Container();
          }

          return (screenEvents[snapshot.data.event] != null)
              ? screenEvents[snapshot.data.event].build(snapshot.data.data)
              : Container();
        },
      );

  Widget _buildErrorDialog(BuildContext context) => StreamBuilder<String>(
        stream: widget.errorStreamController.stream,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.data == null || snapshot.data.isEmpty) {
            return Container();
          }

          return (errorOverlay != null)
              ? errorOverlay.build(snapshot.data)
              : ErrorDialog(
                  errorMessage: snapshot.data,
                  previousStatusBarWhiteForeground: !widget.isAccent,
                  closeFunction: () {
                    widget.errorStreamController.add(null);
                  },
                );
        },
      );

  Widget _buildLoader(BuildContext context) => StreamBuilder<bool>(
        stream: widget.loaderStreamController.stream,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.data == null || !snapshot.data) {
            return Container();
          }

          final theme = Theme.of(context);

          return loaderWidget ??
              Container(
                color: Colors.black.withOpacity(0.5),
                height: double.infinity,
                width: double.infinity,
                child: Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                      !widget.isAccent
                          ? theme.accentColor
                          : theme.scaffoldBackgroundColor,
                    ),
                  ),
                ),
              );
        },
      );
}
