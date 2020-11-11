import 'package:flutter/material.dart';

class CustomAppBar extends StatefulWidget with PreferredSizeWidget {
  final String title;
  final Icon actionIcon;
  final VoidCallback onPressed;

  const CustomAppBar({Key key, this.title, this.actionIcon, this.onPressed})
      : super(key: key);

  @override
  _CustomAppBarState createState() => _CustomAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(50.0);
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Center(child: Text(widget.title)),
      actions: widget.actionIcon != null
          ? [IconButton(icon: widget.actionIcon, onPressed: widget.onPressed)]
          : [],
      elevation: 0.0,
    );
  }
}
