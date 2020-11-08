import 'package:flutter/material.dart';

class CustomRaisedButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  CustomRaisedButton({this.text, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      color: Colors.blueAccent,
      child: Text(text),
      textColor: Colors.white,
      onPressed: onPressed,
    );
  }
}
