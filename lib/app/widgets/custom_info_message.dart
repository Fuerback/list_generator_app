import 'package:flutter/material.dart';

class CustomInfoMessage extends StatelessWidget {
  final String message;

  const CustomInfoMessage({Key key, this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            message,
            style: TextStyle(color: Colors.grey[400]),
          ),
          Icon(
            Icons.list,
            color: Colors.grey[400],
          )
        ],
      ),
    );
  }
}
