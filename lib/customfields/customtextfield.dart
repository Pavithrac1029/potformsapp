// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// ignore: must_be_immutable
class CustomTextField extends StatefulWidget {
  double? height;
  double? width;
  String? hintText;
  Color? colors;
  GlobalKey? keys;
  FormFieldValidator? validator;
  bool? readonly;
  Widget? suffixicon;
  Widget? prefixicon;
  bool? keyboardtype;
  TextStyle? hintTextStyle;
  List<TextInputFormatter>? inputFormatters;
  bool? obscureText;
  int? inputlength;
  Color? underlineColor; // Added property for underline color

  ValueChanged? OnChange;
  ValueChanged? onSumbit;
  TextEditingController? textEditingController;

  CustomTextField({
    this.height,
    this.width,
    this.hintText,
    this.colors,
    this.keys,
    this.validator,
    this.readonly,
    this.suffixicon,
    this.prefixicon,
    this.keyboardtype,
    this.hintTextStyle,
    this.inputFormatters,
    this.obscureText,
    this.inputlength,
    this.underlineColor, // Added property for underline color
    this.OnChange,
    this.onSumbit,
    this.textEditingController,
  });

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;

    return Container(
      height: widget.height,
      width: widget.width,
      child: TextFormField(
        style: TextStyle(fontSize: 13),
        onChanged: widget.OnChange,
        onFieldSubmitted: widget.onSumbit,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: widget.validator,
        readOnly: widget.readonly == null ? false : true,
        inputFormatters: widget.inputFormatters ?? [],
        keyboardType: widget.keyboardtype == true
            ? TextInputType.multiline
            : TextInputType.phone,
        obscureText:
            widget.obscureText == null || widget.obscureText == false
                ? false
                : true,
        controller: widget.textEditingController,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(10),
          suffixIcon: widget.suffixicon,
          prefixIcon: widget.prefixicon,
          hintText: widget.hintText,
          hintStyle: widget.hintTextStyle,
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: widget.underlineColor ?? Colors.grey, // Use underlineColor property
              width: 1.0,
            ),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: widget.underlineColor ?? Colors.grey, // Use underlineColor property
              width: 1.0,
            ),
          ),
        ),
      ),
    );
  }
}
