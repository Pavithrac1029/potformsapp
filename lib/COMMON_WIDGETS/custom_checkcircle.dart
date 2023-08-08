import 'package:flutter/material.dart';

class CheckCircle extends StatefulWidget {
  double? height;
  double? width;
  GestureTapCallback? onTap;
  bool? changer;

  CheckCircle({this.height, this.width, this.onTap, this.changer});

  @override
  _CheckCircleState createState() => _CheckCircleState();
}

class _CheckCircleState extends State<CheckCircle> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: Container(
        height: widget.height,
        width: widget.width,
        decoration: BoxDecoration(
            color: widget.changer == false ? null : Color.fromRGBO(33, 59, 104, 1),
            border: Border.all(
                color: widget.changer == false
                    ? Color(0xff6D6B6B)
                    : Color.fromRGBO(33, 59, 104, 1)),
            borderRadius: BorderRadius.circular(40)),
        child: widget.changer == false
            ? null
            : Icon(
                Icons.check,
                color: Colors.white,
                size: 10,
              ),
      ),
    );
  }
}