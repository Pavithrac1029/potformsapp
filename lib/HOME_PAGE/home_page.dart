import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:potformsapp/Employee_Details/details.dart';
import 'package:potformsapp/FORMS_NEW/FORM_LIST/formlist.dart';

import '../COMMON_WIDGETS/custom_text.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          height: h,
          width: w,
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    height: h * 0.9,
                    width: w,
                  ),
                  Positioned(
                    top: h * 0.00000001,
                    child: Container(
                        height: h * 0.3,
                        width: w,
                        alignment: Alignment.bottomCenter,
                        decoration: BoxDecoration(
                            //  color: Colors.red,
                            image: DecorationImage(
                                image: AssetImage("assets/dashheader.png"),
                                fit: BoxFit.fill))),
                  ),
                  Positioned(
                    top: h * 0.4,
                    left: w * 0.045,
                    child: Container(
                      height: h * 0.8,
                      width: w * 0.9,
                      child: Column(
                        // crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Card(context, h, w, tap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DetailsPage()));
                          }, txt: "Employee Details"),
                          Card(context, h, w, tap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Formlist()));
                          },
                              // image: "assets/leaveandpermissionapproval.svg",
                              txt: "Forms"),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ));
  }

  InkWell Card(BuildContext context, double h, double w, {tap, image, txt}) {
    return InkWell(
      onTap: tap,
      child: Container(
          height: h * 0.2,
          width: w * 0.8,
          margin: EdgeInsets.all(15),
          decoration: BoxDecoration(
              color: Color.fromRGBO(33, 59, 104, 1),
              border: Border.all(
                  color: Color.fromRGBO(200, 200, 216, 0.73),
                  width: 1.0), // Change the border color here
              borderRadius: BorderRadius.circular(50)),
          child: Column(
            children: [
              SizedBox(
                height: h * 0.07,
                //child: Placeholder(),
              ),
              Container(
                height: h * 0.05,
                width: w,
                alignment: Alignment.center,
                child: CustomText(
                  color: Colors.white,
                  weight: FontWeight.w500,
                  size: 18,
                  text: txt,
                ),
              ),
            ],
          )),
    );
  }
}
