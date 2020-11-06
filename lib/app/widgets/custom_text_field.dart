import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController textEditingController;
  final String text;

  const CustomTextField({Key key, this.textEditingController, this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: textEditingController,
      decoration: InputDecoration(
          labelText: text, labelStyle: TextStyle(color: Colors.blueAccent)),
    );
  }
}
