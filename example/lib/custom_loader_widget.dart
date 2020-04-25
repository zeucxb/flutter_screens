import 'package:flutter/material.dart';

class CustomLoaderWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        color: Colors.black.withOpacity(0.6),
        child: Center(
          child: Container(
            height: 20,
            width: 300,
            child: LinearProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
              backgroundColor: Colors.red.withOpacity(0.7),
            ),
          ),
        ),
      ),
    );
  }
}
