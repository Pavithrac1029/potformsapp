import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class CustomText extends StatefulWidget {
  String? text;
  double? size;
  Color? color;
  double? letterSpace;
  FontWeight? weight;
  bool? decor;
  bool? line;

  CustomText(
      {this.text,
      this.size,
      this.color,
      this.weight,
      this.letterSpace,
      this.decor,
      this.line});

  @override
  State<CustomText> createState() => _CustomTextState();
}

class _CustomTextState extends State<CustomText> {
  @override
  Widget build(BuildContext context) {
    return Text(
      "${widget.text}",

      style: GoogleFonts.roboto(
            decoration: widget.line == null
            ? TextDecoration.none
            : TextDecoration.underline,
         fontSize: widget.size,
      
        //fontFamily: "Poppins",
        fontWeight: widget.weight,
        color: widget.color == null
            ? Color(0xff434343)
            : widget.color == 1
                ? Colors.white
                : widget.color,
      ));
      
  
  }
}
