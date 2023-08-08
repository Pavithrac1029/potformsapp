import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:intl/intl.dart';
import 'package:logger/logger.dart';

import 'package:http/http.dart' as http;
import 'package:potformsapp/BASE%20URL/api.dart';

import 'package:potformsapp/LOGIN_NEW/login_view_controller.dart';

import 'package:provider/provider.dart';
import 'dart:convert';
import 'package:select_form_field/select_form_field.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../COMMON_WIDGETS/button.dart';
import '../../COMMON_WIDGETS/custom_button.dart';

import '../../COMMON_WIDGETS/custom_iconbutton.dart';
import '../../COMMON_WIDGETS/custom_text.dart';
import '../../customfields/customtextformfields.dart';

import '../FORM_LIST/formlist.dart';

class NominationForm extends StatefulWidget {
  List? nomA;

  @override
  State<NominationForm> createState() => _NominationFormState();
}

class _NominationFormState extends State<NominationForm> {
  static TextEditingController nameofnominee = TextEditingController();
  static TextEditingController nomineeaddress = TextEditingController();
  static TextEditingController nomineerelationship = TextEditingController();
  static TextEditingController nomineedob = TextEditingController();
  static TextEditingController nomineetotalamountshare =
      TextEditingController();
  static TextEditingController nomineeminor = TextEditingController();
  static TextEditingController nomineefamilymember = TextEditingController();
  static TextEditingController nomineeage = TextEditingController();
  static TextEditingController partbnomineerelationship =
      TextEditingController();

  static TextEditingController partcnomineename = TextEditingController();
  static TextEditingController partcnomineedob = TextEditingController();
  static TextEditingController partcrelationshipmember =
      TextEditingController();

  bool isloading = false;

  var EmpID,
      employeedetailsgetcode,
      employeedetailsgetmessage,
      Employeemastergetdetails,
      Dateofbirth,
      dobpickDate,
      employeedetailspostcode,
      employeedetailspostmessage,
      partcDateofbirth,
      partcdobpickDate;

