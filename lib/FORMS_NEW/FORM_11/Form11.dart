import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:potformsapp/BASE%20URL/api.dart';
import 'package:potformsapp/LOGIN_NEW/login_view_controller.dart';

import 'package:provider/provider.dart';
import 'package:select_form_field/select_form_field.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '../../COMMON_WIDGETS/custom_button.dart';

import '../../COMMON_WIDGETS/custom_checkcircle.dart';
import '../../COMMON_WIDGETS/custom_text.dart';
import '../../customfields/custom_loader.dart';
import '../../customfields/customtextformfields.dart';

import '../FORM_LIST/formlist.dart';

class FormPage extends StatefulWidget {
  const FormPage({Key? key}) : super(key: key);

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  static TextEditingController earlier_member_of_pf_scheme =
      TextEditingController();
  static TextEditingController earlier_member_of_pension_scheme =
      TextEditingController();
  static TextEditingController previous_pf_account_no = TextEditingController();
  static TextEditingController dateofexit_of_previous_employment =
      TextEditingController();
  static TextEditingController scheme_certificate_if_issued =
      TextEditingController();
  static TextEditingController pension_payment_order_no =
      TextEditingController();
  static TextEditingController international_worker_iw_yes_no =
      TextEditingController();
  static TextEditingController if_iw_state_country = TextEditingController();
  static TextEditingController passportno = TextEditingController();
  static TextEditingController validitypassport = TextEditingController();

  final List<Map<String, dynamic>> _pf_status = [
    {
      'value': 'Yes',
      'label': 'Yes',
      'textStyle': TextStyle(color: Colors.black),
    },
    {
      'value': 'No',
      'label': 'No',
      'textStyle': TextStyle(color: Colors.black),
    }
  ];

  final List<Map<String, dynamic>> _pension_scheme = [
    {
      'value': 'Yes',
      'label': 'Yes',
    },
    {
      'value': 'No',
      'label': 'No',
    }
  ];

  final List<Map<String, dynamic>> _IW = [
    {
      'value': 'Yes',
      'label': 'Yes',
    },
    {
      'value': 'No',
      'label': 'No',
    }
  ];

