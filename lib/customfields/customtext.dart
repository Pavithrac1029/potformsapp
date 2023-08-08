import 'package:flutter/material.dart';


// ignore: must_be_immutable
class CustomText extends StatefulWidget {
  String? text;
  Color? color;
  FontStyle? fontStyle;
  bool? line;
  double? size;
  FontWeight? weight;
  CustomText(
      {this.text,
      this.color,
      this.fontStyle,
      this.size,
      this.weight,
      this.line});
  @override
  _CustomTextState createState() => _CustomTextState();
}

class _CustomTextState extends State<CustomText> {
  @override
  Widget build(BuildContext context) {
    return Text(
      "${widget.text}",
      style: TextStyle(
          // overflow: TextOverflow.ellipsis,
          decoration: widget.line == null
              ? TextDecoration.none
              : TextDecoration.underline,
          color: widget.color,
          fontFamily: "Poppins",
          fontStyle: widget.fontStyle,
          fontSize: widget.size,
          fontWeight: widget.weight),
    );
  }
}
