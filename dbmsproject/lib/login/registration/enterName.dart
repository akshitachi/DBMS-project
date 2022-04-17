// ignore_for_file: prefer_const_constructors

import 'package:dbmsproject/custom_page_route.dart';
import 'package:dbmsproject/login/registration/registration_page.dart';
import 'package:flutter/material.dart';

class EnterName extends StatefulWidget {
  EnterName({Key? key}) : super(key: key);
  @override
  _EnterNameState createState() => _EnterNameState();
}

class _EnterNameState extends State<EnterName> {
  final _formKey = GlobalKey<FormState>();
  bool pressAttention = true;
  final textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.1,
              ),
              Text(
                'Let\'s setup your profile',
                style: TextStyle(fontSize: 28),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.25,
              ),
              Text(
                'What\'s your name?',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.7,
                child: Form(
                  key: _formKey,
                  child: TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your name';
                      }
                    },
                    controller: textEditingController,
                    decoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0Xff02617d),
                        ),
                      ),
                    ),
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.07,
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
                  'Continue',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
                onPressed: () async {
                  var isValid = _formKey.currentState!.validate();
                  if (isValid) {
                    setState(() {
                      pressAttention = !pressAttention;
                    });
                  }
                   Navigator.of(context).pushReplacement(
                      CustomPageRoute(
                        child: RegistrationScreen(
                          name: textEditingController.text,
                        ),
                      ),
                    );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