  var earlierpfstatusvalue,
      earlierpensionstatusvalue,
      Dateofexit,
      doepickDate,
      schemestatusvalue,
      iwstatusvalue,
      passportvalidity,
      validitypassportpickDate,
      EmpID,
      employeedetailsgetcode,
      employeedetailsgetmessage,
      Employeemastergetdetails,
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
            // form11detailsgetcode == null
            //     ? Center(
            //         child: CustomLoader(h: h, w: w),
            //       )
            //     :
            Container(
          height: h,
          width: w,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: h * 0.18,
                  width: w * 0.9,
                  // color: Colors.red,
                  child: Stack(
                    children: [
                      Positioned(
                        top: h * 0.1,
                        left: w * 0.05,
                        child: CustomText(
                          text: "Form 11",
                          color: Color.fromRGBO(0, 0, 0, 0.84),
                          size: 24,
                          weight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: h * 0.92,
                  //  color: Colors.orange,
                  width: w * 0.9,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            Container(
                              height: h * 0.92,
                              // color: Colors.orange,
                              width: w * 0.9,
                            ),
                            Positioned(
                              top: h * 0.02,
                              left: w * 0.045,
                              child: CustomText(
                                text:
                                    "Earlier a member of Employees Provident Fund\nScheme\1952",
                                color: Color.fromRGBO(31, 31, 31, 0.88),
                                weight: FontWeight.normal,
                                size: 14,
                              ),
                            ),
                            Positioned(
                              top: h * 0.09,
                              left: w * 0.045,
                              child: Container(
                                padding: EdgeInsets.only(
                                    top: h * 0.001, left: w * 0.00),
                                height: h * 0.06,
                                width: w * 0.81,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color:
                                          Color.fromRGBO(200, 200, 216, 0.73),
                                      width:
                                          1.0), // Change the border color here
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                child: SelectFormField(
                                  style: TextStyle(
                                      fontSize: 13, color: Colors.black),
                                  controller: earlier_member_of_pf_scheme,
                                  onChanged: (val) {
                                    setState(() {
                                      earlierpfstatusvalue = val;
                                    });
                                  },
                                  items: _pf_status,
                                  type: SelectFormFieldType.dropdown,
                                  decoration: InputDecoration(
                                    suffixIcon: Icon(
                                      Icons.arrow_drop_down,
                                      color: Color(0xff27437a),
                                      size: 30,
                                    ),
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              top: h * 0.18,
                              left: w * 0.045,
                              child: CustomText(
                                text:
                                    "Earlier a member of Employees Pension\nScheme 1995",
                                color: Color.fromRGBO(31, 31, 31, 0.88),
                                weight: FontWeight.normal,
                                size: 14,
                              ),
                            ),
                            Positioned(
                              top: h * 0.25,
                              left: w * 0.045,
                              child: Container(
                                padding: EdgeInsets.only(
                                    top: h * 0.001, left: w * 0.00),
                                height: h * 0.06,
                                width: w * 0.81,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color:
                                          Color.fromRGBO(200, 200, 216, 0.73),
                                      width:
                                          1.0), // Change the border color here
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                child: SelectFormField(
                                  style: TextStyle(
                                      fontSize: 13, color: Colors.black),
                                  controller: earlier_member_of_pension_scheme,
                                  onChanged: (val) {
                                    setState(() {
                                      earlierpensionstatusvalue = val;
                                    });
                                  },
                                  items: _pension_scheme,
                                  type: SelectFormFieldType.dropdown,
                                  decoration: InputDecoration(
                                    suffixIcon: Icon(
                                      Icons.arrow_drop_down,
                                      color: Color(0xff27437a),
                                      size: 30,
                                    ),
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                                top: h * 0.35,
                                left: w * 0.045,
                                child: CustomTextFormField(
                                  height: h * 0.06,
                                  width: w * 0.8,
                                  hintText: "  Previous PF Account Number",
                                  hintTextStyle: TextStyle(
                                      color: Color.fromRGBO(31, 31, 31, 0.6),
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal),
                                  borderColor:
                                      Color.fromRGBO(200, 200, 216, 0.73),
                                  textEditingController: previous_pf_account_no,
                                  keyboardtype: true,
                                )),
                            Positioned(
                                top: h * 0.45,
                                left: w * 0.045,
                                child: CustomTextFormField(
                                  height: h * 0.06,
                                  width: w * 0.81,
                                  hintText:
                                      " Date of Exit of Previous Employment",
                                  hintTextStyle: TextStyle(
                                      color: Color.fromRGBO(31, 31, 31, 0.6),
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal),
                                  borderColor:
                                      Color.fromRGBO(200, 200, 216, 0.73),
                                  textEditingController:
                                      dateofexit_of_previous_employment,
                                  readonly: true,
                                  suffixicon: InkWell(
                                    onTap: () {
                                      dateofexitDatepicking();
                                    },
                                    child: Icon(
                                      Icons.calendar_today_outlined,
                                      size: 20,
                                      color: Color(0xff213B68),
                                    ),
                                  ),
                                )),
                            Positioned(
                              top: h * 0.55,
                              left: w * 0.045,
                              child: Container(
                                padding: EdgeInsets.only(
                                    top: h * 0.001, left: w * 0.00),
                                height: h * 0.06,
                                width: w * 0.81,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color:
                                          Color.fromRGBO(200, 200, 216, 0.73),
                                      width:
                                          1.0), // Change the border color here
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                child: SelectFormField(
                                  style: TextStyle(
                                      fontSize: 13, color: Colors.black),
                                  controller: scheme_certificate_if_issued,
                                  onChanged: (val) {
                                    setState(() {
                                      schemestatusvalue = val;
                                    });
                                  },
                                  items: _pf_status,
                                  type: SelectFormFieldType.dropdown,
                                  decoration: InputDecoration(
                                    hintText: '  Scheme Certificate If Issued',
                                    hintStyle: TextStyle(
                                        color: Color.fromRGBO(31, 31, 31, 0.6),
                                        fontSize: 14,
                                        fontWeight: FontWeight.normal),
                                    suffixIcon: Icon(
                                      Icons.arrow_drop_down,
                                      color: Color(0xff27437a),
                                      size: 30,
                                    ),
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide
                                          .none, // Remove the default border
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                                top: h * 0.65,
                                left: w * 0.045,
                                child: CustomTextFormField(
                                  height: h * 0.06,
                                  width: w * 0.8,
                                  hintText: "  Pension Payement Order Number",
                                  hintTextStyle: TextStyle(
                                      color: Color.fromRGBO(31, 31, 31, 0.6),
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal),
                                  borderColor:
                                      Color.fromRGBO(200, 200, 216, 0.73),
                                  textEditingController:
                                      pension_payment_order_no,
                                  keyboardtype: true,
                                )),
                            Positioned(
                                top: h * 0.75,
                                left: w * 0.045,
                                child: Container(
                                    padding: EdgeInsets.only(
                                        top: h * 0.001, left: w * 0.00),
                                    height: h * 0.06,
                                    width: w * 0.81,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Color.fromRGBO(
                                              200, 200, 216, 0.73),
                                          width: 1.0),
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    child: SelectFormField(
                                      controller:
                                          international_worker_iw_yes_no,
                                      onChanged: (val) {
                                        setState(() {
                                          iwstatusvalue = val;
                                        });
                                      },
                                      items: _IW,
                                      type: SelectFormFieldType.dropdown,
                                      decoration: InputDecoration(
                                        hintText: ' International Worker(IW)',
                                        hintStyle: TextStyle(
                                            color:
                                                Color.fromRGBO(31, 31, 31, 0.6),
                                            fontSize: 14,
                                            fontWeight: FontWeight.normal),
                                        suffixIcon: Icon(
                                          Icons.arrow_drop_down,
                                          color: Color(0xff27437a),
                                          size: 30,
                                        ),
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide.none,
                                        ),
                                      ),
                                    ))),
                            Positioned(
                                top: h * 0.85,
                                left: w * 0.045,
                                child: CustomTextFormField(
                                  height: h * 0.06,
                                  width: w * 0.81,
                                  hintText: "   If IW,state country of origin",
                                  hintTextStyle: TextStyle(
                                      color: Color.fromRGBO(31, 31, 31, 0.6),
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal),
                                  borderColor:
                                      Color.fromRGBO(200, 200, 216, 0.73),
                                  textEditingController: if_iw_state_country,
                                  keyboardtype: true,
                                )),
                          ],
                        ),

                        // //jfsjfd
                        Container(
                          height: h * 0.5,
                          width: w * 0.9,
                          // color: Colors.pink,
                          child: Column(
                            children: [
                              Stack(
                                children: [
                                  Container(
                                    height: h * 0.5,
                                    width: w * 0.9,
                                    //  color: Colors.black,
                                  ),
                                  Positioned(
                                      top: h * 0.03,
                                      left: w * 0.045,
                                      child: CustomTextFormField(
                                        height: h * 0.06,
                                        width: w * 0.81,
                                        hintText: "   Passport Number",
                                        hintTextStyle: TextStyle(
                                            color:
                                                Color.fromRGBO(31, 31, 31, 0.6),
                                            fontSize: 14,
                                            fontWeight: FontWeight.normal),
                                        borderColor:
                                            Color.fromRGBO(200, 200, 216, 0.73),
                                        textEditingController: passportno,
                                        keyboardtype: true,
                                      )),
                                  Positioned(
                                      top: h * 0.13,
                                      left: w * 0.045,
                                      child: CustomTextFormField(
                                        height: h * 0.06,
                                        width: w * 0.81,
                                        hintText: "  Validity of Passport",
                                        readonly: true,
                                        textEditingController: validitypassport,
                                        hintTextStyle: TextStyle(
                                            color:
                                                Color.fromRGBO(31, 31, 31, 0.6),
                                            fontSize: 14,
                                            fontWeight: FontWeight.normal),
                                        borderColor:
                                            Color.fromRGBO(200, 200, 216, 0.73),
                                        suffixicon: InkWell(
                                          onTap: () {
                                            ValiditypassportDatepicking();
                                          },
                                          child: Icon(
                                            Icons.calendar_today_outlined,
                                            size: 20,
                                            color:
                                                Color.fromRGBO(33, 59, 104, 1),
                                          ),
                                        ),
                                      )),
                                ],
                              ),
                            ],
                          ),
                        ),

                        // // //jfsdf

                        Container(
                          height: h * 0.1,
                          width: w * 0.9,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        bottomSheet:
            // form11detailsgetcode == null
            //     ? Center(child: CustomLoader(h: h, w: w))
            //     :
            Container(
          height: h * 0.1,
          width: w,
          child: Stack(
            children: [
              Container(
                margin: EdgeInsets.only(left: w * 0.05),
                height: h * 0.1,
                width: w * 0.9,
              ),
              Positioned(
                top: h * 0.01,
                left: w * 0.1,
                child: Custom_Button(
                  onTap: () {
                    form11apiPost();
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
    );
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

      earlier_member_of_pf_scheme.text = Employeemastergetdetails[0][
                  "Earlier_a_member_of_Employees_Provident_Fund_Scheme_1952_Yes_No "] ==
              ""
          ? ""
          : Employeemastergetdetails[0][
              "Earlier_a_member_of_Employees_Provident_Fund_Scheme_1952_Yes_No "];

      earlier_member_of_pension_scheme.text = Employeemastergetdetails[0][
                  "Earlier_a_member_of_Employees_Pension_Scheme_1995_Yes_No"] ==
              ""
          ? ""
          : Employeemastergetdetails[0]
              ["Earlier_a_member_of_Employees_Pension_Scheme_1995_Yes_No"];

      previous_pf_account_no.text =
          Employeemastergetdetails[0]["Previous_PF_account_Number"] == ""
              ? ""
              : Employeemastergetdetails[0]["Previous_PF_account_Number"];

      dateofexit_of_previous_employment.text = Employeemastergetdetails[0]
                  ["Date_of_exit_of_previous_employment"] ==
              ""
          ? ""
          : Employeemastergetdetails[0]["Date_of_exit_of_previous_employment"];

      scheme_certificate_if_issued.text =
          Employeemastergetdetails[0]["Scheme_Certificate_if_issued "] == ""
              ? ""
              : Employeemastergetdetails[0]["Scheme_Certificate_if_issued "];

      pension_payment_order_no.text =
          Employeemastergetdetails[0]["Pension_Payment_order_Number"] == "" ||
                  Employeemastergetdetails[0]["Pension_Payment_order_Number"] ==
                      "null"
              ? ""
              : Employeemastergetdetails[0]['Pension_Payment_order_Number'];

      international_worker_iw_yes_no.text =
          Employeemastergetdetails[0]["International_Worker_IW_Yes_No"] == ""
              ? ""
              : Employeemastergetdetails[0]['International_Worker_IW_Yes_No'];

      if_iw_state_country.text = Employeemastergetdetails[0][
                  "If_IW_state_country_of_origin_India_Name_of_other_country "] ==
              ""
          ? ""
          : Employeemastergetdetails[0]
              ["If_IW_state_country_of_origin_India_Name_of_other_country "];

      passportno.text = Employeemastergetdetails[0]["Passport_Number "] == ""
          ? ""
          : Employeemastergetdetails[0]["Passport_Number "];

      validitypassport.text =
          Employeemastergetdetails[0]["Validity_of_Passport "] == ""
              ? ""
              : Employeemastergetdetails[0]["Validity_of_Passport "];
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

  form11apiPost() async {
    Logger().e({
      "Emp_ID": EmpID.toString(),
      "Earlier_a_member_of_Employees_Provident_Fund_Scheme_1952_Yes_No ":
          earlierpfstatusvalue.toString(),
      "Earlier_a_member_of_Employees_Pension_Scheme_1995_Yes_No":
          earlierpensionstatusvalue.toString(),
      "Previous_PF_account_Number": previous_pf_account_no.text.toString(),
      "Date_of_exit_of_previous_employment": doepickDate.toString(),
      "Scheme_Certificate_if_issued ": schemestatusvalue.toString(),
      "Pension_Payment_order_Number": pension_payment_order_no.text.toString(),
      "International_Worker_IW_Yes_No": iwstatusvalue.toString(),
      "If_IW_state_country_of_origin_India_Name_of_other_country ":
          if_iw_state_country.text.toString(),
      "Passport_Number ": passportno.text.toString(),
      "Validity_of_Passport ": validitypassportpickDate.toString(),
    });

    var url = Uri.parse(
        "${Provider.of<Baseurl>(context, listen: false).baseurl}${Baseurl().emplyeedetailspost}");
    print("posurl:$url");

    var response = await http.post(url, body: <String, dynamic>{
      "Emp_ID": EmpID.toString(),
      "Earlier_a_member_of_Employees_Provident_Fund_Scheme_1952_Yes_No ":
          earlierpfstatusvalue.toString(),
      "Earlier_a_member_of_Employees_Pension_Scheme_1995_Yes_No":
          earlierpensionstatusvalue.toString(),
      "Previous_PF_account_Number": previous_pf_account_no.text.toString(),
      "Date_of_exit_of_previous_employment": doepickDate.toString(),
      "Scheme_Certificate_if_issued ": schemestatusvalue.toString(),
      "Pension_Payment_order_Number": pension_payment_order_no.text.toString(),
      "International_Worker_IW_Yes_No": iwstatusvalue.toString(),
      "If_IW_state_country_of_origin_India_Name_of_other_country ":
          if_iw_state_country.text.toString(),
      "Passport_Number ": passportno.text.toString(),
      "Validity_of_Passport ": validitypassportpickDate.toString(),
    });

    var decodeDetails = json.decode(response.body);
    print("employeedetails:$decodeDetails");
    employeedetailspostcode = decodeDetails['code'];
    employeedetailspostmessage = decodeDetails['message'];

    if (employeedetailspostcode == 200) {
      // setState(() {
      //   setState(() => isloading = false);
      // });
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

  dateofexitDatepicking() async {
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
        Dateofexit = date;
        doepickDate = output.format(date); // Format for storage
      });
      Logger().e(doepickDate);

      dateofexit_of_previous_employment.text =
          myFormat.format(date); // Format for display "dd/MM/yyyy"
      print(dateofexit_of_previous_employment.text.toString());
    }
  }

  ValiditypassportDatepicking() async {
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
        passportvalidity = date;
        validitypassportpickDate = output.format(date); // Format for storage
      });
      Logger().e(validitypassportpickDate);

      validitypassport.text =
          myFormat.format(date); // Format for display "dd/MM/yyyy"
      print(validitypassport.text.toString());
    }
  }
}
