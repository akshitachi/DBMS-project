// ignore_for_file: prefer_const_constructors
import 'package:dbmsproject/custom_page_route.dart';
import 'package:dbmsproject/database/database.dart';
import 'package:dbmsproject/login/registration/birth_date_entry.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RegistrationScreen extends StatefulWidget {
  RegistrationScreen({Key? key, @required this.name}) : super(key: key);
  String? name;

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  FirebaseAuth auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  String? message;
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
                height: MediaQuery.of(context).size.height * 0.15,
              ),
              Text(
                'Please enter your Registration number',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.1,
                    vertical: MediaQuery.of(context).size.height * 0.04),
                child: Row(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.03,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.6,
                      child: Form(
                        key: _formKey,
                        child: TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter you registration number';
                            }
                          },
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(15),
                          ],
                          controller: textEditingController,
                          decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Color(0Xff02617d)),
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
                  ],
                ),
              ),
              message == '' || message == null
                  ? SizedBox()
                  : Text(
                      message!,
                      style: TextStyle(
                        color: Colors.red,
                        fontStyle: FontStyle.italic,
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.center,
                    ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 30.0),
                child: Text(
                  'This registration no. is how people can search you!!!',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
              TextButton(
                style: TextButton.styleFrom(
                  primary: Colors.white,
                  // minimumSize: Size(MediaQuery.of(context).size.width * 0.7, MediaQuery.of(context).size.height * 0.06),
                  minimumSize:
                      Size(MediaQuery.of(context).size.width * 0.7, 40),
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12.0)),
                  ),
                  backgroundColor: Color(0Xff02617d),
                ),
                child: Text(
                  'Continue',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
                onPressed: () {
                  bool isValid = _formKey.currentState!.validate();
                  if (isValid) {
                    Navigator.of(context).pushReplacement(
                      CustomPageRoute(
                        child: EnterBirthDate(
                          name: widget.name,
                          username: textEditingController.text,
                        ),
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
