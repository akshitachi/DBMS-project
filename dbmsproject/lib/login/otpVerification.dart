import 'dart:async';
import 'package:dbmsproject/login/otp.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:firebase_auth/firebase_auth.dart';

class OtpVerification extends StatefulWidget {
  final String? verID;
  final String? phoneNumber;
  OtpVerification({@required this.verID, @required this.phoneNumber});
  @override
  _OtpVerificationState createState() => _OtpVerificationState();
}

class _OtpVerificationState extends State<OtpVerification> {
  String? phoneNumber;
  TextEditingController textEditingController = TextEditingController();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();
  int? timer;
  bool visiblity = true;
  bool hasError = false;
  String otpString = "";
  bool? loading;
  @override
  void initState() {
    super.initState();
    loading = false;
    timer = 60;
    WidgetsBinding.instance!.addPostFrameCallback(startTimer);
  }

  void startTimer(timestamp) {
    timer = 60;
    Timer.periodic(Duration(seconds: 1), (time) {
      if (!mounted) return;

      setState(() {
        timer = timer! - 1;
      });
      if (timer == 0) {
        time.cancel();
      }
    });
  }

  double? screenHeight, screenWidth;
  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    String verificationId = widget.verID!;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Spacer(),
              Image.asset(
                'assets/logo.png',
                height: MediaQuery.of(context).size.height * 0.15,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              ),
              const Text(
                'Sales',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 35,
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 55.0),
                child: otpFields(context, verificationId),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              ),
              Builder(
                builder: (context) {
                  return Center(
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        text: "",
                        style: const TextStyle(
                          decoration: TextDecoration.underline,
                          color: Colors.black,
                          fontSize: 15,
                        ),
                        children: [
                          TextSpan(
                            text: "Resend OTP",
                            style: TextStyle(
                              fontSize: 15,
                              color: timer != 0 ? Colors.black : Colors.black,
                              fontWeight: timer != 0
                                  ? FontWeight.w500
                                  : FontWeight.w800,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () async {
                                if (timer == 0) {
                                  setState(() {
                                    loading = true;
                                  });
                                  await OTPService().sendOTP(
                                    widget.phoneNumber!,
                                    context,
                                    true,
                                    startLoading: () {
                                      setState(() {
                                        loading = true;
                                      });
                                    },
                                    stopLoading: () {
                                      setState(() {
                                        loading = false;
                                      });
                                    },
                                  );
                                }
                              },
                          ),
                          timer != 0
                              ? TextSpan(
                                  text: " in $timer seconds",
                                  style: const TextStyle(
                                    // fontFamily: kFont1,
                                    color: Colors.black,
                                  ),
                                )
                              : TextSpan(),
                        ],
                      ),
                    ),
                  );
                },
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.04,
              ),
              TextButton(
                style: TextButton.styleFrom(
                  primary: Colors.white,
                  minimumSize: Size(MediaQuery.of(context).size.width * 0.7,
                      MediaQuery.of(context).size.height * 0.06),
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12.0)),
                  ),
                  backgroundColor: Color(0Xff02617d),
                ),
                child: const Text(
                  'Verify OTP',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
                onPressed: () async {
                  final PhoneAuthCredential credential =
                      PhoneAuthProvider.credential(
                    verificationId: verificationId,
                    smsCode: otpString,
                  );

                  await OTPService().signInWithCred(credential, context);
                },
              ),
              const Spacer(),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Builder otpFields(BuildContext context, String verificationID) {
    return Builder(builder: (context) {
      return PinCodeTextField(
        obscureText: !visiblity,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        appContext: context,
        pastedTextStyle: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
        length: 6,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,

        animationType: AnimationType.scale,
        autoFocus: true,
        validator: (v) {
          return null;
        },
        cursorColor: Colors.black,
        animationDuration: Duration(milliseconds: 300),
        textStyle: TextStyle(
          fontSize: 18,
          height: 1.6,
          color: Colors.black,
        ),
        backgroundColor: Colors.transparent,
        // errorAnimationController: errorController,
        controller: textEditingController,
        keyboardType: TextInputType.number,

        pinTheme: PinTheme(
          fieldHeight: MediaQuery.of(context).size.width * 0.11,
          fieldWidth: MediaQuery.of(context).size.width * 0.11,
          shape: PinCodeFieldShape.box,
          borderRadius: BorderRadius.circular(10),
          activeColor: Color(0Xff02617d),
          selectedColor: Color(0Xff02617d),
          inactiveColor: Color.fromARGB(255, 202, 202, 202),
        ),
        onCompleted: (v) async {
          setState(() {
            loading = true;
          });
          final PhoneAuthCredential credential = PhoneAuthProvider.credential(
            verificationId: verificationID,
            smsCode: otpString,
          );

          await OTPService().signInWithCred(credential, context);
        },
        onChanged: (value) {
          setState(() {
            otpString = value;
          });
        },
        beforeTextPaste: (text) {
          print("Allowing to paste $text");
          return false;
        },
      );
    });
  }
}
