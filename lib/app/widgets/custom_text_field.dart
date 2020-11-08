import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController textEditingController;
  final String hintText;

  const CustomTextField({Key key, this.textEditingController, this.hintText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      autofocus: true,
      controller: textEditingController,
      decoration: InputDecoration(
          hintText: hintText, labelStyle: TextStyle(color: Colors.blueAccent)),
    );
  }
}
