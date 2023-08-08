import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:potformsapp/HOME_PAGE/home_page.dart';
import 'package:potformsapp/LOGIN_NEW/login_view_controller.dart';
import 'package:provider/provider.dart';

import 'package:select_form_field/select_form_field.dart';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '../BASE URL/api.dart';
import '../COMMON_WIDGETS/custom_button.dart';
import '../COMMON_WIDGETS/custom_text.dart';

import '../customfields/customtextformfields.dart';

class DetailsPage extends StatefulWidget {
  String? empIdSplash;

  DetailsPage({this.empIdSplash});
  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  bool value1 = false;
  bool isloading = false;
  int currentState = 0;
  int backcount = 0;
  String addressremove = "\r\n";
  final l = Logger();
  bool pageBack = true;
  final _formKey1 = GlobalKey<FormState>();
  var employeedetailsgetcode,
      esistatusvalue,
      pfstatusvalue,
      dojpickDate,
      DOJ,
      gendervalue,
      EmpID,
      maritalstatusvalue,
      Employeemastergetdetails,
      Dateofbirth,
      dobpickDate,
      employeedetailsgetmessage,
      employeedetailspostcode,
      employeedetailspostmessage;

  final List<Map<String, dynamic>> _items = [
    {'value': 'A+', 'label': 'A+', 'textStyle': TextStyle(color: Colors.black)},
    {'value': 'A-', 'label': 'A-', 'textStyle': TextStyle(color: Colors.black)},
    {'value': 'B+', 'label': 'B+', 'textStyle': TextStyle(color: Colors.black)},
    {'value': 'B-', 'label': 'B-', 'textStyle': TextStyle(color: Colors.black)},
    {'value': 'O+', 'label': 'O+', 'textStyle': TextStyle(color: Colors.black)},
    {'value': 'O-', 'label': 'O-', 'textStyle': TextStyle(color: Colors.black)},
    {
      'value': 'AB+',
      'label': 'AB+',
      'textStyle': TextStyle(color: Colors.black)
    },
    {
      'value': 'AB-',
      'label': 'AB-',
      'textStyle': TextStyle(color: Colors.black)
    },
  ];
  final List<Map<String, dynamic>> _relationshipstatus = [
    {
      'value': 'Married',
      'label': 'Married',
      'textStyle': TextStyle(color: Colors.black)
    },
    {
      'value': 'Unmarried',
      'label': 'Unmarried',
      'textStyle': TextStyle(color: Colors.black)
    }
  ];

  final List<Map<String, dynamic>> _pfcoveragestatus = [
    {
      'value': 'Yes',
      'label': 'Yes',
      'textStyle': TextStyle(color: Colors.black)
    },
    {'value': 'No', 'label': 'No', 'textStyle': TextStyle(color: Colors.black)}
  ];

  final List<Map<String, dynamic>> _esicoveragestatus = [
    {
      'value': 'Yes',
      'label': 'Yes',
      'textStyle': TextStyle(color: Colors.black)
    },
    {'value': 'No', 'label': 'No', 'textStyle': TextStyle(color: Colors.black)}
  ];
  final List<Map<String, dynamic>> _genderStatus = [
    {'value': 'M', 'label': 'M', 'textStyle': TextStyle(color: Colors.black)},
    {'value': 'F', 'label': 'F', 'textStyle': TextStyle(color: Colors.black)}
  ];

  static TextEditingController empid = TextEditingController();
  static TextEditingController empname = TextEditingController();
  static TextEditingController genderstatus = TextEditingController();
  static TextEditingController father_husband_name = TextEditingController();
  static TextEditingController religion = TextEditingController();
  static TextEditingController dateofbirth = TextEditingController();
  static TextEditingController age = TextEditingController();
  static TextEditingController educationlevel = TextEditingController();
  static TextEditingController maritalstatus = TextEditingController();
  static TextEditingController permenentaddress = TextEditingController();
  static TextEditingController presentaddress = TextEditingController();
  static TextEditingController mobileno = TextEditingController();
  static TextEditingController emergencycontactno = TextEditingController();
  static TextEditingController personalemailid = TextEditingController();
  static TextEditingController category_hsk_sk_ssk_usk =
      TextEditingController();

  static TextEditingController identificationmarks = TextEditingController();
  static TextEditingController tenureofemployement = TextEditingController();
  static TextEditingController pfcoverage = TextEditingController();
  static TextEditingController esicoverage = TextEditingController();
  static TextEditingController uan = TextEditingController();
  static TextEditingController ip = TextEditingController();
  static TextEditingController aadharno = TextEditingController();
  static TextEditingController pan = TextEditingController();
  static TextEditingController bankname = TextEditingController();
  static TextEditingController bankaccountno = TextEditingController();
  static TextEditingController ifsc = TextEditingController();

  List<Step> StepClass() => [
        Step(
          content: Text('please'),
          title: Text(''),
          isActive: currentState >= 0,
        ),
        Step(
            content: Text('please'),
            title: Text(""),
            isActive: currentState >= 1),
        Step(
            content: Text('please'),
            title: Text(""),
            isActive: currentState >= 2),
        Step(
            content: Text('please'),
            title: Text(""),
            isActive: currentState >= 3),
      ];

