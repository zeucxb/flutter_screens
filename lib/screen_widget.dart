library screens;

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:screens/error_dialog_widget.dart';

class ScreenWidget extends StatefulWidget {
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

  ScreenWidget({
    Key key,
    this.showAppBar = false,
    this.isAccent = false,
    this.isStatic = false,
    this.appBarText = '',
    this.appBarWidget,
    this.padding,
    this.child,
    this.children,
    this.bottomNavigationBar,
    this.brightness,
    this.backgroundColor,
  })  : assert(child != null || children != null),
        super(key: key);

  @override
  _ScreenWidgetState createState() => _ScreenWidgetState();
}

class _ScreenWidgetState extends State<ScreenWidget> {
  double _height;

  @override
  dispose() {
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
            title: widget.appBarWidget ??
                Text(
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
          backgroundColor: widget.backgroundColor ??
              (widget.isAccent ? theme.accentColor : null),
          appBar: _appBar,
          body: SafeArea(
            child: (widget.child != null)
                ? LayoutBuilder(
                    builder:
                        (BuildContext context, BoxConstraints constraints) {
                      _setHeight(constraints
                          .constrainHeight(MediaQuery.of(context).size.height));
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
        _buildErrorDialog(context),
        _buildLoader(context),
      ],
    );
  }

  Widget _buildErrorDialog(BuildContext context) => StreamBuilder<String>(
        stream: widget.errorStreamController.stream,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.data == null || snapshot.data.isEmpty) {
            return Container();
          }

          return ErrorDialog(
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

          return Container(
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
