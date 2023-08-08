import 'package:flutter/material.dart';

import '../customfields/customtext.dart';


class CustomAppBar extends StatefulWidget {
  String? appTitle1;
  String? appTitle2;
  Color? appBarColor;
  bool? gradientWant;
  bool? bottomWant;
  bool? autoLead;

  Widget? customLeading;

  CustomAppBar(
      {this.appTitle1,
      this.appTitle2,
      this.appBarColor,
      this.customLeading,
      this.bottomWant,
      this.autoLead,
      this.gradientWant});
  @override
  _CustomAppBarState createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return AppBar(

      leading: widget.customLeading == null? null : widget.customLeading ,
      automaticallyImplyLeading:widget.autoLead == false ? false: true,
     bottom: widget.bottomWant == true?PreferredSize(
       preferredSize: Size.fromHeight(h),
       child: Container(
        height: h * 0.05,
          width: w,
         child: Center(
           child: CustomText(
                    text: "${widget.appTitle1}",
                    size: 22,
                    color: Color(0xff153D73),
                    weight: FontWeight.bold,
                  ),
         ),
       ),
     ): null,
      elevation: 0,
    
      centerTitle: true,
      // actions: [
      //   Padding(
      //     padding: EdgeInsets.all(10),
      //     child: Custom_Notification(
      //       notificationCount: "3",
      //     ),
      //   )
      // ],
      flexibleSpace: widget.gradientWant == true
          ? Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: <Color>[Color(0xffF8FAFA), Color(0xffD8E4E3)])),
            )
          : null,
      backgroundColor:
          widget.appBarColor == null ? Color(0xFFF2F7F6) : widget.appBarColor,
      title:widget.bottomWant == true? null: Container(
        height: h * 0.05,
        width: w * 0.5,
       
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomText(
              text: "${widget.appTitle1}",
              size: 20,
              color: Color(0xff153D73),
              weight: FontWeight.bold,
            ),
            Padding(
              padding: EdgeInsets.only(left: w * 0.01),
              child: CustomText(
                  text: "${widget.appTitle2}",
                  color: Color(0xff153D73),
                  weight: FontWeight.bold,
                  size: 20),
            )
          ],
        ),
      ),
      //
    );
  }
}
