import "package:flutter/material.dart";

class CustomFormField extends StatefulWidget {
  double? height;
  double? width;
  Color? color;
  bool? enablheBorder;
  TextEditingController? controller;
  Widget? prefix;
  Widget? suffix;
  String? hintText;

  CustomFormField(
      {this.height,
      this.width,
      this.color,
      this.controller,
      this.suffix,
      this.prefix,
      this.enablheBorder,
      this.hintText});
  @override
  _CustomFormFieldState createState() => _CustomFormFieldState();
}

class _CustomFormFieldState extends State<CustomFormField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      width: widget.width,
      decoration: BoxDecoration(
          border: widget.enablheBorder == true
              ? Border.all(color: Colors.grey.withOpacity(0.2))
              : null,
          color: widget.color,
          borderRadius: BorderRadius.circular(7)),
      child: TextFormField(
        controller: widget.controller,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.all(7),
            prefixIcon: widget.prefix,
            border: InputBorder.none,
            hintText: widget.hintText,
            hintStyle: TextStyle(
                fontFamily: "Poppins", color: Colors.grey, fontSize: 12),
            suffixIcon: widget.suffix),
      ),
    );
  }
}
