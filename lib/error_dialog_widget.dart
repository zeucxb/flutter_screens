import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';

class ErrorDialog extends StatelessWidget {
  final String errorMessage;
  final bool previousStatusBarWhiteForeground;
  final Function closeFunction;

  ErrorDialog({
    Key key,
    @required this.errorMessage,
    this.previousStatusBarWhiteForeground,
    @required this.closeFunction,
  })  : assert(errorMessage != null && errorMessage.isNotEmpty),
        assert(closeFunction != null),
        super(key: key);

  _closeDialog() {
    if (previousStatusBarWhiteForeground != null) {
      FlutterStatusbarcolor.setStatusBarWhiteForeground(false);
    }

    closeFunction();
  }

  @override
  Widget build(BuildContext context) {
    if (errorMessage == null) return Container();

    FlutterStatusbarcolor.setStatusBarWhiteForeground(true);

    return Container(
      color: Colors.red,
      child: SafeArea(
        child: Material(
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            color: Colors.red,
            width: double.infinity,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Icon(Icons.warning),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      errorMessage,
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.close),
                  onPressed: _closeDialog,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
