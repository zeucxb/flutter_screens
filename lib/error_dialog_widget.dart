import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {
    if (errorMessage == null) return Container();

    return Container(
      alignment: Alignment.bottomCenter,
      child: Container(
        color: Colors.red,
        child: Material(
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            color: Colors.red,
            width: double.infinity,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  alignment: Alignment.center,
                  height: 120,
                  child: Row(
                    children: [
                      Icon(
                        Icons.warning,
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        errorMessage,
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: closeFunction,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.25),
                      borderRadius: BorderRadius.circular(100),
                    ),
                    padding: EdgeInsets.all(2),
                    child: Icon(
                      Icons.close,
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
