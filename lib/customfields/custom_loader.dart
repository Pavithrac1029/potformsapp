import 'package:flutter/material.dart';

class CustomLoader extends StatelessWidget {
  const CustomLoader({
    Key? key,
    required this.h,
    required this.w,
  }) : super(key: key);

  final double h;
  final double w;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: this.h,
      width: this.w,
      alignment: Alignment.center,
      // decoration: BoxDecoration(
      //     image: DecorationImage(
      //         image: AssetImage("assets/bg.png"), fit: BoxFit.fill)),
      child: Image.asset("assets/formapploading.gif"),
    );
  }
}
