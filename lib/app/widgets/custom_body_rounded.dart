import 'package:flutter/material.dart';

class CustomBodyRounded extends StatelessWidget {
  final Widget child;

  const CustomBodyRounded({Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10.0),
      decoration: new BoxDecoration(
          color: Colors.white,
          borderRadius: new BorderRadius.all(const Radius.circular(40.0))),
      padding: EdgeInsets.all(10.0),
      child: child,
    );
  }
}
