import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:potformsapp/HOME_PAGE/home_page.dart';
import 'package:potformsapp/customfields/custom_loader.dart';


import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:logger/logger.dart';
import 'package:open_file/open_file.dart';

import 'package:flutter_svg/flutter_svg.dart';

import 'package:path_provider/path_provider.dart';

import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../COMMON_WIDGETS/custom_iconbutton.dart';
import '../../COMMON_WIDGETS/custom_text.dart';
import '../FORM_1/Form1.dart';
import '../FORM_11/Form11.dart';
import '../FORM_2/Form2.dart';
import '../FORM_F/Form F.dart';

class Formlist extends StatefulWidget {
  const Formlist({Key? key}) : super(key: key);

  @override
  State<Formlist> createState() => _FormlistState();
}

class _FormlistState extends State<Formlist> {
  var getFormData;
  var id;
  List<int> formsPercentage = [];
  var apidatadetails1;
  var apidatadetails11;
  var fromDetails;
  var FormName;
  bool pdf = false;

  List FormDeatils = [
    {
      "name": "Form 11",
      "content": "Previous Employment status",
    },
    {
      "name": "Form 1",
      "content": "Declaration Form",
    },
    {
      "name": "Form 2",
      "content": "Nomination & Declaration by the member",
    },
    {
      "name": "Form F",
      "content": "Nomination by the employee",
    },
  ];
  @override
  initState() {
    getId();
    // TODO: implement initState
    super.initState();
  }

  getId() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.getInt("employeeId");
    setState(() {
      id = preferences.getInt("employeeId");
    });
  }

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomePage()));
        return Future.value(true);
      },
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: FormDeatils == null
              ? Center(child: CustomLoader(h: h, w: w))
              : Container(
                  height: h,
                  width: w,
                  child: Column(children: [
                    Container(
                      height: h * 0.18,
                      width: w * 0.9,
                      // color: Colors.red,
                      child: Stack(
                        children: [
                          Positioned(
                            top: h * 0.15,
                            left: w * 0.05,
                            child: CustomText(
                              text: "Forms",
                              color: Color.fromRGBO(0, 0, 0, 0.84),
                              size: 24,
                              weight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: h * 0.8,
                      width: w * 0.9,
                      // color: Colors.red,
                      child: ListView.builder(
                        itemCount: FormDeatils.length,
                        itemExtent: h * 0.2,
                        itemBuilder: (BuildContext context, int index) {
                          return Stack(
                            children: [
                              Container(
                                height: h * 0.25,
                                width: w * 0.9,
                                //  color: Colors.red,
                              ),
                              Positioned(
                                top: h * 0.02,
                                left: w * 0.05,
                                child: Container(
                                  height: h * 0.18,
                                  width: w * 0.8,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Color.fromRGBO(200, 200, 216,
                                            0.73), // Replace 'Colors.blue' with your desired border color
                                        width:
                                            1.0, // Set the desired border width
                                      ),
                                      borderRadius: BorderRadius.circular(10)),
                                ),
                              ),
                              Positioned(
                                  top: h * 0.05,
                                  left: w * 0.1,
                                  child: CustomText(
                                    text: "${FormDeatils[index]['name']}",
                                    size: 17,
                                    weight: FontWeight.w500,
                                    color: Color.fromRGBO(33, 59, 104, 1),
                                  )),
                              Positioned(
                                  top: h * 0.085,
                                  left: w * 0.1,
                                  child: Container(
                                    height: h * 0.05,
                                    width: w * 0.5,
                                    child: CustomText(
                                      color: Color.fromRGBO(31, 31, 31, 0.6),
                                      size: 12,
                                      weight: FontWeight.normal,
                                      text: "${FormDeatils[index]['content']}",
                                    ),
                                  )),
                              Positioned(
                                  top: h * 0.05,
                                  left: w * 0.73,
                                  child: InkWell(
                                      onTap: () {
                                        setState(() {
                                          FormName = FormDeatils[index]['name'];
                                        });
                                        print(FormName);
                                        print(
                                            "------------------------formlistindex-----------");
                                        if (FormName.toString() == "Form 11") {
                                          print("formnaemeee${FormName}");
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      FormPage()));
                                        }

                                        if (FormName.toString() == "Form 1") {
                                          Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      Formdeclaration()));
                                        }

                                        if (FormName.toString() == "Form 2") {
                                          Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      NominationForm()));
                                        }

                                        if (FormName.toString() == "Form F") {
                                          Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      FormF()));
                                        }
                                      },
                                      child: CustomIconButton(
                                        h: h * 0.05,
                                        w: w * 0.07,
                                        icon: Icon(
                                          Icons.arrow_forward_ios,
                                          color:
                                              Color.fromRGBO(112, 112, 112, 1),
                                          size: 14,
                                        ),
                                      ))),
                            ],
                          );
                        },
                      ),
                    )
                  ]))),
    );
  }
}
