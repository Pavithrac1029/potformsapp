import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  final double? h;
  final double? w;
  final GestureTapCancelCallback? tap;
  final Icon? icon;

  const CustomIconButton({Key? key, this.h, this.w, this.tap, this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: tap,
      child: Container(
          height: this.h == null ? h * 0.036 : this.h,
          width: this.w == null ? w * 0.1 : this.w,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
              border: Border.all(
                  color: Color.fromRGBO(112, 112, 112, 1), width: 1)),
          child: icon),
    );
  }
}
