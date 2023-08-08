import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:potformsapp/COMMON_WIDGETS/custom_button.dart';

import 'package:potformsapp/LOGIN_NEW/login_view_controller.dart';

import 'package:select_form_field/select_form_field.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';

import '../../BASE URL/api.dart';
import '../../COMMON_WIDGETS/button.dart';

import '../../COMMON_WIDGETS/custom_iconbutton.dart';

import '../../COMMON_WIDGETS/custom_text.dart';
import '../../customfields/custom_loader.dart';
import '../../customfields/customtextformfields.dart';
import '../FORM_LIST/formlist.dart';


class Formdeclaration extends StatefulWidget {
  const Formdeclaration({Key? key}) : super(key: key);

  @override
  State<Formdeclaration> createState() => _FormdeclarationState();
}

class _FormdeclarationState extends State<Formdeclaration> {
  static TextEditingController employerscode_no = TextEditingController();
  static TextEditingController name_and_address_of_employer =
      TextEditingController();
  static TextEditingController employers_code_no_of_previousemployment =
      TextEditingController();
  static TextEditingController name_and_address_of_previousemployer =
      TextEditingController();

  static TextEditingController nomineename = TextEditingController();
  static TextEditingController nominee_relationship_with_theemployee =
      TextEditingController();
  static TextEditingController address_of_the_nomineename =
      TextEditingController();
  static TextEditingController date_of_birth_age = TextEditingController();
  static TextEditingController relationship_with_employee =
      TextEditingController();
  static TextEditingController whether_residing_with_him_her_yes_or_no =
      TextEditingController();
  static TextEditingController if_no_state_place_of__residence_town_and_state =
      TextEditingController();

  bool isloading = false;
  bool value1 = false;

