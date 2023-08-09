import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:potformsapp/AuthService/authservice.dart';

import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../COMMON_WIDGETS/custom_button.dart';
import '../COMMON_WIDGETS/custom_text.dart';
import '../customfields/custom_loader.dart';

import 'login_view_controller.dart';

class Loginview extends StatefulWidget {
  const Loginview({Key? key}) : super(key: key);

  @override
  State<Loginview> createState() => _LoginviewState();
}

class _LoginviewState extends State<Loginview> {
  var fcmsignToken, empId, setempid, msg, LoginID;
  bool passwordEye = true;
  bool passwordEyeConfirm = true;
  bool baseUrlChange = false;
  bool passWord = false;
  bool modalBool = false;
  bool isloading = false;
  bool loader = false;
  var mobileController = TextEditingController();
  var empidController = TextEditingController();
  var otpController = TextEditingController();
  int p = 0;
  String? mobileNo;
  String passGive = "";

  //final l = Logger();
  String? mobile, verificationId, smsCode;
  bool codeSent = false;
  bool _rememberMe = false;

  void initState() {
    // FirebaseMessaging.instance.getToken().then((value) {
    //   setState(() {
    //     fcmsignToken = value;
    //   });
    // });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () {
        SystemNavigator.pop();
        return Future.value(true);
      },
      child: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Container(
            height: h,
            width: w,
            child: Stack(
              children: [
                Container(
                  height: h * 0.8,
                  width: w,
                ),
                Positioned(
                    top: h * 0.000001,
                    child: SvgPicture.asset("assets/loginheader.svg")),
                Positioned(
                  top: h * 0.4,
                  left: w * 0.35,
                  child: CustomText(
                    text: "Sign in Now",
                    color: Color(0xff000000),
                    size: 20,
                    weight: FontWeight.w500,
                  ),
                ),
                Positioned(
                  top: h * 0.47,
                  left: w * 0.1,
                  child: SizedBox(
                    width: w * 0.78,
                    child: TextFormField(
                      style: TextStyle(fontSize: 13),
                      controller: empidController,
                      decoration: InputDecoration(
                        prefixIcon: Padding(
                          padding: EdgeInsets.all(20),
                          child: Icon(
                            Icons.person,
                            color: Color(0xff152B4D),
                            size: 20,
                          ),
                        ),
                        hintText: "Employee ID",
                        hintStyle: TextStyle(
                          color: Color(0xff959595),
                          fontWeight: FontWeight.normal,
                          fontSize: 14,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide(
                            color: Color(0xff213B68),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide(
                            color: Color(0xff213B68),
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide(
                            color: Color(0xff213B68),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: h * 0.6,
                  left: w * 0.1,
                  child: InkWell(
                    onTap: () {
                      if (empidController.text.toString().isNotEmpty) {
                        Provider.of<LoginController>(context, listen: false)
                            .EmployeeIDloginGet(
                                Emp_ID: empidController.text.toString(),
                                context: context);
                      } else {
                        final snackBar = SnackBar(
                          backgroundColor: Color(0xff213B68),
                          content: Text("Please Enter the EmployeeID"),
                          duration: Duration(seconds: 3),
                          behavior: SnackBarBehavior.floating,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }

                      FocusManager.instance.primaryFocus?.unfocus();
                    },
                    child: Custom_Button(
                      border: Border.all(color: Colors.transparent),
                      height: h * 0.075,
                      width: w * 0.78,
                      color: Color(0xff213B68),
                      text: "Sign in",
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

//   Future<void> verifyPhone(mobile) async {
//     final PhoneVerificationCompleted verified = (AuthCredential authResult) {
//       AuthService().signIn(authResult);
//     };
//     final PhoneVerificationFailed verificationfailed =
//         (FirebaseAuthException authException) {};
//     final PhoneCodeSent smsSent = (String verId, [int? forceResend]) {
//       setState(() {
//         this.verificationId = verId;
//         this.codeSent = true;
//       });
//     } as PhoneCodeSent;
//     final PhoneCodeAutoRetrievalTimeout autoTimeout = (String verId) {
//       setState(() {
//         this.verificationId = verId;
//       });
//     };
//     await FirebaseAuth.instance.verifyPhoneNumber(
//         phoneNumber: "+91${mobile}",
//         timeout: const Duration(seconds: 15),
//         verificationCompleted: verified,
//         verificationFailed: verificationfailed,
//         codeSent: smsSent,
//         codeAutoRetrievalTimeout: autoTimeout);
//   }

//   clearText() {
//     mobileController.clear();
//   }
// }

// class FirebaseMessaging {}
