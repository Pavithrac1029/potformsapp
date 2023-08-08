// ignore_for_file: duplicate_import, must_be_immutable, unused_local_variable

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/widgets.dart';

class CustomTextFormField extends StatefulWidget {
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
  TextStyle? prefixTextStyle;
  String? prefixText;
  List<TextInputFormatter>? inputFormatters;
  bool? obscureText;
  BorderRadius? borderRadius;
  int? inputlength;
  Color? borderColor;
  // GestureScaleEndCallback? OnChange;
  ValueChanged? OnChange;
  ValueChanged? onSumbit;
  TextEditingController? textEditingController;
  CustomTextFormField(
      {this.height,
      this.width,
      this.hintText,
      this.borderRadius,
      this.textEditingController,
      this.colors,
      this.suffixicon,
      this.prefixicon,
      this.prefixText,
      this.readonly,
      this.keys,
      this.validator,
      this.prefixTextStyle,
      this.OnChange,
      this.keyboardtype,
      this.hintTextStyle,
      this.borderColor,
      this.onSumbit,
      this.obscureText,
      this.inputlength,
      this.inputFormatters});

  @override
  _CustomTextFormFieldState createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return Container(
      height: widget.height,
      width: widget.width,
      decoration: BoxDecoration(
        borderRadius: widget.borderRadius == null
            ? BorderRadius.circular(10)
            : widget.borderRadius,
        color: widget.colors,
        border: Border.all(
          color: widget.borderColor ?? Colors.transparent,
        ),
      ),
      child: Form(
        key: widget.keys,
        child: TextFormField(
          style: TextStyle(fontSize: 13),
          onChanged: widget.OnChange,
          onFieldSubmitted: widget.onSumbit,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: widget.validator,
          readOnly: widget.readonly == null ? false : true,
          inputFormatters:
              widget.inputFormatters == null ? [] : widget.inputFormatters,
          keyboardType: widget.keyboardtype == true
              ? TextInputType.multiline
              : TextInputType.phone,
          // maxLines: 1,

          obscureText: widget.obscureText == null || widget.obscureText == false
              ? false
              : true,
          controller: widget.textEditingController,
          decoration: InputDecoration(
              contentPadding: EdgeInsets.all(10),
              suffixIcon: widget.suffixicon,
              prefixIcon: widget.prefixicon,
              border: InputBorder.none,
              hintText: widget.hintText,
              hintStyle: widget.hintTextStyle,
              prefixText: widget.prefixText,
              prefixStyle: widget.prefixTextStyle,

              // hintStyle:
              //     TextStyle(color: Colors.grey.withOpacity(0.8))
              ),
        ),
      ),
    );
  }
}