  final List<Map<String, dynamic>> _residentialstatus = [
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

  @override
  initState() {
    Provider.of<LoginController>(context, listen: false).getEmployeeid();

    EmpID = Provider.of<LoginController>(context, listen: false).EmployeeID;
    print("eplllllid:${EmpID.toString()}");

    getdetails();
    super.initState();
  }

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
            // form1detailsgetcode == null
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
                height: h * 0.15,
                width: w * 0.9,
                //  color: Colors.red,
                child: Stack(
                  children: [
                    Positioned(
                      top: h * 0.1,
                      left: w * 0.05,
                      child: CustomText(
                        text: "Form 1",
                        color: Color.fromRGBO(0, 0, 0, 0.84),
                        size: 24,
                        weight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: h * 0.87,
                //   color: Colors.orange,
                width: w * 0.9,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          Container(
                            height: h * 0.87,
                            width: w * 0.9,
                          ),
                          Positioned(
                              top: h * 0.05,
                              left: w * 0.045,
                              child: CustomTextFormField(
                                height: h * 0.06,
                                width: w * 0.8,
                                hintText: "  Employers Code Number",
                                hintTextStyle: TextStyle(
                                    color: Color.fromRGBO(31, 31, 31, 0.6),
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal),
                                borderColor:
                                    Color.fromRGBO(200, 200, 216, 0.73),
                                textEditingController: employerscode_no,
                                keyboardtype: true,
                              )),
                          Positioned(
                              top: h * 0.14,
                              left: w * 0.045,
                              child: CustomTextFormField(
                                height: h * 0.06,
                                width: w * 0.8,
                                hintText:
                                    " Employers Codeno of Previous Employement",
                                hintTextStyle: TextStyle(
                                    color: Color.fromRGBO(31, 31, 31, 0.6),
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal),
                                borderColor:
                                    Color.fromRGBO(200, 200, 216, 0.73),
                                textEditingController:
                                    employers_code_no_of_previousemployment,
                                keyboardtype: true,
                              )),
                          Positioned(
                            top: h * 0.235,
                            left: w * 0.045,
                            child: Container(
                              padding: EdgeInsets.only(
                                  top: h * 0.001, left: w * 0.03),
                              height: h * 0.2,
                              width: w * 0.81,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color:
                                          Color.fromRGBO(200, 200, 216, 0.73),
                                      width: 1.0),
                                  borderRadius: BorderRadius.circular(10.0)),
                              child: TextFormField(
                                style: TextStyle(fontSize: 13),
                                keyboardType: TextInputType.multiline,
                                maxLines: null,
                                controller: name_and_address_of_employer,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: " Name & Address of Employer",
                                  hintStyle: TextStyle(
                                      color: Color.fromRGBO(31, 31, 31, 0.6)),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            top: h * 0.48,
                            left: w * 0.045,
                            child: Container(
                              padding: EdgeInsets.only(
                                  top: h * 0.001, left: w * 0.03),
                              height: h * 0.2,
                              width: w * 0.81,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color:
                                          Color.fromRGBO(200, 200, 216, 0.73),
                                      width: 1.0),
                                  borderRadius: BorderRadius.circular(10.0)),
                              child: TextFormField(
                                style: TextStyle(fontSize: 13),
                                keyboardType: TextInputType.multiline,
                                maxLines: null,
                                controller:
                                    name_and_address_of_previousemployer,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText:
                                      " Name & Address of Previous Employer",
                                  hintStyle: TextStyle(
                                      color: Color.fromRGBO(31, 31, 31, 0.6)),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                              top: h * 0.715,
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
                                textEditingController: nomineename,
                                keyboardtype: true,
                              )),
                          Positioned(
                              top: h * 0.805,
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
                                textEditingController:
                                    relationship_with_employee,
                                keyboardtype: true,
                              )),
                        ],
                      ),
                      Container(
                        height: h * 0.99,
                        width: w * 0.9,
                        // color: Colors.pink,
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Stack(
                                children: [
                                  Container(
                                    height: h * 0.86,
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
                                              width:
                                                  1.0), // Change the border color here
                                          borderRadius:
                                              BorderRadius.circular(10.0)),
                                      child: TextFormField(
                                        style: TextStyle(fontSize: 13),
                                        keyboardType: TextInputType.multiline,
                                        maxLines: null,
                                        controller: address_of_the_nomineename,
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: "  Address of the Nominee",
                                          hintStyle: TextStyle(
                                              color: Color.fromRGBO(
                                                  31, 31, 31, 0.6)),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                      top: h * 0.245,
                                      left: w * 0.045,
                                      child: CustomTextFormField(
                                        height: h * 0.06,
                                        width: w * 0.81,
                                        hintText: " Date of Birth",
                                        hintTextStyle: TextStyle(
                                            color:
                                                Color.fromRGBO(31, 31, 31, 0.6),
                                            fontSize: 14,
                                            fontWeight: FontWeight.normal),
                                        borderColor:
                                            Color.fromRGBO(200, 200, 216, 0.73),
                                        textEditingController:
                                            date_of_birth_age,
                                        readonly: true,
                                        suffixicon: InkWell(
                                          onTap: () {
                                            dateofbirthDatepicking();
                                          },
                                          child: Icon(
                                            Icons.calendar_today_outlined,
                                            size: 20,
                                            color: Color(0xff213B68),
                                          ),
                                        ),
                                      )),
                                  Positioned(
                                    top: h * 0.34,
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
                                            width:
                                                1.0), // Change the border color here
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                      child: SelectFormField(
                                        style: TextStyle(
                                            fontSize: 13, color: Colors.black),
                                        controller:
                                            whether_residing_with_him_her_yes_or_no,
                                        onChanged: (val) {
                                          setState(() {
                                            residentialstatusvalue = val;
                                          });
                                        },
                                        items: _residentialstatus,
                                        type: SelectFormFieldType.dropdown,
                                        decoration: InputDecoration(
                                          hintText:
                                              '  Whether residing with him/her',
                                          hintStyle: TextStyle(
                                              color: Color.fromRGBO(
                                                  31, 31, 31, 0.6),
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
                                    top: h * 0.44,
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
                                              width:
                                                  1.0), // Change the border color here
                                          borderRadius:
                                              BorderRadius.circular(10.0)),
                                      child: TextFormField(
                                        style: TextStyle(fontSize: 13),
                                        keyboardType: TextInputType.multiline,
                                        maxLines: null,
                                        controller:
                                            if_no_state_place_of__residence_town_and_state,
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText:
                                              "  If No / Place of Residence Town and State",
                                          hintStyle: TextStyle(
                                              color: Color.fromRGBO(
                                                  31, 31, 31, 0.6)),
                                        ),
                                      ),
                                    ),
                                  ),
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
              ),
            ],
          ),
        ),
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
            // decoration: BoxDecoration(
            //     image: DecorationImage(
            //         image: AssetImage("assets/bg.png"),
            //         fit: BoxFit.fill)),
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
                      form1apiPost();
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

      employerscode_no.text =
          Employeemastergetdetails[0]["Employers_Code_No "] == ""
              ? ""
              : Employeemastergetdetails[0]["Employers_Code_No "];

      employers_code_no_of_previousemployment.text = Employeemastergetdetails[0]
                  ["Employers_Code_No_of_previous_employment"] ==
              ""
          ? ""
          : Employeemastergetdetails[0]
              ["Employers_Code_No_of_previous_employment"];

      name_and_address_of_employer.text =
          Employeemastergetdetails[0]["Name_and_Address_of_Employer"] == ""
              ? ""
              : Employeemastergetdetails[0]["Name_and_Address_of_Employer"];

      name_and_address_of_previousemployer.text = Employeemastergetdetails[0]
                  ["Name_and_Address_of_Previous_Employer"] ==
              ""
          ? ""
          : Employeemastergetdetails[0]
              ["Name_and_Address_of_Previous_Employer"];

      nomineename.text = Employeemastergetdetails[0]["Nominee_Name "] == ""
          ? ""
          : Employeemastergetdetails[0]["Nominee_Name "];

      nominee_relationship_with_theemployee.text = Employeemastergetdetails[0]
                      ["Nominees_relationship_with_the_Employee"] ==
                  "" ||
              Employeemastergetdetails[0]
                      ["Nominees_relationship_with_the_Employee"] ==
                  "null"
          ? ""
          : Employeemastergetdetails[0]
              ['Nominees_relationship_with_the_Employee'];

      address_of_the_nomineename.text =
          Employeemastergetdetails[0]["Address_of_the_Nominee_Name"] == ""
              ? ""
              : Employeemastergetdetails[0]['Address_of_the_Nominee_Name'];

      date_of_birth_age.text =
          Employeemastergetdetails[0]["Date_of_Birth_Age "] == ""
              ? ""
              : Employeemastergetdetails[0]["Date_of_Birth_Age "];

      whether_residing_with_him_her_yes_or_no.text = Employeemastergetdetails[0]
                  ["Whether_residing_with_him_her_Yes_No "] ==
              ""
          ? ""
          : Employeemastergetdetails[0]
              ["Whether_residing_with_him_her_Yes_No "];

      if_no_state_place_of__residence_town_and_state.text =
          Employeemastergetdetails[0]
                      ["If_No_state_Place_of_Residence_Town_and_State "] ==
                  ""
              ? ""
              : Employeemastergetdetails[0]
                  ["If_No_state_Place_of_Residence_Town_and_State "];
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

  form1apiPost() async {
    Logger().e({
      "Emp_ID": EmpID.toString(),
      "Employers_Code_No ": employerscode_no.text.toString(),
      "Name_and_Address_of_Employer":
          name_and_address_of_employer.text.toString(),
      "Employers_Code_No_of_previous_employment":
          employers_code_no_of_previousemployment.text.toString(),
      "Name_and_Address_of_Previous_Employer":
          name_and_address_of_previousemployer.text.toString(),
      "Nominee_Name ": nomineename.text.toString(),
      "Nominees_relationship_with_the_Employee":
          relationship_with_employee.text.toString(),
      "Address_of_the_Nominee__": address_of_the_nomineename.text.toString(),
      "Date_of_Birth_Age ": dobpickDate.toString(),
      "Whether_residing_with_him_her_Yes_No ":
          residentialstatusvalue.toString(),
      "If_No_state_Place_of_Residence_Town_and_State ":
          if_no_state_place_of__residence_town_and_state.text.toString(),
    });

    var url = Uri.parse(
        "${Provider.of<Baseurl>(context, listen: false).baseurl}${Baseurl().emplyeedetailspost}");
    print("posurl:$url");

    var response = await http.post(url, body: <String, dynamic>{
      "Emp_ID": EmpID.toString(),
      "Employers_Code_No ": employerscode_no.text.toString(),
      "Name_and_Address_of_Employer":
          name_and_address_of_employer.text.toString(),
      "Employers_Code_No_of_previous_employment":
          employers_code_no_of_previousemployment.text.toString(),
      "Name_and_Address_of_Previous_Employer":
          name_and_address_of_previousemployer.text.toString(),
      "Nominee_Name ": nomineename.text.toString(),
      "Nominees_relationship_with_the_Employee":
          relationship_with_employee.text.toString(),
      "Address_of_the_Nominee__": address_of_the_nomineename.text.toString(),
      "Date_of_Birth_Age ": dobpickDate.toString(),
      "Whether_residing_with_him_her_Yes_No ":
          residentialstatusvalue.toString(),
      "If_No_state_Place_of_Residence_Town_and_State ":
          if_no_state_place_of__residence_town_and_state.text.toString(),
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

      date_of_birth_age.text =
          myFormat.format(date); // Format for display "dd/MM/yyyy"
      print(date_of_birth_age.text.toString());
    }
  }
}
