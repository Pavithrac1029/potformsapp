import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../LOGIN_NEW/login_view.dart';


class MyAuthService extends ChangeNotifier {
  var verifiCationCode;
  bool loadVerify = false;

  Future verifyOtp({phoneNumber, context, page}) async {
    print(phoneNumber);
    print("authservicepage:$page");

    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          await FirebaseAuth.instance
              .signInWithCredential(credential)
              .then((value) async {
            if (value.user != null) {
              Navigator.push(
                  context, MaterialPageRoute(builder: (ctx) => page));
            }
          });
        },
        verificationFailed: (FirebaseException er) {
          print(er);
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (ctx) => Loginview()));
          final snackBar = SnackBar(
            backgroundColor: Colors.redAccent,
            content: Text('Try Some Later To Get OTP'),
            duration: Duration(seconds: 4),
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        },
        codeSent: (String verifyId, int? resendToken) {
          verifiCationCode = verifyId;
          print("c level $verifiCationCode");
          notifyListeners();
        },
        codeAutoRetrievalTimeout: (String verifyId) {
          verifiCationCode = verifyId;
        });
    notifyListeners();
  }

  checkOtp({otp, context, page, code}) async {
    loadVerify = true;
    print("code $code");
    print("otp $otp");

    try {
      await FirebaseAuth.instance
          .signInWithCredential(
              PhoneAuthProvider.credential(verificationId: code, smsCode: otp))
          .then((value) async {
        if (value.user != null) {
          loadVerify = false;
          Navigator.push(context, MaterialPageRoute(builder: (ctx) => page));
          notifyListeners();
        }
      });
    } catch (e) {
      print("");
      final snackBar = SnackBar(
        backgroundColor: Colors.teal.shade300,
        content: Text('Invalid OTP'),
        duration: Duration(seconds: 3),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      // CustomSnackbar()
      // .show(context: context, text: "Invalid OTP");
    }
  }
}
