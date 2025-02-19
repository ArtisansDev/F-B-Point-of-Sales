import 'package:flutter/material.dart';


class MyInkWellWidget extends StatefulWidget {
  final Widget child;
  final GestureTapCallback? onTap;
  final Color? mColor;

  const MyInkWellWidget({Key? key, required this.child, required this.onTap,this.mColor})
      : super(key: key);

  @override
  MyInkWellWidgetState createState() => MyInkWellWidgetState();
}

class MyInkWellWidgetState extends State<MyInkWellWidget> {
  @override
  Widget build(BuildContext context) {
    var color = widget.mColor??Theme.of(context).primaryColor;
    color = widget.mColor??color.withOpacity(0.1);
    return InkWell(
      hoverColor: color,
      focusColor: color,
      splashColor: color,
      onTap: widget.onTap,
      child: widget.child,
    );
  }
}
