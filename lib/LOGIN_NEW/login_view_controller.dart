import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:potformsapp/LOGIN_NEW/otpscreen_view.dart';

import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../BASE URL/api.dart';

class LoginController extends ChangeNotifier {
  var employeeDetails, employeeDetailscode, EmployeeID;
  String Mobile_no = "";

  EmployeeIDloginGet({Emp_ID, context}) async {
    var url = Uri.parse(
        "${Provider.of<Baseurl>(context, listen: false).baseurl}${Baseurl().employeeidlogin}?Emp_ID=${Emp_ID}");

    print(url);
    var response = await http.get(url);
    print(response.body);
    var EmployeeIDlogindecodeDetails = json.decode(response.body);
    print(EmployeeIDlogindecodeDetails);
    employeeDetailscode = EmployeeIDlogindecodeDetails["code"];
    if (employeeDetailscode == 200) {
      employeeDetails = EmployeeIDlogindecodeDetails["data"][0];
      Mobile_no = employeeDetails['Mobile_No'];
      setEmployeeid(givenid: Emp_ID.toString());

      if (Mobile_no != null || Mobile_no.isNotEmpty) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => OTPscreenView(
                      givenMobileNUmber: Mobile_no.toString(),
                      //givenMobile
                    )));
      }
      print("mob:$Mobile_no");
    } else if (employeeDetailscode == 202) {
      final snackBar = SnackBar(
        backgroundColor: Color(0xff213B68),
        content: Text(
            "${EmployeeIDlogindecodeDetails["code"]}:${EmployeeIDlogindecodeDetails["message"]}"),
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
        content: Text(
            "${EmployeeIDlogindecodeDetails["code"]}:${employeeDetails = EmployeeIDlogindecodeDetails["message"]}"),
        duration: Duration(seconds: 3),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
    print(employeeDetails);

    notifyListeners();
  }

  setEmployeeid({givenid}) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString("employeeId", givenid);
    notifyListeners();
    getEmployeeid();
  }

  getEmployeeid() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    EmployeeID = preferences.getString("employeeId");
    print("loginnnemployeeid:$EmployeeID");
    notifyListeners();
  }
}
