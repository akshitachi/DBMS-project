// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:country_code_picker/country_code_picker.dart';
import 'package:dbmsproject/login/otp.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);
  @override
  LoginPageState createState() => LoginPageState();
}

// GlobalKey<LoginPageState> loginPageKey = GlobalKey<LoginPageState>();

class LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late bool loading;
  bool isLogin = false;

  @override
  void initState() {
    super.initState();
    loading = false;
  }

  @override
  Widget build(BuildContext context) {
    String phoneNumber = "";
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          children: [
            Spacer(),
            Image.asset(
              'assets/logo.png',
              height: MediaQuery.of(context).size.height * 0.15,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.01,
            ),
            Text(
              'Student Data',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 44,
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.03,
            ),
            isLogin
                ? Text(
                    'Please enter your number to continue.',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 20,
                    ),
                  )
                : SizedBox(),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            isLogin
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CountryCodePicker(
                        padding: EdgeInsets.zero,
                        textStyle: TextStyle(
                          fontSize: 24,
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                        ),
                        onChanged: print,
                        initialSelection: 'IN',
                        favorite: ['+91', 'IN'],
                        showCountryOnly: false,
                        showDropDownButton: false,
                        textOverflow: TextOverflow.fade,
                        showOnlyCountryWhenClosed: false,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.45,
                        child: Form(
                          key: _formKey,
                          child: TextFormField(
                            style: TextStyle(
                              fontSize: 24,
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                            ),
                            keyboardType: TextInputType.phone,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            onChanged: (val) {
                              phoneNumber = val;
                            },
                          ),
                        ),
                      ),
                    ],
                  )
                : SizedBox(),
            isLogin
                ? SizedBox(
                    height: MediaQuery.of(context).size.height * 0.07,
                  )
                : SizedBox(
                    height: MediaQuery.of(context).size.height * 0.15,
                  ),
            MaterialButton(
              height: MediaQuery.of(context).size.height * 0.06,
              minWidth: MediaQuery.of(context).size.width * 0.7,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0)),
              color: Color(0Xff02617d),
              child: Text(
                isLogin ? 'Continue' : 'Get Started',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
              onPressed: () async {
                if (isLogin) {
                  if (phoneNumber.length == 10) {
                    _formKey.currentState!.save();
                    setState(() {
                      loading = true;
                    });
                    await OTPService().sendOTP(
                        "+91$phoneNumber", context, false, startLoading: () {
                      setState(() {
                        loading = true;
                      });
                    }, stopLoading: () {
                      setState(() {
                        loading = false;
                      });
                    });
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      duration: Duration(seconds: 1),
                      backgroundColor: Colors.blue,
                      content: Text(
                        "Please enter a valid number.",
                        textAlign: TextAlign.left,
                      ),
                    ));
                  }
                } else {
                  setState(() {
                    isLogin = true;
                  });
                }
              },
            ),
            Spacer(),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.01,
            ),
          ],
        ),
      ),
    );
  }
}
