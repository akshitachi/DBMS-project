import 'package:dbmsproject/login/registration/enterName.dart';
import 'package:dbmsproject/login/otpVerification.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../database/database.dart';

class OTPService {
  FirebaseAuth auth = FirebaseAuth.instance;
  Future<void> signInWithCred(
      PhoneAuthCredential authCred,
      BuildContext context,
      ) async {
    try {
      print("authcred: " + authCred.toString());
      final UserCredential userCredential =
      await auth.signInWithCredential(authCred);
      print("user uid" + userCredential.user!.uid.toString());
      bool isExists = await DataBaseService().checkUserDocExists();
      if (isExists) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => EnterName()),
                (route) => false);
      } else {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => EnterName(),
            ),
                (route) => false);
      }
    } catch (e) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => EnterName(),
          ),
              (route) => false);
      return;
    }
    return;
  }

  Future sendOTP(
      String phoneNumber,
      BuildContext context,
      bool toReplaceCurrentScreen, {
        required Function startLoading,
        required Function stopLoading,
      }) async {
    await auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      timeout: Duration(seconds: 30),
      verificationCompleted: (PhoneAuthCredential authCred) async {
        await signInWithCred(authCred, context);
      },
      verificationFailed: (FirebaseAuthException exception) {
        stopLoading();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          duration: Duration(seconds: 2),
          content: Text("Oops! Unexpected Error occured. Please Try again."),
        ));
        print("exception ${exception.code} \nmessage\n${exception.message}");
      },
      codeSent: (String verificationID, int? resendToken) {
        print("code sent callback replace: $toReplaceCurrentScreen");
        if (stopLoading != null) {
          stopLoading();
        }
        print("after stop loading");
        if (toReplaceCurrentScreen) {
          print("replacing otp page");
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => OtpVerification(
                    verID: verificationID,
                    phoneNumber: phoneNumber,
                  )));
        } else {
          print("pushing to otp page");
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => OtpVerification(
                    verID: verificationID,
                    phoneNumber: phoneNumber,
                  )));
        }
      },
      codeAutoRetrievalTimeout: (String verificationID) {
        //do nothing
        print("time out");
      },
    );
  }
}