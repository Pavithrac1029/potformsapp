import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:potformsapp/BASE%20URL/api.dart';
import 'package:potformsapp/LOGIN_NEW/login_view_controller.dart';

import 'package:provider/provider.dart';

import 'package:select_form_field/select_form_field.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../COMMON_WIDGETS/button.dart';
import '../../COMMON_WIDGETS/custom_button.dart';

import '../../COMMON_WIDGETS/custom_text.dart';
import '../../customfields/custom_loader.dart';
import '../../customfields/customtextformfields.dart';

import '../FORM_LIST/formlist.dart';

import 'formfsignaturepad.dart';


class FormF extends StatefulWidget {
  FormF({this.bytes, this.bytes1});
  final bytes;
  final bytes1;
  @override
  State<FormF> createState() => _FormFState();
}

class _FormFState extends State<FormF> {
  static TextEditingController nameandfulladdressofnominee =
      TextEditingController();
  static TextEditingController relationshipwithemployee =
      TextEditingController();
  static TextEditingController ageofnominee = TextEditingController();
  static TextEditingController proportionbywhichgratuityshare =
      TextEditingController();
  static TextEditingController nameofwitness = TextEditingController();
  static TextEditingController addressofthewiteness = TextEditingController();

  bool isloading = false;
  var value = 0;
  var date,
      residentialstatusvalue,
      EmpID,
      employeedetailsgetcode,
      employeedetailsgetmessage,
      Employeemastergetdetails,
      Dateofbirth,
      dobpickDate,
      employeedetailspostcode,
      employeedetailspostmessage;

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
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body:
              // formfdetailsgetcode == null
              //     ? Center(
              //         child: CustomLoader(h: h, w: w),
              //       )
              //     :
              Container(
                  height: h,
                  width: w,
                  child: Column(children: [
                    Container(
                      height: h * 0.15,
                      width: w * 0.9,
                      //  color: Colors.red,
                      child: Stack(
                        children: [
                          Positioned(
                            top: h * 0.1,
                            left: w * 0.05,
                            child: CustomText(
                              text: "Form F",
                              color: Color.fromRGBO(0, 0, 0, 0.84),
                              size: 24,
                              weight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: h * 0.67,
                      width: w * 0.9,
                      //  color: Colors.red,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Stack(
                              children: [
                                Container(
                                  height: h * 0.67,
                                  width: w * 0.9,
                                ),
                                Positioned(
                                  top: h * 0.05,
                                  left: w * 0.045,
                                  child: Container(
                                    padding: EdgeInsets.only(
                                        top: h * 0.001, left: w * 0.03),
                                    height: h * 0.2,
                                    width: w * 0.81,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Color.fromRGBO(
                                                200, 200, 216, 0.73),
                                            width: 1.0),
                                        borderRadius:
                                            BorderRadius.circular(10.0)),
                                    child: TextFormField(
                                      style: TextStyle(fontSize: 13),
                                      keyboardType: TextInputType.multiline,
                                      maxLines: null,
                                      controller: nameandfulladdressofnominee,
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText:
                                            " Name and Address of the Nominee",
                                        hintStyle: TextStyle(
                                            color: Color.fromRGBO(
                                                31, 31, 31, 0.6)),
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                    top: h * 0.3,
                                    left: w * 0.045,
                                    child: CustomTextFormField(
                                      height: h * 0.06,
                                      width: w * 0.8,
                                      hintText:
                                          "   Relationship with the Employee",
                                      hintTextStyle: TextStyle(
                                          color:
                                              Color.fromRGBO(31, 31, 31, 0.6),
                                          fontSize: 14,
                                          fontWeight: FontWeight.normal),
                                      borderColor:
                                          Color.fromRGBO(200, 200, 216, 0.73),
                                      textEditingController:
                                          relationshipwithemployee,
                                      keyboardtype: true,
                                    )),
                                Positioned(
                                    top: h * 0.4,
                                    left: w * 0.045,
                                    child: CustomTextFormField(
                                      height: h * 0.06,
                                      width: w * 0.8,
                                      hintText: "   Age of Nominee",
                                      hintTextStyle: TextStyle(
                                          color:
                                              Color.fromRGBO(31, 31, 31, 0.6),
                                          fontSize: 14,
                                          fontWeight: FontWeight.normal),
                                      borderColor:
                                          Color.fromRGBO(200, 200, 216, 0.73),
                                      textEditingController: ageofnominee,
                                      keyboardtype: false,
                                      inputFormatters: [
                                        LengthLimitingTextInputFormatter(2)
                                      ],
                                    )),
                                Positioned(
                                    top: h * 0.5,
                                    left: w * 0.045,
                                    child: CustomTextFormField(
                                      height: h * 0.06,
                                      width: w * 0.8,
                                      hintText:
                                          "  Proportion by which gratuity will be shared",
                                      hintTextStyle: TextStyle(
                                          color:
                                              Color.fromRGBO(31, 31, 31, 0.6),
                                          fontSize: 14,
                                          fontWeight: FontWeight.normal),
                                      borderColor:
                                          Color.fromRGBO(200, 200, 216, 0.73),
                                      textEditingController:
                                          proportionbywhichgratuityshare,
                                      keyboardtype: false,
                                      inputFormatters: [
                                        LengthLimitingTextInputFormatter(3)
                                      ],
                                    )),
                                Positioned(
                                    top: h * 0.6,
                                    left: w * 0.045,
                                    child: CustomTextFormField(
                                      height: h * 0.06,
                                      width: w * 0.8,
                                      hintText: "  Name of Witness",
                                      hintTextStyle: TextStyle(
                                          color:
                                              Color.fromRGBO(31, 31, 31, 0.6),
                                          fontSize: 14,
                                          fontWeight: FontWeight.normal),
                                      borderColor:
                                          Color.fromRGBO(200, 200, 216, 0.73),
                                      textEditingController: nameofwitness,
                                      keyboardtype: true,
                                    )),
                              ],
                            ),
                            Container(
                              height: h * 0.6,
                              width: w * 0.9,
                              //   color: Colors.blue,
                              child: Column(
                                children: [
                                  Stack(
                                    children: [
                                      Container(
                                        height: h * 0.6,
                                        width: w * 0.9,
                                      ),
                                      Positioned(
                                        top: h * 0.01,
                                        left: w * 0.045,
                                        child: Container(
                                          padding: EdgeInsets.only(
                                              top: h * 0.001, left: w * 0.03),
                                          height: h * 0.2,
                                          width: w * 0.81,
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Color.fromRGBO(
                                                      200, 200, 216, 0.73),
                                                  width: 1.0),
                                              borderRadius:
                                                  BorderRadius.circular(10.0)),
                                          child: TextFormField(
                                            style: TextStyle(fontSize: 13),
                                            keyboardType:
                                                TextInputType.multiline,
                                            maxLines: null,
                                            controller: addressofthewiteness,
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              hintText:
                                                  "  Address of the Witness",
                                              hintStyle: TextStyle(
                                                  color: Color.fromRGBO(
                                                      31, 31, 31, 0.6)),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                          top: h * 0.25,
                                          left: w * 0.045,
                                          child: CustomText(
                                            text: "Signature of Employee",
                                            color: Color.fromRGBO(0, 0, 0, 1),
                                            weight: FontWeight.normal,
                                            size: 18,
                                          )),
                                      Positioned(
                                        top: h * 0.3,
                                        left: w * 0.045,
                                        child: Button(
                                          onTap: () {
                                            Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        formfsignaturepad()));
                                          },
                                          iconWant: false,
                                          height: h * 0.065,
                                          width: w * 0.35,
                                          color: Colors.white,
                                          text: "Add",
                                          weight: FontWeight.normal,
                                          border: Border.all(
                                              color: Color.fromRGBO(
                                                  112, 112, 112, 1)),
                                          btText: 15,
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ])),
          bottomSheet:
              //  form1detailsgetcode == null
              //     ? Center(child: CustomLoader(h: h, w: w))
              //     :
              Container(
            height: h * 0.1,
            width: w,
            color: Colors.white,
            child: Container(
              height: h * 0.1,
              width: w,
              child: Stack(
                children: [
                  Container(
                    height: h * 0.1,
                    width: w * 0.9,
                  ),
                  Positioned(
                    top: h * 0.01,
                    left: w * 0.1,
                    child: Custom_Button(
                      onTap: () {
                        formfapiPost();
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
        ));
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

      nameandfulladdressofnominee.text =
          Employeemastergetdetails[0]["Employers_Code_No "] == ""
              ? ""
              : Employeemastergetdetails[0]["Employers_Code_No "];

      relationshipwithemployee.text = Employeemastergetdetails[0]
                  ["Employers_Code_No_of_previous_employment"] ==
              ""
          ? ""
          : Employeemastergetdetails[0]
              ["Employers_Code_No_of_previous_employment"];

      ageofnominee.text =
          Employeemastergetdetails[0]["Name_and_Address_of_Employer"] == ""
              ? ""
              : Employeemastergetdetails[0]["Name_and_Address_of_Employer"];

      proportionbywhichgratuityshare.text = Employeemastergetdetails[0]
                  ["Name_and_Address_of_Previous_Employer"] ==
              ""
          ? ""
          : Employeemastergetdetails[0]
              ["Name_and_Address_of_Previous_Employer"];

      nameofwitness.text = Employeemastergetdetails[0]["Nominee_Name "] == ""
          ? ""
          : Employeemastergetdetails[0]["Nominee_Name "];

      addressofthewiteness.text = Employeemastergetdetails[0]
                      ["Nominees_relationship_with_the_Employee"] ==
                  "" ||
              Employeemastergetdetails[0]
                      ["Nominees_relationship_with_the_Employee"] ==
                  "null"
          ? ""
          : Employeemastergetdetails[0]
              ['Nominees_relationship_with_the_Employee'];
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

  formfapiPost() async {
    Logger().e({
      "Emp_ID": EmpID.toString(),
      "Name_in_full_with_full_address_of_nominees":
          nameandfulladdressofnominee.text.toString(),
      "Relationship_with_the_employee":
          relationshipwithemployee.text.toString(),
      "Age_of_nominee": ageofnominee.text.toString(),
      "Proportion_by_which_the_gratuity_will_be_shared":
          proportionbywhichgratuityshare.text.toString(),
      "Name_of_the_Witnesses": nameofwitness.text.toString(),
      "Address_of_the_Witnesses": addressofthewiteness.text.toString(),
    });

    var url = Uri.parse(
        "${Provider.of<Baseurl>(context, listen: false).baseurl}${Baseurl().emplyeedetailspost}");
    print("posurl:$url");

    var response = await http.post(url, body: <String, dynamic>{
      "Emp_ID": EmpID.toString(),
      "Name_in_full_with_full_address_of_nominees":
          nameandfulladdressofnominee.text.toString(),
      "Relationship_with_the_employee":
          relationshipwithemployee.text.toString(),
      "Age_of_nominee": ageofnominee.text.toString(),
      "Proportion_by_which_the_gratuity_will_be_shared":
          proportionbywhichgratuityshare.text.toString(),
      "Name_of_the_Witnesses": nameofwitness.text.toString(),
      "Address_of_the_Witnesses": addressofthewiteness.text.toString(),
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
