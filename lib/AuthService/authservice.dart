
import 'package:firebase_auth/firebase_auth.dart';
import 'package:logger/logger.dart';
// import 'package:flutter/material.dart';



class AuthService {

  final l = Logger();
 

  signOut() {
    FirebaseAuth.instance.signOut();
  }


  signIn(authCreds) {
    FirebaseAuth.instance.signInWithCredential(authCreds);
  }

  signInWithOTP(smsCode, verId) {
    l.e(smsCode);
    AuthCredential authCreds =
        PhoneAuthProvider.credential(verificationId: verId, smsCode: smsCode);
    signIn(authCreds);
   
  }
}
