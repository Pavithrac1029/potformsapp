import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';

import 'package:flutter_svg/svg.dart';
import 'package:potformsapp/HOME_PAGE/home_page.dart';

import 'package:provider/provider.dart';

import '../AUTH/auth_service.dart';
import '../COMMON_WIDGETS/custom_button.dart';
import '../customfields/customtext.dart';
import 'login_view.dart';

class OTPscreenView extends StatefulWidget {
  String? givenMobileNUmber;

  OTPscreenView({this.givenMobileNUmber});

  @override
  State<OTPscreenView> createState() => _OTPscreenViewState();
}

class _OTPscreenViewState extends State<OTPscreenView> {
  var otp;
  StreamSubscription<String>? _smsSubscription;

  @override
  void initState() {
    super.initState();

    Provider.of<MyAuthService>(context, listen: false).verifyOtp(
    
        context: context,
        phoneNumber: "+91${widget.givenMobileNUmber}");
  }

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Loginview()));
        return Future.value(false);
      },
      // child: ModalProgressHUD(
      //   progressIndicator: Image.asset("assets/P2D-Transparent.gif"),
      //   inAsyncCall: Provider.of<MyAuthService>(context, listen: true)
      //                   .verifiCationCode ==
      //               null ||
      //           Provider.of<MyAuthService>(context, listen: true).loadVerify ==
      //               true
      //       ? false
      //       : false,
      child: GestureDetector(
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
                  top: h * 0.15,
                  left: w * 0.27,
                  child: CustomText(
                    text: "Verify Phone number",
                    color: Color(0xff000000),
                    size: 20,
                    weight: FontWeight.w500,
                  ),
                ),
                Positioned(
                  top: h * 0.18,
                  left: w * 0.25,
                  child: Container(
                      height: h * 0.3,
                      width: w * 0.5,
                      //color: Colors.red,
                      child: SvgPicture.asset("assets/otpscreen.svg")),
                ),
                Positioned(
                  top: h * 0.53,
                  left: w * 0.1,
                  child: CustomText(
                    text: "Please enter the verification code send to",
                    color: Color.fromRGBO(0, 0, 0, 0.87),
                    size: 15,
                    weight: FontWeight.normal,
                  ),
                ),
                Positioned(
                  top: h * 0.56,
                  left: w * 0.1,
                  child: CustomText(
                    text: "+91 ${widget.givenMobileNUmber}",
                    color: Color.fromRGBO(33, 59, 104, 1),
                    size: 15,
                    weight: FontWeight.w500,
                  ),
                ),
                Positioned(
                  top: h * 0.58,
                  left: w * 0.08,
                  child: Container(
                    height: h * 0.1,
                    width: w * 0.8,
                    // color: Colors.amber,
                    child: OtpTextField(
                      margin: EdgeInsets.only(left: 10),
                      numberOfFields: 6,

                      cursorColor: Color(0xff213B68),
                      focusedBorderColor: Color(0xff213B68),

                      onCodeChanged: (val) {},

                      onSubmit: (val) {
                        setState(() {
                          otp = val;
                        });
                      }, // end onSubmit
                    ),
                  ),
                ),
                Positioned(
                  bottom: h * 0.17,
                  left: w * 0.1,
                  child: Container(
                    height: h * 0.05,
                    width: w * 0.8,
                    alignment: Alignment.center,
                    // color: Colors.amber,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomText(
                          text: "Didn't receive the code?  ",
                          size: 12,
                          weight: FontWeight.normal,
                          color: Color(0xff858585),
                        ),
                        InkWell(
                          onTap: () {
                            // Provider.of<MyAuthService>(context, listen: false)
                            //     .verifyOtp(
                            //         page: NewPasswordview(
                            //             mobileNuber: widget.givenMobileNUmber),
                            //         context: context,
                            //         phoneNumber:
                            //             "+91${widget.givenMobileNUmber}");
                          },
                          child: CustomText(
                            text: "Resend",
                            size: 13,
                            weight: FontWeight.normal,
                            color: Color(0xff2A56C6),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  bottom: h * 0.1,
                  left: w * 0.1,
                  child: Custom_Button(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => HomePage()));
                      // if (widget.pageId == 1) {
                      FocusManager.instance.primaryFocus?.unfocus();
                      // Provider.of<MyAuthService>(context, listen: false)
                      //     .checkOtp(
                      //   page: NewPasswordview(
                      //       pageId: 1, mobileNuber: widget.givenMobileNUmber),
                      //   context: context,
                      //   otp: otp,
                      //   code:
                      //       Provider.of<MyAuthService>(context, listen: false)
                      //           .verifiCationCode,
                      // );
                      // } else {
                      FocusManager.instance.primaryFocus?.unfocus();
                      // Provider.of<MyAuthService>(context, listen: false)
                      //     .checkOtp(
                      //   page: NewPasswordview(
                      //       pageId: 2, mobileNuber: widget.givenMobileNUmber),
                      //   context: context,
                      //   otp: otp,
                      //   code:
                      //       Provider.of<MyAuthService>(context, listen: false)
                      //           .verifiCationCode,
                      // );
                      //}
                    },
                    height: h * 0.06,
                    width: w * 0.78,
                    color: Color(0xff213B68),
                    border: Border.all(color: Colors.transparent),
                    btText: 18,
                    text: "Verify",
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      //    ),
    );
  }
}
