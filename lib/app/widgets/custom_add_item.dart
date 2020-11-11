import 'package:flutter/material.dart';

import 'custom_text_field.dart';

class CustomAddItem extends StatelessWidget {
  final VoidCallback onPressed;
  final TextEditingController itemController;

  const CustomAddItem({Key key, this.onPressed, this.itemController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(17.0, 8.0, 7.0, 8.0),
      child: Row(
        children: <Widget>[
          Expanded(
              child: CustomTextField(
            autoFocus: false,
            hintText: "Novo item",
            textEditingController: itemController,
          )),
          FloatingActionButton.extended(
            onPressed: onPressed,
            icon: const Icon(Icons.add),
            label: Text("Item"),
          )
        ],
      ),
    );
  }
}
