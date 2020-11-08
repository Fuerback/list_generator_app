import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController textEditingController;
  final String hintText;
  final bool autoFocus;

  const CustomTextField(
      {Key key, this.textEditingController, this.hintText, this.autoFocus})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      autofocus: this.autoFocus,
      controller: textEditingController,
      decoration: InputDecoration(
          hintText: hintText, labelStyle: TextStyle(color: Colors.blueAccent)),
    );
  }
}