  @override
  void initState() {
    Provider.of<LoginController>(context, listen: false).getEmployeeid();

    EmpID = Provider.of<LoginController>(context, listen: false).EmployeeID;
    print("eplllllid:${empid.toString()}");

    getdetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () async {
        if (currentState == 3) {
          setState(() {
            currentState = 2;
          });
          return false; // Prevent back navigation
        } else if (currentState == 2) {
          setState(() {
            currentState = 1;
          });
          return false; // Prevent back navigation
        } else if (currentState == 1) {
          setState(() {
            currentState = 0;
          });
          return false; // Prevent back navigation
        } else {
          return true; // Allow back navigation
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body:
            //  Employeemastergetdetails == null
            //     ? Center(child: CustomLoader(h: h, w: w))
            //     : currentState == 0
            //         ?
            currentState == 0
                ? Container(
                    height: h,
                    width: w,
                    child: Column(children: [
                      Container(
                        height: h * 0.25,
                        width: w,
                        //   color: Colors.red,
                        child: Stack(
                          children: [
                            Positioned(
                              top: h * 0.12,
                              left: w * 0.1,
                              child: CustomText(
                                color: Color.fromRGBO(0, 0, 0, 0.38),
                                text: 'Step 1 of 4',
                                size: 15,
                                weight: FontWeight.w500,
                              ),
                            ),
                            Positioned(
                                top: h * 0.15,
                                left: w * 0.1,
                                child: CustomText(
                                  color: Color.fromRGBO(0, 0, 0, 0.84),
                                  text: "Let's get started",
                                  size: 24,
                                  weight: FontWeight.w500,
                                )),
                            Positioned(
                                top: h * 0.195,
                                left: w * 0.1,
                                width: w * 0.7,
                                child: CustomText(
                                  color: Color.fromRGBO(0, 0, 0, 0.87),
                                  text:
                                      "Now you can enter your following details",
                                  size: 16,
                                  weight: FontWeight.normal,
                                )),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: w,
                        height: h * 0.00001,
                      ),
                      Container(
                        height: h * 0.7,
                        width: w * 0.9,
                        //  color: Colors.yellow,
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Stack(
                                children: [
                                  Container(
                                    height: h * 0.9,
                                    width: w * 0.9,
                                  ),
                                  Positioned(
                                    top: h * 0.04,
                                    left: w * 0.01,
                                    child: Container(
                                      padding: EdgeInsets.only(
                                          top: h * 0.00, left: w * 0.04),
                                      height: h * 0.06,
                                      width: w * 0.85,
                                      child: TextFormField(
                                        style: TextStyle(fontSize: 13),
                                        decoration: InputDecoration(
                                            hintText: 'EmployeeID',
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(8.0)),
                                              borderSide: BorderSide(
                                                color: Color.fromRGBO(
                                                    200, 200, 216, 0.73),
                                                width: 1.0,
                                              ),
                                            )),
                                        controller: empid,
                                      ),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    top: h * 0.13,
                                    left: w * 0.05,
                                    child: Container(
                                      padding: EdgeInsets.only(
                                          top: h * 0.000, left: w * 0.00),
                                      height: h * 0.06,
                                      width: w * 0.81,
                                      child: TextFormField(
                                        style: TextStyle(fontSize: 13),
                                        decoration: InputDecoration(
                                            hintText: "Employee Name",
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(8.0)),
                                              borderSide: BorderSide(
                                                color: Color.fromRGBO(
                                                    200, 200, 216, 0.73),
                                                width: 1.0,
                                              ),
                                            )),
                                        controller: empname,
                                      ),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    top: h * 0.22,
                                    left: w * 0.05,
                                    child: Container(
                                      padding: EdgeInsets.only(
                                          top: h * 0.001, left: w * 0.00),
                                      height: h * 0.06,
                                      width: w * 0.81,
                                      child: SelectFormField(
                                          style: TextStyle(
                                              fontSize: 13,
                                              color: Color.fromARGB(
                                                  255, 13, 9, 9)),
                                          controller: genderstatus,
                                          onChanged: (val) {
                                            setState(() {
                                              gendervalue = val;
                                            });
                                          },
                                          items: _genderStatus,
                                          type: SelectFormFieldType.dropdown,
                                          decoration: InputDecoration(
                                              hintText: 'Gender',
                                              suffixIcon: Icon(
                                                Icons.arrow_drop_down,
                                                color: Color(0xff27437a),
                                                size: 30,
                                              ),
                                              border: OutlineInputBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(8.0)),
                                                borderSide: BorderSide(
                                                  color: Color.fromRGBO(
                                                      200, 200, 216, 0.73),
                                                  width: 1.0,
                                                ),
                                              ))),
                                    ),
                                  ),
                                  Positioned(
                                    top: h * 0.31,
                                    left: w * 0.05,
                                    child: Container(
                                      padding: EdgeInsets.only(
                                          top: h * 0.00, left: w * 0.00),
                                      height: h * 0.06,
                                      width: w * 0.81,
                                      child: TextFormField(
                                        style: TextStyle(fontSize: 13),
                                        decoration: InputDecoration(
                                            hintText: 'Father or HusbandName',
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(8.0)),
                                              borderSide: BorderSide(
                                                color: Color.fromRGBO(
                                                    200, 200, 216, 0.73),
                                                width: 1.0,
                                              ),
                                            )),
                                        controller: father_husband_name,
                                      ),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    top: h * 0.40,
                                    left: w * 0.05,
                                    child: Container(
                                      padding: EdgeInsets.only(
                                          top: h * 0.00, left: w * 0.00),
                                      height: h * 0.06,
                                      width: w * 0.81,
                                      child: TextFormField(
                                        style: TextStyle(fontSize: 13),
                                        decoration: InputDecoration(
                                            hintText: 'Religion',
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(8.0)),
                                              borderSide: BorderSide(
                                                color: Color.fromRGBO(
                                                    200, 200, 216, 0.73),
                                                width: 1.0,
                                              ),
                                            )),
                                        controller: religion,
                                      ),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                      top: h * 0.49,
                                      left: w * 0.05,
                                      child: Container(
                                          height: h * 0.06,
                                          width: w * 0.81,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: TextFormField(
                                            style: TextStyle(
                                                fontSize: 13,
                                                color: Color.fromARGB(
                                                    255, 13, 9, 9)),
                                            controller: dateofbirth,
                                            decoration: InputDecoration(
                                                hintText: 'Date of Birth',
                                                contentPadding: EdgeInsets.only(
                                                    top: h * 0.015,
                                                    left: w * 0.04),
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(8.0)),
                                                  borderSide: BorderSide(
                                                    color: Color.fromRGBO(
                                                        200, 200, 216, 0.73),
                                                    width: 1.0,
                                                  ),
                                                ),
                                                suffixIcon: IconButton(
                                                  icon: Icon(
                                                    Icons.calendar_today,
                                                    color: Color(0xff27437a),
                                                    size: 20,
                                                  ),
                                                  onPressed: () {
                                                    dateofbirthDatepicking();
                                                  },
                                                )),
                                          ))),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ]),
                  )
                : currentState == 1
                    ? Container(
                        height: h,
                        width: w,
                        // color: Colors.blue,
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Container(
                                child: Stack(
                                  children: [
                                    Container(
                                      height: h * 0.24,
                                      width: w * 0.9,
                                      // color: Colors.pink,
                                    ),
                                    Positioned(
                                      top: h * 0.12,
                                      left: w * 0.05,
                                      child: CustomText(
                                        color: Color.fromRGBO(0, 0, 0, 0.38),
                                        text: 'Step 2 of 4',
                                        size: 15,
                                        weight: FontWeight.w500,
                                      ),
                                    ),
                                    Positioned(
                                        top: h * 0.15,
                                        left: w * 0.05,
                                        child: CustomText(
                                          color: Color.fromRGBO(0, 0, 0, 0.84),
                                          text: "Let's get started",
                                          size: 24,
                                          weight: FontWeight.w500,
                                        )),
                                    Positioned(
                                        top: h * 0.195,
                                        left: w * 0.05,
                                        width: w * 0.7,
                                        child: CustomText(
                                          color: Color.fromRGBO(0, 0, 0, 0.87),
                                          text:
                                              "Now you can enter your following details",
                                          size: 16,
                                          weight: FontWeight.normal,
                                        )),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: w,
                                height: h * 0.00001,
                              ),
                              Container(
                                height: h * 0.613,
                                width: w * 0.9,
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      Container(
                                        child: Stack(
                                          children: [
                                            Container(
                                              height: h * 0.9,
                                              width: w * 0.9,
                                            ),
                                            Positioned(
                                              top: h * 0.03,
                                              left: w * 0.05,
                                              child: Container(
                                                padding: EdgeInsets.only(
                                                    top: h * 0.00,
                                                    left: w * 0.00),
                                                height: h * 0.06,
                                                width: w * 0.81,
                                                child: TextFormField(
                                                  keyboardType:
                                                      TextInputType.phone,
                                                  inputFormatters: [
                                                    LengthLimitingTextInputFormatter(
                                                        2)
                                                  ],
                                                  style:
                                                      TextStyle(fontSize: 13),
                                                  decoration: InputDecoration(
                                                      hintText: 'Age',
                                                      border:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    8.0)),
                                                        borderSide: BorderSide(
                                                          color: Color.fromRGBO(
                                                              200,
                                                              200,
                                                              216,
                                                              0.73),
                                                          width: 1.0,
                                                        ),
                                                      )),
                                                  controller: age,
                                                ),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                              ),
                                            ),
                                            Positioned(
                                              top: h * 0.11,
                                              left: w * 0.05,
                                              child: Container(
                                                padding: EdgeInsets.only(
                                                    top: h * 0.0002,
                                                    left: w * 0.00),
                                                height: h * 0.06,
                                                width: w * 0.81,
                                                child: SelectFormField(
                                                    style: TextStyle(
                                                        fontSize: 13,
                                                        color: Color.fromARGB(
                                                            255, 13, 9, 9)),
                                                    controller: maritalstatus,
                                                    onChanged: (val) {
                                                      setState(() {
                                                        maritalstatusvalue =
                                                            val;
                                                      });
                                                    },
                                                    items: _relationshipstatus,
                                                    type: SelectFormFieldType
                                                        .dropdown,
                                                    decoration: InputDecoration(
                                                      hintText:
                                                          'Marital Status',
                                                      suffixIcon: Icon(
                                                        Icons.arrow_drop_down,
                                                        color:
                                                            Color(0xff27437a),
                                                        size: 30,
                                                      ),
                                                      border:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    8.0)),
                                                        borderSide: BorderSide(
                                                          color: Color.fromARGB(
                                                              255,
                                                              147,
                                                              147,
                                                              147),
                                                          width: 1.0,
                                                        ),
                                                      ),
                                                    )),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                              ),
                                            ),
                                            Positioned(
                                              top: h * 0.19,
                                              left: w * 0.045,
                                              child: Container(
                                                padding: EdgeInsets.only(
                                                    top: h * 0.001,
                                                    left: w * 0.03),
                                                height: h * 0.15,
                                                width: w * 0.81,
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: Color.fromARGB(
                                                            255, 147, 147, 147),
                                                        width: 1.0),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.0)),
                                                child: TextFormField(
                                                  style:
                                                      TextStyle(fontSize: 13),
                                                  keyboardType:
                                                      TextInputType.multiline,
                                                  maxLines: null,
                                                  controller: permenentaddress,
                                                  decoration: InputDecoration(
                                                      hintText:
                                                          " Permanent Address",
                                                      hintStyle: TextStyle(
                                                          color: Color.fromRGBO(
                                                              31, 31, 31, 0.6)),
                                                      border: InputBorder.none),
                                                ),
                                              ),
                                            ),
                                            Positioned(
                                              top: h * 0.37,
                                              left: w * 0.045,
                                              child: Container(
                                                padding: EdgeInsets.only(
                                                    top: h * 0.001,
                                                    left: w * 0.03),
                                                height: h * 0.15,
                                                width: w * 0.81,
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: Color.fromARGB(
                                                            255, 147, 147, 147),
                                                        width: 1.0),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.0)),
                                                child: TextFormField(
                                                  style:
                                                      TextStyle(fontSize: 13),
                                                  keyboardType:
                                                      TextInputType.multiline,
                                                  maxLines: null,
                                                  controller: presentaddress,
                                                  decoration: InputDecoration(
                                                      hintText:
                                                          " Present Address",
                                                      hintStyle: TextStyle(
                                                          color: Color.fromRGBO(
                                                              31, 31, 31, 0.6)),
                                                      border: InputBorder.none),
                                                ),
                                              ),
                                            ),
                                            Positioned(
                                              top: h * 0.55,
                                              left: w * 0.05,
                                              child: Container(
                                                padding: EdgeInsets.only(
                                                    top: h * 0.00,
                                                    left: w * 0.00),
                                                height: h * 0.06,
                                                width: w * 0.81,
                                                child: TextFormField(
                                                  style: TextStyle(
                                                      fontSize: 13,
                                                      color: Color.fromARGB(
                                                          255, 13, 9, 9)),
                                                  keyboardType:
                                                      TextInputType.phone,
                                                  inputFormatters: [
                                                    LengthLimitingTextInputFormatter(
                                                        10)
                                                  ],
                                                  decoration: InputDecoration(
                                                      hintText: ' Mobile No',
                                                      border:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    8.0)),
                                                        borderSide: BorderSide(
                                                          color: Color.fromARGB(
                                                              255,
                                                              147,
                                                              147,
                                                              147),
                                                          width: 1.0,
                                                        ),
                                                      )),
                                                  controller: mobileno,
                                                ),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                              ),
                                            ),
                                            Positioned(
                                              top: h * 0.64,
                                              left: w * 0.05,
                                              child: Container(
                                                padding: EdgeInsets.only(
                                                    top: h * 0.00,
                                                    left: w * 0.00),
                                                height: h * 0.06,
                                                width: w * 0.81,
                                                child: TextFormField(
                                                  keyboardType:
                                                      TextInputType.phone,
                                                  inputFormatters: [
                                                    LengthLimitingTextInputFormatter(
                                                        10)
                                                  ],
                                                  style: TextStyle(
                                                      fontSize: 13,
                                                      color: Color.fromARGB(
                                                          255, 13, 9, 9)),
                                                  decoration: InputDecoration(
                                                      hintText:
                                                          'Emergency Contact NO',
                                                      border:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    8.0)),
                                                        borderSide: BorderSide(
                                                          color: Color.fromARGB(
                                                              255,
                                                              147,
                                                              147,
                                                              147),
                                                          width: 1.0,
                                                        ),
                                                      )),
                                                  controller:
                                                      emergencycontactno,
                                                ),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    : currentState == 2
                        ? Container(
                            height: h,
                            width: w,
                            //  color: Colors.cyan,
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  Container(
                                    child: Stack(
                                      children: [
                                        Container(
                                          height: h * 0.24,
                                          width: w * 0.9,
                                          // color: Colors.pink,
                                        ),
                                        Positioned(
                                          top: h * 0.12,
                                          left: w * 0.05,
                                          child: CustomText(
                                            color:
                                                Color.fromRGBO(0, 0, 0, 0.38),
                                            text: 'Step 3 of 4',
                                            size: 15,
                                            weight: FontWeight.w500,
                                          ),
                                        ),
                                        Positioned(
                                            top: h * 0.15,
                                            left: w * 0.05,
                                            child: CustomText(
                                              color:
                                                  Color.fromRGBO(0, 0, 0, 0.84),
                                              text: "Let's get started",
                                              size: 24,
                                              weight: FontWeight.w500,
                                            )),
                                        Positioned(
                                            top: h * 0.195,
                                            left: w * 0.05,
                                            width: w * 0.7,
                                            child: CustomText(
                                              color:
                                                  Color.fromRGBO(0, 0, 0, 0.87),
                                              text:
                                                  "Now you can enter your following details",
                                              size: 16,
                                              weight: FontWeight.normal,
                                            )),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width: w,
                                    height: h * 0.00001,
                                  ),
                                  Container(
                                    height: h * 0.613,
                                    width: w * 0.9,
                                    child: SingleChildScrollView(
                                      child: Column(
                                        children: [
                                          Container(
                                            child: Stack(
                                              children: [
                                                Container(
                                                  height: h * 0.9,
                                                  width: w * 0.9,
                                                ),
                                                Positioned(
                                                  top: h * 0.03,
                                                  left: w * 0.05,
                                                  child: Container(
                                                    padding: EdgeInsets.only(
                                                        top: h * 0.00,
                                                        left: w * 0.00),
                                                    height: h * 0.06,
                                                    width: w * 0.81,
                                                    child: TextFormField(
                                                      style: TextStyle(
                                                          fontSize: 13),
                                                      decoration:
                                                          InputDecoration(
                                                              hintText:
                                                                  'Personal EmailID',
                                                              border:
                                                                  OutlineInputBorder(
                                                                borderRadius: BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            8.0)),
                                                                borderSide:
                                                                    BorderSide(
                                                                  color: Color
                                                                      .fromRGBO(
                                                                          200,
                                                                          200,
                                                                          216,
                                                                          0.73),
                                                                  width: 1.0,
                                                                ),
                                                              )),
                                                      controller:
                                                          personalemailid,
                                                    ),
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                    ),
                                                  ),
                                                ),
                                                Positioned(
                                                  top: h * 0.11,
                                                  left: w * 0.05,
                                                  child: Container(
                                                    padding: EdgeInsets.only(
                                                        top: h * 0.00,
                                                        left: w * 0.00),
                                                    height: h * 0.06,
                                                    width: w * 0.81,
                                                    child: TextFormField(
                                                      style: TextStyle(
                                                          fontSize: 13),
                                                      decoration:
                                                          InputDecoration(
                                                              hintText:
                                                                  'Category_HSK_SK_SSK_USK',
                                                              border:
                                                                  OutlineInputBorder(
                                                                borderRadius: BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            8.0)),
                                                                borderSide:
                                                                    BorderSide(
                                                                  color: Color
                                                                      .fromRGBO(
                                                                          200,
                                                                          200,
                                                                          216,
                                                                          0.73),
                                                                  width: 1.0,
                                                                ),
                                                              )),
                                                      controller:
                                                          category_hsk_sk_ssk_usk,
                                                    ),
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                    ),
                                                  ),
                                                ),
                                                Positioned(
                                                  top: h * 0.19,
                                                  left: w * 0.05,
                                                  child: Container(
                                                    padding: EdgeInsets.only(
                                                        top: h * 0.00,
                                                        left: w * 0.00),
                                                    height: h * 0.06,
                                                    width: w * 0.81,
                                                    child: TextFormField(
                                                      style: TextStyle(
                                                          fontSize: 13),
                                                      decoration:
                                                          InputDecoration(
                                                              hintText:
                                                                  'Qualification',
                                                              border:
                                                                  OutlineInputBorder(
                                                                borderRadius: BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            8.0)),
                                                                borderSide:
                                                                    BorderSide(
                                                                  color: Color
                                                                      .fromRGBO(
                                                                          200,
                                                                          200,
                                                                          216,
                                                                          0.73),
                                                                  width: 1.0,
                                                                ),
                                                              )),
                                                      controller:
                                                          educationlevel,
                                                    ),
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                    ),
                                                  ),
                                                ),
                                                Positioned(
                                                  top: h * 0.27,
                                                  left: w * 0.045,
                                                  child: Container(
                                                    padding: EdgeInsets.only(
                                                        top: h * 0.001,
                                                        left: w * 0.03),
                                                    height: h * 0.15,
                                                    width: w * 0.81,
                                                    decoration: BoxDecoration(
                                                        border: Border.all(
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    147,
                                                                    147,
                                                                    147),
                                                            width:
                                                                1.0), // Change the border color here
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                    10.0)),
                                                    child: TextFormField(
                                                      style: TextStyle(
                                                          fontSize: 13),
                                                      keyboardType:
                                                          TextInputType
                                                              .multiline,
                                                      maxLines: null,
                                                      controller:
                                                          identificationmarks,
                                                      decoration: InputDecoration(
                                                          hintText:
                                                              " Identification Marks",
                                                          hintStyle: TextStyle(
                                                              color: Color
                                                                  .fromRGBO(
                                                                      31,
                                                                      31,
                                                                      31,
                                                                      0.6)),
                                                          border:
                                                              InputBorder.none),
                                                    ),
                                                  ),
                                                ),
                                                Positioned(
                                                  top: h * 0.45,
                                                  left: w * 0.045,
                                                  child: Container(
                                                    padding: EdgeInsets.only(
                                                        top: h * 0.001,
                                                        left: w * 0.03),
                                                    height: h * 0.15,
                                                    width: w * 0.81,
                                                    decoration: BoxDecoration(
                                                        border: Border.all(
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    147,
                                                                    147,
                                                                    147),
                                                            width:
                                                                1.0), // Change the border color here
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                    10.0)),
                                                    child: TextFormField(
                                                      style: TextStyle(
                                                          fontSize: 13),
                                                      keyboardType:
                                                          TextInputType
                                                              .multiline,
                                                      maxLines: null,
                                                      controller:
                                                          tenureofemployement,
                                                      decoration: InputDecoration(
                                                          hintText:
                                                              " Tenure of Employement",
                                                          hintStyle: TextStyle(
                                                              color: Color
                                                                  .fromRGBO(
                                                                      31,
                                                                      31,
                                                                      31,
                                                                      0.6)),
                                                          border:
                                                              InputBorder.none),
                                                    ),
                                                  ),
                                                ),
                                                Positioned(
                                                  top: h * 0.63,
                                                  left: w * 0.05,
                                                  child: Container(
                                                    padding: EdgeInsets.only(
                                                        top: h * 0.0002,
                                                        left: w * 0.00),
                                                    height: h * 0.06,
                                                    width: w * 0.81,
                                                    child: SelectFormField(
                                                        style: TextStyle(
                                                            fontSize: 13,
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    13,
                                                                    9,
                                                                    9)),
                                                        controller: pfcoverage,
                                                        onChanged: (val) {
                                                          setState(() {
                                                            pfstatusvalue = val;
                                                          });
                                                        },
                                                        items:
                                                            _pfcoveragestatus,
                                                        type:
                                                            SelectFormFieldType
                                                                .dropdown,
                                                        decoration:
                                                            InputDecoration(
                                                          hintText:
                                                              ' PF Coverage',
                                                          suffixIcon: Icon(
                                                            Icons
                                                                .arrow_drop_down,
                                                            color: Color(
                                                                0xff27437a),
                                                            size: 30,
                                                          ),
                                                          border:
                                                              OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            8.0)),
                                                            borderSide:
                                                                BorderSide(
                                                              color: Color
                                                                  .fromARGB(
                                                                      255,
                                                                      147,
                                                                      147,
                                                                      147),
                                                              width: 1.0,
                                                            ),
                                                          ),
                                                        )),
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      // color: Colors.grey.withOpacity(0.3)
                                                    ),
                                                  ),
                                                ),
                                                Positioned(
                                                  top: h * 0.73,
                                                  left: w * 0.05,
                                                  child: Container(
                                                    padding: EdgeInsets.only(
                                                        top: h * 0.0002,
                                                        left: w * 0.00),
                                                    height: h * 0.06,
                                                    width: w * 0.81,
                                                    child: SelectFormField(
                                                        style: TextStyle(
                                                            fontSize: 13,
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    13,
                                                                    9,
                                                                    9)),
                                                        controller: esicoverage,
                                                        onChanged: (val) {
                                                          setState(() {
                                                            esistatusvalue =
                                                                val;
                                                          });
                                                        },
                                                        items:
                                                            _esicoveragestatus,
                                                        type:
                                                            SelectFormFieldType
                                                                .dropdown,
                                                        decoration:
                                                            InputDecoration(
                                                          hintText:
                                                              ' ESI Coverage',
                                                          suffixIcon: Icon(
                                                            Icons
                                                                .arrow_drop_down,
                                                            color: Color(
                                                                0xff27437a),
                                                            size: 30,
                                                          ),
                                                          border:
                                                              OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            8.0)),
                                                            borderSide:
                                                                BorderSide(
                                                              color: Color
                                                                  .fromARGB(
                                                                      255,
                                                                      147,
                                                                      147,
                                                                      147),
                                                              width: 1.0,
                                                            ),
                                                          ),
                                                        )),
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      // color: Colors.grey.withOpacity(0.3)
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        : Container(
                            height: h,
                            width: w,
                            // color: Colors.pink,
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  Container(
                                    child: Stack(
                                      children: [
                                        Container(
                                          height: h * 0.24,
                                          width: w * 0.9,
                                          // color: Colors.pink,
                                        ),
                                        Positioned(
                                          top: h * 0.12,
                                          left: w * 0.05,
                                          child: CustomText(
                                            color:
                                                Color.fromRGBO(0, 0, 0, 0.38),
                                            text: 'Step 4 of 4',
                                            size: 15,
                                            weight: FontWeight.w500,
                                          ),
                                        ),
                                        Positioned(
                                            top: h * 0.15,
                                            left: w * 0.05,
                                            child: CustomText(
                                              color:
                                                  Color.fromRGBO(0, 0, 0, 0.84),
                                              text: "Let's get started",
                                              size: 24,
                                              weight: FontWeight.w500,
                                            )),
                                        Positioned(
                                            top: h * 0.195,
                                            left: w * 0.05,
                                            width: w * 0.7,
                                            child: CustomText(
                                              color:
                                                  Color.fromRGBO(0, 0, 0, 0.87),
                                              text:
                                                  "Now you can enter your following details",
                                              size: 16,
                                              weight: FontWeight.normal,
                                            )),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width: w,
                                    height: h * 0.00001,
                                  ),
                                  Container(
                                    height: h * 0.613,
                                    width: w * 0.9,
                                    child: SingleChildScrollView(
                                      child: Column(
                                        children: [
                                          Container(
                                            child: Stack(
                                              children: [
                                                Container(
                                                  height: h * 0.9,
                                                  width: w * 0.9,
                                                ),
                                                Positioned(
                                                  top: h * 0.03,
                                                  left: w * 0.05,
                                                  child: Container(
                                                    padding: EdgeInsets.only(
                                                        top: h * 0.00,
                                                        left: w * 0.00),
                                                    height: h * 0.06,
                                                    width: w * 0.81,
                                                    child: TextFormField(
                                                      keyboardType:
                                                          TextInputType.phone,
                                                      inputFormatters: [
                                                        LengthLimitingTextInputFormatter(
                                                            12)
                                                      ],
                                                      style: TextStyle(
                                                          fontSize: 13),
                                                      decoration:
                                                          InputDecoration(
                                                              hintText: 'UAN',
                                                              border:
                                                                  OutlineInputBorder(
                                                                borderRadius: BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            8.0)),
                                                                borderSide:
                                                                    BorderSide(
                                                                  color: Color
                                                                      .fromRGBO(
                                                                          200,
                                                                          200,
                                                                          216,
                                                                          0.73),
                                                                  width: 1.0,
                                                                ),
                                                              )),
                                                      controller: uan,
                                                    ),
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                    ),
                                                  ),
                                                ),
                                                Positioned(
                                                  top: h * 0.11,
                                                  left: w * 0.05,
                                                  child: Container(
                                                    padding: EdgeInsets.only(
                                                        top: h * 0.00,
                                                        left: w * 0.00),
                                                    height: h * 0.06,
                                                    width: w * 0.81,
                                                    child: TextFormField(
                                                      keyboardType:
                                                          TextInputType.phone,
                                                      inputFormatters: [
                                                        LengthLimitingTextInputFormatter(
                                                            17)
                                                      ],
                                                      style: TextStyle(
                                                          fontSize: 13),
                                                      decoration:
                                                          InputDecoration(
                                                              hintText: ' IP',
                                                              border:
                                                                  OutlineInputBorder(
                                                                borderRadius: BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            8.0)),
                                                                borderSide:
                                                                    BorderSide(
                                                                  color: Color
                                                                      .fromRGBO(
                                                                          200,
                                                                          200,
                                                                          216,
                                                                          0.73),
                                                                  width: 1.0,
                                                                ),
                                                              )),
                                                      controller: ip,
                                                    ),
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                    ),
                                                  ),
                                                ),
                                                Positioned(
                                                  top: h * 0.19,
                                                  left: w * 0.05,
                                                  child: Container(
                                                    padding: EdgeInsets.only(
                                                        top: h * 0.00,
                                                        left: w * 0.00),
                                                    height: h * 0.06,
                                                    width: w * 0.81,
                                                    child: TextFormField(
                                                      keyboardType:
                                                          TextInputType.phone,
                                                      inputFormatters: [
                                                        LengthLimitingTextInputFormatter(
                                                            12)
                                                      ],
                                                      style: TextStyle(
                                                          fontSize: 13),
                                                      decoration:
                                                          InputDecoration(
                                                              hintText:
                                                                  ' AadharNumber',
                                                              border:
                                                                  OutlineInputBorder(
                                                                borderRadius: BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            8.0)),
                                                                borderSide:
                                                                    BorderSide(
                                                                  color: Color
                                                                      .fromRGBO(
                                                                          200,
                                                                          200,
                                                                          216,
                                                                          0.73),
                                                                  width: 1.0,
                                                                ),
                                                              )),
                                                      controller: aadharno,
                                                    ),
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                    ),
                                                  ),
                                                ),
                                                Positioned(
                                                  top: h * 0.27,
                                                  left: w * 0.045,
                                                  child: Container(
                                                    padding: EdgeInsets.only(
                                                        top: h * 0.001,
                                                        left: w * 0.03),
                                                    height: h * 0.06,
                                                    width: w * 0.81,
                                                    decoration: BoxDecoration(
                                                        border: Border.all(
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    147,
                                                                    147,
                                                                    147),
                                                            width:
                                                                1.0), // Change the border color here
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                    10.0)),
                                                    child: TextFormField(
                                                      style: TextStyle(
                                                          fontSize: 13),
                                                      keyboardType:
                                                          TextInputType
                                                              .multiline,
                                                      maxLines: null,
                                                      controller: pan,
                                                      decoration: InputDecoration(
                                                          hintText: " PAN",
                                                          hintStyle: TextStyle(
                                                              color: Color
                                                                  .fromRGBO(
                                                                      31,
                                                                      31,
                                                                      31,
                                                                      0.6)),
                                                          border:
                                                              InputBorder.none),
                                                    ),
                                                  ),
                                                ),
                                                Positioned(
                                                  top: h * 0.36,
                                                  left: w * 0.045,
                                                  child: Container(
                                                    padding: EdgeInsets.only(
                                                        top: h * 0.001,
                                                        left: w * 0.03),
                                                    height: h * 0.06,
                                                    width: w * 0.81,
                                                    decoration: BoxDecoration(
                                                        border: Border.all(
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    147,
                                                                    147,
                                                                    147),
                                                            width:
                                                                1.0), // Change the border color here
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                    10.0)),
                                                    child: TextFormField(
                                                      style: TextStyle(
                                                          fontSize: 13),
                                                      keyboardType:
                                                          TextInputType
                                                              .multiline,
                                                      maxLines: null,
                                                      controller: bankname,
                                                      decoration: InputDecoration(
                                                          hintText: " BankName",
                                                          hintStyle: TextStyle(
                                                              color: Color
                                                                  .fromRGBO(
                                                                      31,
                                                                      31,
                                                                      31,
                                                                      0.6)),
                                                          border:
                                                              InputBorder.none),
                                                    ),
                                                  ),
                                                ),
                                                Positioned(
                                                  top: h * 0.45,
                                                  left: w * 0.05,
                                                  child: Container(
                                                    padding: EdgeInsets.only(
                                                        top: h * 0.00,
                                                        left: w * 0.00),
                                                    height: h * 0.06,
                                                    width: w * 0.81,
                                                    child: TextFormField(
                                                        style: TextStyle(
                                                            fontSize: 13,
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    13,
                                                                    9,
                                                                    9)),
                                                        keyboardType:
                                                            TextInputType.phone,
                                                        inputFormatters: [
                                                          LengthLimitingTextInputFormatter(
                                                              10)
                                                        ],
                                                        decoration:
                                                            InputDecoration(
                                                                hintText:
                                                                    ' BankAccountNo',
                                                                border:
                                                                    OutlineInputBorder(
                                                                  borderRadius:
                                                                      BorderRadius.all(
                                                                          Radius.circular(
                                                                              8.0)),
                                                                  borderSide:
                                                                      BorderSide(
                                                                    color: Color
                                                                        .fromARGB(
                                                                            255,
                                                                            147,
                                                                            147,
                                                                            147),
                                                                    width: 1.0,
                                                                  ),
                                                                )),
                                                        controller:
                                                            bankaccountno),
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                    ),
                                                  ),
                                                ),
                                                Positioned(
                                                  top: h * 0.54,
                                                  left: w * 0.05,
                                                  child: Container(
                                                    padding: EdgeInsets.only(
                                                        top: h * 0.00,
                                                        left: w * 0.00),
                                                    height: h * 0.06,
                                                    width: w * 0.81,
                                                    child: TextFormField(
                                                        style: TextStyle(
                                                            fontSize: 13,
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    13,
                                                                    9,
                                                                    9)),
                                                        decoration:
                                                            InputDecoration(
                                                                hintText:
                                                                    'IFSC',
                                                                border:
                                                                    OutlineInputBorder(
                                                                  borderRadius:
                                                                      BorderRadius.all(
                                                                          Radius.circular(
                                                                              8.0)),
                                                                  borderSide:
                                                                      BorderSide(
                                                                    color: Color
                                                                        .fromARGB(
                                                                            255,
                                                                            147,
                                                                            147,
                                                                            147),
                                                                    width: 1.0,
                                                                  ),
                                                                )),
                                                        controller: ifsc),
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

        // Employeemastergetdetails == null
        //     ? Center(child: CustomLoader(h: h, w: w))
        //     :
        bottomSheet: Container(
          height: h * 0.15,
          width: w,
          child: Stack(
            children: [
              Container(
                margin: EdgeInsets.only(left: w * 0.05),
                height: h * 0.15,
                width: w * 0.9,
              ),
              Positioned(
                top: h * 0.03,
                left: w * 0.25,
                child: Custom_Button(
                  onTap: () {
                    if (currentState == 0 ||
                        currentState == 1 ||
                        currentState == 2) {
                      setState(() {
                        currentState += 1;
                      });
                    }

                    apiPost();
                    // if (nameTextController.text.isNotEmpty &&
                    //     fatherNametextController.text.isNotEmpty &&
                    //     currentState == 0) {
                    //   setState(() {
                    //     currentState += 1;
                    //   });
                    // } else if (nameTextController.text.isEmpty &&
                    //     fatherNametextController.text.isEmpty &&
                    //     currentState == 0) {
                    //   final snackBar = SnackBar(
                    //     backgroundColor: Colors.grey,
                    //     content: Text(
                    //       'Please fill all the fields',
                    //       style: TextStyle(
                    //           fontSize: 18,
                    //           fontWeight: FontWeight.bold),
                    //     ),
                    //     duration: Duration(seconds: 3),
                    //     behavior: SnackBarBehavior.fixed,
                    //     shape: RoundedRectangleBorder(
                    //       borderRadius: BorderRadius.circular(5),
                    //     ),
                    //   );
                    //   ScaffoldMessenger.of(context)
                    //       .showSnackBar(snackBar);
                    // } else if (currentState <= 2 &&
                    //     genderController.text.isNotEmpty &&
                    //     dateController.text.isNotEmpty &&
                    //     bloodController.text.isNotEmpty &&
                    //     maritalController.text.isNotEmpty &&
                    //     PermanentAddressController.text.isNotEmpty &&
                    //     PermanentstateController.text.isNotEmpty &&
                    //     PermanentpincodeController.text.isNotEmpty) {
                    //   setState(() {
                    //     setState(() => isloading = true);
                    //   });

                    //  // apiPost();
                    // } else if (currentState <= 2 &&
                    //     genderController.text.isEmpty &&
                    //     dateController.text.isEmpty &&
                    //     bloodController.text.isEmpty &&
                    //     maritalController.text.isEmpty &&
                    //     PermanentAddressController.text.isEmpty &&
                    //     PermanentstateController.text.isEmpty &&
                    //     PermanentpincodeController.text.isEmpty &&
                    //     CurrentAddressController.text.isEmpty &&
                    //     CurrentpincodeController.text.isEmpty &&
                    //     CurrentstateController.text.isEmpty) {
                    //   setState(() {
                    //     setState(() => isloading = false);
                    //   });
                    //   final snackBar = SnackBar(
                    //     backgroundColor: Colors.grey,
                    //     content: Text(
                    //       'Please fill all the fields',
                    //       style: TextStyle(
                    //           fontSize: 18,
                    //           fontWeight: FontWeight.bold),
                    //     ),
                    //     duration: Duration(seconds: 3),
                    //     behavior: SnackBarBehavior.fixed,
                    //     shape: RoundedRectangleBorder(
                    //       borderRadius: BorderRadius.circular(5),
                    //     ),
                    //   );
                    //   ScaffoldMessenger.of(context)
                    //       .showSnackBar(snackBar);
                    // }
                  },
                  iconWant: false,
                  height: h * 0.06,
                  width: w * 0.5,
                  color: Color(0xff213B68),
                  text: "Next",
                  weight: FontWeight.normal,
                  border: Border.all(color: Colors.transparent),
                  btText: 15,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  apiPost() async {
    Logger().e({
      "Emp_ID": empid.text.toString(),
      "Employee_Name": empname.text.toString(),
      "Gender": genderstatus.text.toString(),
      "Education_Level": educationlevel.text.toString(),
      "Category_HSK_SK_SSK_USK": category_hsk_sk_ssk_usk.text.toString(),
      "Date_of_Birth": dobpickDate.toString(),
      "Age": age.text.toString(),
      "Religion": religion.text.toString(),
      "Identification_marks": identificationmarks.text.toString(),
      "Tenure_of_Employment": tenureofemployement.text.toString(),
      "PF_Coverage": pfstatusvalue.toString(),
      "ESI_Coverage": esistatusvalue.toString(),
      "UAN": uan.text.toString(),
      "IP": ip.text.toString(),
      "Aadhaar_Number": aadharno.text.toString(),
      "Date_of_Joining": dojpickDate.toString(),
      "Present_Address_of_the_employee": presentaddress.text.toString(),
      "Permanent_Address_of_the_employee": permenentaddress.text.toString(),
      "Mobile_No": mobileno.text.toString(),
      "Emergency_Contact_No_of_the_employee":
          emergencycontactno.text.toString(),
      "Personal_E_Mail_ID": personalemailid.text.toString(),
      "PAN": pan.text.toString(),
      "Bank_Name": bankname.text.toString(),
      "Bank_Account_Number": bankaccountno.text.toString(),
      "IFSC": ifsc.text.toString(),
      "Fathers_Husbands_Name": father_husband_name.text.toString(),
      "Marital_Status": maritalstatusvalue.toString(),
    });

    var url = Uri.parse(
        "${Provider.of<Baseurl>(context, listen: false).baseurl}${Baseurl().emplyeedetailspost}");
    print("posurl:$url");

    var response = await http.post(url, body: <String, dynamic>{
      "Emp_ID": empid.text.toString(),
      "Employee_Name": empname.text.toString(),
      "Gender": genderstatus.text.toString(),
      "Education_Level": educationlevel.text.toString(),
      "Category_HSK_SK_SSK_USK": category_hsk_sk_ssk_usk.text.toString(),
      "Date_of_Birth": dobpickDate.toString(),
      "Age": age.text.toString(),
      "Religion": religion.text.toString(),
      "Identification_marks": identificationmarks.text.toString(),
      "Tenure_of_Employment": tenureofemployement.text.toString(),
      "PF_Coverage": pfstatusvalue.toString(),
      "ESI_Coverage": esistatusvalue.toString(),
      "UAN": uan.text.toString(),
      "IP": ip.text.toString(),
      "Aadhaar_Number": aadharno.text.toString(),
      "Date_of_Joining": dojpickDate.toString(),
      "Present_Address_of_the_employee": presentaddress.text.toString(),
      "Permanent_Address_of_the_employee": permenentaddress.text.toString(),
      "Mobile_No": mobileno.text.toString(),
      "Emergency_Contact_No_of_the_employee":
          emergencycontactno.text.toString(),
      "Personal_E_Mail_ID": personalemailid.text.toString(),
      "PAN": pan.text.toString(),
      "Bank_Name": bankname.text.toString(),
      "Bank_Account_Number": bankaccountno.text.toString(),
      "IFSC": ifsc.text.toString(),
      "Fathers_Husbands_Name": father_husband_name.text.toString(),
      "Marital_Status": maritalstatusvalue.toString(),
    });

    var decodeDetails = json.decode(response.body);
    print("employeedetails:$decodeDetails");
    employeedetailspostcode = decodeDetails['code'];
    employeedetailspostmessage = decodeDetails['message'];

    if (employeedetailspostcode == 200) {
      setState(() {
        setState(() => isloading = false);
      });
      final snackBar = SnackBar(
        backgroundColor: Color(0xff213B68),
        content:
            Text("${employeedetailspostcode}:${employeedetailspostmessage}"),
        duration: Duration(seconds: 3),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);

      Navigator.push(
          context, MaterialPageRoute(builder: (context) => HomePage()));
    } else if (employeedetailspostcode == 202) {
      final snackBar = SnackBar(
        backgroundColor: Color(0xff213B68),
        content:
            Text("${employeedetailspostcode}:${employeedetailspostmessage}"),
        duration: Duration(seconds: 3),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      final snackBar = SnackBar(
        backgroundColor: Color(0xff213B68),
        content:
            Text("${employeedetailspostcode}:${employeedetailspostmessage}"),
        duration: Duration(seconds: 3),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  gettingEmpDetails() async {
    var url = Uri.parse(
        "${Provider.of<Baseurl>(context, listen: false).baseurl}${Baseurl().employeedetailsget}?Emp_ID=${EmpID}");
    print("employeeedetailsurl:$url");
    var empget = await http.get(url);

    var data3 = json.decode(empget.body);

    print(data3);

    setState(() {
      employeedetailsgetcode = data3['code'];
      employeedetailsgetmessage = data3['message'];
    });

    if (employeedetailsgetcode == 200) {
      setState(() {
        Employeemastergetdetails = data3['data'];
      });

      empid.text = Employeemastergetdetails[0]["Emp_ID"] == ""
          ? ""
          : Employeemastergetdetails[0]["Emp_ID"];

      empname.text = Employeemastergetdetails[0]["Employee_Name"] == ""
          ? ""
          : Employeemastergetdetails[0]["Employee_Name"];

      genderstatus.text = Employeemastergetdetails[0]["Gender"] == ""
          ? ""
          : Employeemastergetdetails[0]["Gender"];

      father_husband_name.text =
          Employeemastergetdetails[0]["Fathers_Husbands_Name"] == ""
              ? ""
              : Employeemastergetdetails[0]["Fathers_Husbands_Name"];

      religion.text = Employeemastergetdetails[0]["Religion"] == ""
          ? ""
          : Employeemastergetdetails[0]["Religion"];

      dateofbirth.text = Employeemastergetdetails[0]["Date_of_Birth"] == "" ||
              Employeemastergetdetails[0]["Date_of_Birth"] == "null"
          ? ""
          : Employeemastergetdetails[0]['Date_of_Birth'];

      age.text = Employeemastergetdetails[0]["Age"] == ""
          ? ""
          : Employeemastergetdetails[0]['Age'];

      educationlevel.text = Employeemastergetdetails[0]["Education_Level"] == ""
          ? ""
          : Employeemastergetdetails[0]["Education_Level"];

      maritalstatus.text = Employeemastergetdetails[0]["Marital_Status"] == ""
          ? ""
          : Employeemastergetdetails[0]["Marital_Status"];

      permenentaddress.text =
          Employeemastergetdetails[0]["Permanent_Address_of_the_employee"] == ""
              ? ""
              : Employeemastergetdetails[0]
                  ["Permanent_Address_of_the_employee"];

      presentaddress.text =
          Employeemastergetdetails[0]['Present_Address_of_the_employee'] == ""
              ? ""
              : Employeemastergetdetails[0]['Present_Address_of_the_employee'];

      mobileno.text = Employeemastergetdetails[0]["Mobile_No"] == ""
          ? ""
          : Employeemastergetdetails[0]["Mobile_No"];

      emergencycontactno.text = Employeemastergetdetails[0]
              ["Emergency_Contact_No_Of_the_employee"] as String? ??
          "";

      // emergencycontactno.text = Employeemastergetdetails[0]
      //             ["Emergency_Contact_No_Of_the_employee"] ==
      //         ""
      //     ? ""
      //     : Employeemastergetdetails[0]["Emergency_Contact_No_Of_the_employee"];

      personalemailid.text =
          Employeemastergetdetails[0]["Personal_E_Mail_ID"] == ""
              ? ""
              : Employeemastergetdetails[0]["Personal_E_Mail_ID"];

      category_hsk_sk_ssk_usk.text =
          Employeemastergetdetails[0]["Category_HSK_SK_SSK_USK"] == ""
              ? ""
              : Employeemastergetdetails[0]["Category_HSK_SK_SSK_USK"];

      identificationmarks.text =
          Employeemastergetdetails[0]["Identification_marks"] == ""
              ? ""
              : Employeemastergetdetails[0]["Identification_marks"];

      tenureofemployement.text =
          Employeemastergetdetails[0]["Tenure_of_Employment"] == ""
              ? ""
              : Employeemastergetdetails[0]["Tenure_of_Employment"];

      pfcoverage.text = Employeemastergetdetails[0]["PF_Coverage"] == ""
          ? ""
          : Employeemastergetdetails[0]["PF_Coverage"];

      esicoverage.text = Employeemastergetdetails[0]["ESI_Coverage"] == ""
          ? ""
          : Employeemastergetdetails[0]["ESI_Coverage"];

      uan.text = Employeemastergetdetails[0]["UAN"] == ""
          ? ""
          : Employeemastergetdetails[0]["UAN"];

      ip.text = Employeemastergetdetails[0]["IP"] == ""
          ? ""
          : Employeemastergetdetails[0]["IP"];

      aadharno.text = Employeemastergetdetails[0]["Aadhaar_Number"] == ""
          ? ""
          : Employeemastergetdetails[0]["Aadhaar_Number"];

      pan.text = Employeemastergetdetails[0]["PAN"] == ""
          ? ""
          : Employeemastergetdetails[0]["PAN"];

      bankname.text = Employeemastergetdetails[0]["current_state"] == ""
          ? ""
          : Employeemastergetdetails[0]["current_state"];

      bankname.text = Employeemastergetdetails[0]["Bank_Name"] == ""
          ? ""
          : Employeemastergetdetails[0]["Bank_Name"];

      ifsc.text = Employeemastergetdetails[0]["IFSC"] == ""
          ? ""
          : Employeemastergetdetails[0]["IFSC"];
    } else {
      final snackBar = SnackBar(
        backgroundColor: Color(0xff213B68),
        content: Text("${employeedetailsgetcode}:${employeedetailsgetmessage}"),
        duration: Duration(seconds: 3),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  getdetails() async {
    await gettingEmpDetails();
  }

  dateofbirthDatepicking() async {
    var myFormat = DateFormat("dd/MM/yyyy");
    var output = DateFormat("yyyy/MM/dd");

    var date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1950),
      lastDate: DateTime(2050),
      builder: (context, child) {
        return Theme(
          data: ThemeData.dark().copyWith(
              colorScheme: const ColorScheme.light(
                  onPrimary: Colors.white, // selected text color
                  onSurface:
                      Color.fromRGBO(33, 59, 104, 1), // default text color
                  primary: Color.fromRGBO(33, 59, 104, 1) // circle color
                  ),
              dialogBackgroundColor: Colors.white,
              textButtonTheme: TextButtonThemeData(
                  style: TextButton.styleFrom(
                      textStyle: const TextStyle(
                          color: Colors.teal,
                          fontWeight: FontWeight.normal,
                          fontSize: 12,
                          fontFamily: 'Quicksand'),
                      primary: Colors.white, // color of button's letters
                      backgroundColor:
                          Color.fromRGBO(33, 59, 104, 1), // Background color
                      shape: RoundedRectangleBorder(
                          side: const BorderSide(
                              color: Colors.transparent,
                              width: 1,
                              style: BorderStyle.solid),
                          borderRadius: BorderRadius.circular(50))))),
          child: child!,
        );
      },
    );

    if (date == null) return null;
    if (date != null) {
      setState(() {
        Dateofbirth = date;
        dobpickDate = output.format(date); // Format for storage
      });
      Logger().e(dobpickDate);

      dateofbirth.text =
          myFormat.format(date); // Format for display "dd/MM/yyyy"
      print(dateofbirth.text.toString());
    }
  }

  // dojDatepicking() async {
  //   var myFormat = DateFormat("dd/MM/yyyy");
  //   var output = DateFormat("yyyy/MM/dd");

  //   var date = await showDatePicker(
  //     context: context,
  //     initialDate: DateTime.now(),
  //     firstDate: DateTime(1950),
  //     lastDate: DateTime(2050),
  //     builder: (context, child) {
  //       return Theme(
  //         data: ThemeData.dark().copyWith(
  //             colorScheme: const ColorScheme.light(
  //                 onPrimary: Colors.white, // selected text color
  //                 onSurface:
  //                     Color.fromRGBO(33, 59, 104, 1), // default text color
  //                 primary: Color.fromRGBO(33, 59, 104, 1) // circle color
  //                 ),
  //             dialogBackgroundColor: Colors.white,
  //             textButtonTheme: TextButtonThemeData(
  //                 style: TextButton.styleFrom(
  //                     textStyle: const TextStyle(
  //                         color: Colors.teal,
  //                         fontWeight: FontWeight.normal,
  //                         fontSize: 12,
  //                         fontFamily: 'Quicksand'),
  //                     primary: Colors.white, // color of button's letters
  //                     backgroundColor:
  //                         Color.fromRGBO(33, 59, 104, 1), // Background color
  //                     shape: RoundedRectangleBorder(
  //                         side: const BorderSide(
  //                             color: Colors.transparent,
  //                             width: 1,
  //                             style: BorderStyle.solid),
  //                         borderRadius: BorderRadius.circular(50))))),
  //         child: child!,
  //       );
  //     },
  //   );

  //   if (date == null) return null;
  //   if (date != null) {
  //     setState(() {
  //       DOJ = date;
  //       dojpickDate = output.format(date); // Format for storage
  //     });
  //     Logger().e(dojpickDate);

  //     doj.text = myFormat.format(date); // Format for display "dd/MM/yyyy"
  //     print(doj.text.toString());
  //   }
  // }
}