  @override
  initState() {
    Provider.of<LoginController>(context, listen: false).getEmployeeid();

    EmpID = Provider.of<LoginController>(context, listen: false).EmployeeID;
    print("eplllllid:${EmpID.toString()}");

    getdetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Formlist()));
        return Future.value(true);
      },
      child: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body:
              // form2detailsgetcode == null
              //     ? Center(
              //         child: CustomLoader(h: h, w: w),
              //       )
              //     :
              Container(
            height: h,
            width: w,
            child: Column(
              children: [
                Container(
                  height: h * 0.2,
                  width: w * 0.9,
                  //  color: Colors.red,
                  child: Stack(
                    children: [
                      Positioned(
                        top: h * 0.1,
                        left: w * 0.05,
                        child: CustomText(
                          text: "Form 2",
                          color: Color.fromRGBO(0, 0, 0, 0.84),
                          size: 24,
                          weight: FontWeight.w500,
                        ),
                      ),
                      Positioned(
                        top: h * 0.17,
                        left: w * 0.05,
                        child: CustomText(
                          text: "PART -A (EPF)",
                          color: Color.fromRGBO(0, 0, 0, 1),
                          size: 18,
                          weight: FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: h * 0.8,
                  width: w * 0.9,
                  //color: Colors.orange,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            Container(
                              height: h * 0.99,
                              width: w * 0.9,
                              //color: Colors.red,
                            ),
                            Positioned(
                                top: h * 0.05,
                                left: w * 0.045,
                                child: CustomTextFormField(
                                  height: h * 0.06,
                                  width: w * 0.8,
                                  hintText: "  Name of the Nominee",
                                  hintTextStyle: TextStyle(
                                      color: Color.fromRGBO(31, 31, 31, 0.6),
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal),
                                  borderColor:
                                      Color.fromRGBO(200, 200, 216, 0.73),
                                  textEditingController: nameofnominee,
                                  keyboardtype: true,
                                )),
                            Positioned(
                                top: h * 0.15,
                                left: w * 0.045,
                                child: Container(
                                    padding: EdgeInsets.only(
                                        top: h * 0.001, left: w * 0.01),
                                    height: h * 0.2,
                                    width: w * 0.81,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Color.fromRGBO(
                                                200, 200, 216, 0.73),
                                            width:
                                                1.0), // Change the border color here
                                        borderRadius:
                                            BorderRadius.circular(10.0)),
                                    child: TextFormField(
                                      style: TextStyle(fontSize: 13),
                                      keyboardType: TextInputType.multiline,
                                      maxLines: null,
                                      controller: nomineeaddress,
                                      decoration: InputDecoration(
                                          hintText: "     Address",
                                          hintStyle: TextStyle(
                                              color: Color.fromRGBO(
                                                  31, 31, 31, 0.6)),
                                          border: InputBorder.none),
                                    ))),
                            Positioned(
                                top: h * 0.39,
                                left: w * 0.045,
                                child: CustomTextFormField(
                                  height: h * 0.06,
                                  width: w * 0.8,
                                  hintText:
                                      "  Nominee's relationship with the member",
                                  hintTextStyle: TextStyle(
                                      color: Color.fromRGBO(31, 31, 31, 0.6),
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal),
                                  borderColor:
                                      Color.fromRGBO(200, 200, 216, 0.73),
                                  textEditingController: nomineerelationship,
                                  keyboardtype: true,
                                )),
                            Positioned(
                                top: h * 0.49,
                                left: w * 0.045,
                                child: CustomTextFormField(
                                  height: h * 0.06,
                                  width: w * 0.8,
                                  hintText: "  Date Of Birth",
                                  hintTextStyle: TextStyle(
                                      color: Color.fromRGBO(31, 31, 31, 0.6),
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal),
                                  borderColor:
                                      Color.fromRGBO(200, 200, 216, 0.73),
                                  textEditingController: nomineedob,
                                  readonly: true,
                                  suffixicon: InkWell(
                                    onTap: () {
                                      dateofbirthDatepicking();
                                    },
                                    child: Icon(
                                      Icons.calendar_today_outlined,
                                      color: Color(0xff27437a),
                                      size: 20,
                                    ),
                                  ),
                                )),
                            Positioned(
                                top: h * 0.58,
                                left: w * 0.045,
                                child: CustomText(
                                  text:
                                      "Total amount or share of accumulations in\nprovident Funds to be paid to each nominee",
                                  color: Color.fromRGBO(31, 31, 31, 0.88),
                                  weight: FontWeight.normal,
                                  size: 14,
                                )),
                            Positioned(
                                top: h * 0.67,
                                left: w * 0.045,
                                child: CustomTextFormField(
                                  height: h * 0.06,
                                  width: w * 0.8,
                                  hintTextStyle: TextStyle(
                                      color: Color.fromRGBO(31, 31, 31, 0.6),
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal),
                                  borderColor:
                                      Color.fromRGBO(200, 200, 216, 0.73),
                                  inputFormatters: [
                                    LengthLimitingTextInputFormatter(3)
                                  ],
                                  textEditingController:
                                      nomineetotalamountshare,
                                )),
                            Positioned(
                                top: h * 0.77,
                                left: w * 0.045,
                                child: CustomText(
                                  text:
                                      "If the nominee is minor name and address of\nthe guradian who may receive the amount\nduring the minority of the nominee",
                                  color: Color.fromRGBO(31, 31, 31, 0.88),
                                  weight: FontWeight.normal,
                                  size: 14,
                                )),
                            Positioned(
                                top: h * 0.87,
                                left: w * 0.045,
                                child: CustomTextFormField(
                                  height: h * 0.06,
                                  width: w * 0.8,
                                  hintTextStyle: TextStyle(
                                      color: Color.fromRGBO(31, 31, 31, 0.6),
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal),
                                  borderColor:
                                      Color.fromRGBO(200, 200, 216, 0.73),
                                  textEditingController: nomineeminor,
                                  keyboardtype: true,
                                )),
                          ],
                        ),
                        Container(
                          height: h * 0.55,
                          width: w * 0.9,
                          //  color: Colors.pink,
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                Stack(
                                  children: [
                                    Container(
                                      height: h * 0.55,
                                      width: w * 0.9,
                                    ),
                                    Positioned(
                                        top: h * 0.01,
                                        left: w * 0.045,
                                        child: CustomText(
                                          text: "PART -B (EPS)",
                                          color: Color.fromRGBO(0, 0, 0, 1),
                                          weight: FontWeight.normal,
                                          size: 18,
                                        )),
                                    Positioned(
                                        top: h * 0.1,
                                        left: w * 0.045,
                                        child: Container(
                                            padding: EdgeInsets.only(
                                                top: h * 0.001, left: w * 0.01),
                                            height: h * 0.2,
                                            width: w * 0.81,
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Color.fromRGBO(
                                                        200, 200, 216, 0.73),
                                                    width:
                                                        1.0), // Change the border color here
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        10.0)),
                                            child: TextFormField(
                                              style: TextStyle(fontSize: 13),
                                              keyboardType:
                                                  TextInputType.multiline,
                                              maxLines: null,
                                              controller: nomineefamilymember,
                                              decoration: InputDecoration(
                                                  hintText:
                                                      "   Name & Address of the Family Member",
                                                  hintStyle: TextStyle(
                                                      color: Color.fromRGBO(
                                                          31, 31, 31, 0.6)),
                                                  border: InputBorder.none),
                                            ))),
                                    Positioned(
                                        top: h * 0.35,
                                        left: w * 0.045,
                                        child: CustomTextFormField(
                                          height: h * 0.06,
                                          width: w * 0.8,
                                          hintText: "  Age",
                                          hintTextStyle: TextStyle(
                                              color: Color.fromRGBO(
                                                  31, 31, 31, 0.6),
                                              fontSize: 14,
                                              fontWeight: FontWeight.normal),
                                          borderColor: Color.fromRGBO(
                                              200, 200, 216, 0.73),
                                          inputFormatters: [
                                            LengthLimitingTextInputFormatter(2)
                                          ],
                                          textEditingController: nomineeage,
                                          keyboardtype: false,
                                        )),
                                    Positioned(
                                        top: h * 0.45,
                                        left: w * 0.045,
                                        child: CustomTextFormField(
                                          height: h * 0.06,
                                          width: w * 0.8,
                                          hintText:
                                              "  Relationship with the member",
                                          hintTextStyle: TextStyle(
                                              color: Color.fromRGBO(
                                                  31, 31, 31, 0.6),
                                              fontSize: 14,
                                              fontWeight: FontWeight.normal),
                                          borderColor: Color.fromRGBO(
                                              200, 200, 216, 0.73),
                                          textEditingController:
                                              partbnomineerelationship,
                                          keyboardtype: true,
                                        )),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                        Container(
                          height: h * 0.8,
                          width: w * 0.9,
                          //   color: Colors.blue,
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                Stack(
                                  children: [
                                    Container(
                                      height: h * 0.8,
                                      width: w * 0.9,
                                    ),
                                    Positioned(
                                        top: h * 0.01,
                                        left: w * 0.045,
                                        child: CustomText(
                                          text: "PART -C",
                                          color: Color.fromRGBO(0, 0, 0, 1),
                                          weight: FontWeight.normal,
                                          size: 18,
                                        )),
                                    Positioned(
                                        top: h * 0.08,
                                        left: w * 0.045,
                                        child: CustomText(
                                          text:
                                              "If the nominee is minor name and address of\nthe guradian who may receive the amount\nduring the minority of the nominee",
                                          color:
                                              Color.fromRGBO(31, 31, 31, 0.88),
                                          weight: FontWeight.normal,
                                          size: 14,
                                        )),
                                    Positioned(
                                        top: h * 0.2,
                                        left: w * 0.045,
                                        child: Container(
                                            padding: EdgeInsets.only(
                                                top: h * 0.001, left: w * 0.01),
                                            height: h * 0.2,
                                            width: w * 0.81,
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Color.fromRGBO(
                                                        200, 200, 216, 0.73),
                                                    width:
                                                        1.0), // Change the border color here
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        10.0)),
                                            child: TextFormField(
                                              style: TextStyle(fontSize: 13),
                                              keyboardType:
                                                  TextInputType.multiline,
                                              maxLines: null,
                                              controller: partcnomineename,
                                              decoration: InputDecoration(
                                                  hintText:
                                                      "  Name & Address of the nominee",
                                                  hintStyle: TextStyle(
                                                      color: Color.fromRGBO(
                                                          31, 31, 31, 0.6)),
                                                  border: InputBorder.none),
                                            ))),
                                    Positioned(
                                        top: h * 0.44,
                                        left: w * 0.045,
                                        child: CustomTextFormField(
                                          height: h * 0.06,
                                          width: w * 0.8,
                                          hintText: "  Date of Birth",
                                          hintTextStyle: TextStyle(
                                              color: Color.fromRGBO(
                                                  31, 31, 31, 0.6),
                                              fontSize: 14,
                                              fontWeight: FontWeight.normal),
                                          borderColor: Color.fromRGBO(
                                              200, 200, 216, 0.73),
                                          textEditingController:
                                              partcnomineedob,
                                          readonly: true,
                                          suffixicon: InkWell(
                                            onTap: () {
                                              partcdateofbirthDatepicking();
                                            },
                                            child: Icon(
                                              Icons.calendar_today_outlined,
                                              size: 20,
                                              color: Color(0xff213B68),
                                            ),
                                          ),
                                        )),
                                    Positioned(
                                        top: h * 0.54,
                                        left: w * 0.045,
                                        child: CustomTextFormField(
                                          height: h * 0.06,
                                          width: w * 0.8,
                                          hintText:
                                              "  Nominee's relationship with the member",
                                          hintTextStyle: TextStyle(
                                              color: Color.fromRGBO(
                                                  31, 31, 31, 0.6),
                                              fontSize: 14,
                                              fontWeight: FontWeight.normal),
                                          borderColor: Color.fromRGBO(
                                              200, 200, 216, 0.73),
                                          textEditingController:
                                              partcrelationshipmember,
                                          keyboardtype: true,
                                        )),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                        Container(
                          height: h * 0.1,
                          width: w * 0.9,
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          bottomSheet:
              // form2detailsgetcode == null
              //     ? Center(child: CustomLoader(h: h, w: w))
              //     :
              Container(
            height: h * 0.12,
            width: w,
            color: Colors.white,
            child: Container(
              height: h * 0.12,
              width: w,
              child: Stack(
                children: [
                  Container(
                    height: h * 0.12,
                    width: w * 0.9,
                    margin: EdgeInsets.only(left: w * 0.05),
                  ),
                  Positioned(
                    top: h * 0.01,
                    left: w * 0.1,
                    child: Custom_Button(
                      onTap: () {
                        form2apiPost();
                      },
                      iconWant: false,
                      height: h * 0.06,
                      width: w * 0.81,
                      color: Color(0xff213B68),
                      text: "Submit",
                      weight: FontWeight.normal,
                      border: Border.all(color: Colors.transparent),
                      btText: 15,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
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

      nomineedob.text =
          myFormat.format(date); // Format for display "dd/MM/yyyy"
      print(nomineedob.text.toString());
    }
  }

  partcdateofbirthDatepicking() async {
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
        partcDateofbirth = date;
        partcdobpickDate = output.format(date); // Format for storage
      });
      Logger().e(dobpickDate);

      partcnomineedob.text =
          myFormat.format(date); // Format for display "dd/MM/yyyy"
      print(partcnomineedob.text.toString());
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

      nameofnominee.text =
          Employeemastergetdetails[0]["Name_of_the_nominees "] == ""
              ? ""
              : Employeemastergetdetails[0]["Name_of_the_nominees "];

      nomineeaddress.text =
          Employeemastergetdetails[0]["Address_of_the_nominee"] == ""
              ? ""
              : Employeemastergetdetails[0]["Address_of_the_nominee"];

      nomineerelationship.text = Employeemastergetdetails[0]
                  ["Nominees_relationship_with_the_member"] ==
              ""
          ? ""
          : Employeemastergetdetails[0]
              ["Nominees_relationship_with_the_member"];

      nomineedob.text = Employeemastergetdetails[0]["Date_of_birth_"] == ""
          ? ""
          : Employeemastergetdetails[0]["Date_of_birth_"];

      nomineetotalamountshare.text = Employeemastergetdetails[0]
                  ["Total_amount_or_share_of_accumulations_nominee"] ==
              ""
          ? ""
          : Employeemastergetdetails[0]
              ["Total_amount_or_share_of_accumulations_nominee"];

      nomineeminor.text = Employeemastergetdetails[0]
                      ["If_the_nominee_is_minor"] ==
                  "" ||
              Employeemastergetdetails[0]["If_the_nominee_is_minor"] == "null"
          ? ""
          : Employeemastergetdetails[0]['If_the_nominee_is_minor '];

      nomineefamilymember.text = Employeemastergetdetails[0]
                  ["Name_and_Address_of_the_Family_Member"] ==
              ""
          ? ""
          : Employeemastergetdetails[0]
              ['Name_and_Address_of_the_Family_Member'];

      nomineeage.text =
          Employeemastergetdetails[0]["Age_of_the_family_member"] == ""
              ? ""
              : Employeemastergetdetails[0]["Age_of_the_family_member"];

      partbnomineerelationship.text =
          Employeemastergetdetails[0]["Relationship_with_the_member"] == ""
              ? ""
              : Employeemastergetdetails[0]["Relationship_with_the_member"];

      partcnomineename.text =
          Employeemastergetdetails[0]["Name_and_Address_of_the_nominee"] == ""
              ? ""
              : Employeemastergetdetails[0]["Name_and_Address_of_the_nominee"];

      partcDateofbirth.text =
          Employeemastergetdetails[0]["Date_of_Birth__"] == ""
              ? ""
              : Employeemastergetdetails[0]["Date_of_Birth__"];

      partcrelationshipmember.text =
          Employeemastergetdetails[0]["Relationship_with_member"] == ""
              ? ""
              : Employeemastergetdetails[0]["Relationship_with_member"];
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

  form2apiPost() async {
    Logger().e({
      "Emp_ID": EmpID.toString(),
      "Name_of_the_nominees": nameofnominee.text.toString(),
      "Address_of_the_nominee": nomineeaddress.text.toString(),
      "Nominees_relationship_with_the_member":
          nomineerelationship.text.toString(),
      "Date_of_birth_": nomineedob.text.toString(),
      "Total_amount_or_share_of_accumulations_nominee":
          nomineetotalamountshare.text.toString(),
      "If_the_nominee_is_minor": nomineeminor.text.toString(),
      "Name_and_Address_of_the_Family_Member":
          nomineefamilymember.text.toString(),
      "Age_of_the_family_member ": nomineeage.text.toString(),
      "Relationship_with_the_member": partbnomineerelationship.text.toString(),
      "Name_and_Address_of_the_nominee": partcnomineename.text.toString(),
      "Date_of_Birth__ ": partcnomineedob.text.toString(),
      "Relationship_with_member": partcrelationshipmember.text.toString(),
    });

    var url = Uri.parse(
        "${Provider.of<Baseurl>(context, listen: false).baseurl}${Baseurl().emplyeedetailspost}");
    print("posurl:$url");

    var response = await http.post(url, body: <String, dynamic>{
      "Emp_ID": EmpID.toString(),
      "Name_of_the_nominees": nameofnominee.text.toString(),
      "Address_of_the_nominee": nomineeaddress.text.toString(),
      "Nominees_relationship_with_the_member":
          nomineerelationship.text.toString(),
      "Date_of_birth_": nomineedob.text.toString(),
      "Total_amount_or_share_of_accumulations_nominee":
          nomineetotalamountshare.text.toString(),
      "If_the_nominee_is_minor": nomineeminor.text.toString(),
      "Name_and_Address_of_the_Family_Member":
          nomineefamilymember.text.toString(),
      "Age_of_the_family_member ": nomineeage.text.toString(),
      "Relationship_with_the_member": partbnomineerelationship.text.toString(),
      "Name_and_Address_of_the_nominee": partcnomineename.text.toString(),
      "Date_of_Birth__ ": partcnomineedob.text.toString(),
      "Relationship_with_member": partcrelationshipmember.text.toString(),
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
          context, MaterialPageRoute(builder: (context) => Formlist()));
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
}
