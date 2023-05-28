import 'package:flutter/material.dart';

class WhiteSection extends StatefulWidget {
  dynamic padding;
  double? radius;
  Widget? child;
  Color? color;
  WhiteSection(
      {super.key, @required this.child, this.radius, this.padding, this.color});
  @override
  _WhiteSectionState createState() => _WhiteSectionState();
}

class _WhiteSectionState extends State<WhiteSection> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: widget.padding ?? const EdgeInsets.all(25),
      decoration: BoxDecoration(
        color: widget.color == null ? Colors.white : widget.color!,
        borderRadius: BorderRadius.circular(widget.radius ?? 0.0),
      ),
      child: widget.child,
    );
  }
}
