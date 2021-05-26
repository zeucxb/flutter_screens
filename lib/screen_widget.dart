import 'dart:async';

import 'package:flutter/material.dart';
import 'package:screens/default/error_overlay.dart';
import 'package:screens/overlay_widget.dart';
import 'package:screens/safe_area_config.dart';
import 'package:screens/overlay_event.dart';
import 'package:screens/custom_overlay.dart';

class ScreenWidget extends StatefulWidget {
  // ignore: close_sinks
  final StreamController<OverlayEvent?> eventsStreamController =
      StreamController();
  // ignore: close_sinks
  final StreamController<String?> errorStreamController = StreamController();
  // ignore: close_sinks
  final StreamController<bool> loaderStreamController = StreamController();

  final Widget? child;
  final List<Widget>? children;
  final bool showAppBar;
  final String appBarText;
  final PreferredSizeWidget? appBarWidget;
  final bool isAccent;
  final bool isStatic;
  final EdgeInsetsGeometry? padding;
  final Widget? bottomNavigationBar;
  final Brightness? statusBarBrightness;
  final Color? backgroundColor;
  final GlobalKey<ScaffoldState>? scaffoldKey;
  final bool isDefaultScaffold;
  final SafeAreaConfig safeAreaConfig;
  final Widget? floatingActionButton;
  final FloatingActionButtonAnimator? floatingActionButtonAnimator;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final CustomOverlay? errorOverlay;
  final Widget? loaderWidget;
  final Map<String, CustomOverlay>? overlayEvents;
  final List<Widget>? fixedOverlayWidgets;
  final Function? dispose;

  ScreenWidget({
    Key? key,
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
    this.statusBarBrightness,
    this.backgroundColor,
    this.safeAreaConfig = const SafeAreaConfig(),
    this.floatingActionButton,
    this.floatingActionButtonAnimator,
    this.floatingActionButtonLocation,
    this.errorOverlay,
    this.loaderWidget,
    this.overlayEvents,
    this.fixedOverlayWidgets,
    this.dispose,
  })  : assert(child != null || children != null),
        super(key: key);

  @override
  _ScreenWidgetState createState() => _ScreenWidgetState();
}

class _ScreenWidgetState extends State<ScreenWidget> {
  double? _height;

  get overlayEvents => widget.overlayEvents;
  get errorOverlay => widget.errorOverlay;
  get loaderWidget => widget.loaderWidget;
  List<Widget> get fixedOverlayWidgets => widget.fixedOverlayWidgets ?? [];

  _setHeight(double height) {
    if (_height == null) {
      _height = height;
    }
  }

  @override
  void dispose() {
    if (widget.dispose != null) {
      widget.dispose!();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final _appBar = widget.appBarWidget ??
        AppBar(
          brightness: widget.statusBarBrightness,
          backgroundColor: widget.isAccent
              ? theme.accentColor
              : theme.scaffoldBackgroundColor,
          centerTitle: true,
          title: Text(
            widget.appBarText,
          ),
          elevation: widget.showAppBar ? theme.appBarTheme.elevation : 0,
        );

    return OverlayWidget(
      Scaffold(
        key: widget.scaffoldKey,
        backgroundColor: widget.backgroundColor ??
            (widget.isAccent ? theme.accentColor : null),
        appBar: widget.showAppBar
            ? _appBar
            : PreferredSize(
                preferredSize: Size.fromHeight(0),
                child: _appBar,
              ),
        floatingActionButton: widget.floatingActionButton,
        floatingActionButtonAnimator: widget.floatingActionButtonAnimator,
        floatingActionButtonLocation: widget.floatingActionButtonLocation,
        body: SafeArea(
          top: widget.safeAreaConfig.top,
          left: widget.safeAreaConfig.left,
          right: widget.safeAreaConfig.right,
          bottom: widget.safeAreaConfig.bottom,
          child: widget.isDefaultScaffold
              ? Padding(
                  padding: widget.padding ?? EdgeInsets.zero,
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
                  : ListView(children: widget.children!),
        ),
        bottomNavigationBar: widget.bottomNavigationBar,
      ),
      overlayEvents: overlayEvents,
      errorOverlay: errorOverlay ?? DefaultCustomErrorWidget(),
      loaderWidget: loaderWidget ??
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
          ),
      fixedOverlayWidgets: fixedOverlayWidgets,
      screenWidget: widget,
    )
      ..eventsStreamController.addStream(widget.eventsStreamController.stream)
      ..loaderStreamController.addStream(widget.loaderStreamController.stream)
      ..errorStreamController.addStream(widget.errorStreamController.stream);
  }
}
