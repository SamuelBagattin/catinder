import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'FFButtonOptions.dart';

class FFButtonWidget extends StatelessWidget {
  final Key key;
  final Future<Null> Function() onPressed;
  final String text;
  final Icon icon;
  final FFButtonOptions options;

  FFButtonWidget(
      {this.key, this.onPressed, this.text, this.icon, this.options});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: this.onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          icon,
          Text(
            this.text,
            style: options.textStyle,
          ),
        ],
      ),
      key: this.key,
      color: options.color,
      elevation: options.elevation.toDouble(),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
              Radius.circular(options.borderRadius.toDouble()))),
    );
  }
}
