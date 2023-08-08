import 'package:flutter/material.dart';

import 'custom_text.dart';

class Custom_Button extends StatefulWidget {
  double? height;
  double? width;
  String? text;
  double? btText;
  GestureTapCallback? onTap;
  BorderRadius? borderRadius;
  Border? border;
  FontWeight? weight;
  Color? color;
  bool? iconWant;

  Custom_Button(
      {this.width,
      this.height,
      this.onTap,
      this.text,
      this.color,
      this.btText,
      this.weight,
      this.iconWant,
      this.borderRadius,
      this.border});
  @override
  _Custom_ButtonState createState() => _Custom_ButtonState();
}

class _Custom_ButtonState extends State<Custom_Button> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      width: widget.width,
      decoration: BoxDecoration(
          color: widget.color == null
              ? Color(0xff332323).withOpacity(0.9)
              : widget.color,
          borderRadius: widget.borderRadius == null
              ? BorderRadius.circular(30)
              : widget.borderRadius,
          border: widget.border == null
              ? Border.all(color: Color(0xff6AB9BB))
              : widget.border,
          gradient: widget.color == null
              ? LinearGradient(
                  colors: <Color>[Color(0xff29A8A2), Color(0xff4ADFD8)])
              : null),
      child: TextButton(
          onPressed: widget.onTap,
          child: widget.iconWant == true
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomText(
                      text: "${widget.text}",
                      weight: widget.weight,
                      color: Colors.white,
                      size: widget.btText == null ? 18 : widget.btText,
                    ),
                    Icon(
                      Icons.arrow_forward,
                      color: Colors.white,
                    )
                  ],
                )
              : CustomText(
                  text: "${widget.text}",
                  weight: widget.weight,
                  color: Colors.white,
                  size: widget.btText == null ? 18 : widget.btText,
                )),
    );
  }
}
