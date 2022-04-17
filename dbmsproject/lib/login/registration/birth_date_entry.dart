// ignore_for_file: prefer_const_constructors
import 'package:dbmsproject/custom_page_route.dart';
import 'package:dbmsproject/login/registration/enter_bio_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EnterBirthDate extends StatefulWidget {
  // ignore: prefer_const_constructors_in_immutables
  EnterBirthDate({Key? key, @required this.name, @required this.username})
      : super(key: key);
  String? name;
  String? username;
  @override
  _EnterBirthDateState createState() => _EnterBirthDateState();
}

class _EnterBirthDateState extends State<EnterBirthDate> {
  final _formKey = GlobalKey<FormState>();
  DateTime? _dateTime;
  bool pressAttention = true;
  final texteditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.1,
              ),
              Text(
                'Nice to meet you,',
                style: TextStyle(fontSize: 28),
              ),
              Text(
                widget.name!.split(' ')[0],
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.start,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.25,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30.0),
                child: Text(
                  'When is your birthday?',
                  style: TextStyle(fontSize: 18),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.7,
                child: Form(
                  key: _formKey,
                  child: TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please select your birth date';
                      }
                    },
                    controller: texteditingController,
                    decoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(0xffFFCA0D)),
                      ),
                    ),
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                    ),
                    onTap: () {
                      showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1990),
                        lastDate: DateTime.now(),
                      ).then((date) {
                        setState(() {
                          _dateTime = date!;
                          var suffix = "th";
                          var digit = date.day % 10;
                          if ((digit > 0 && digit < 4) &&
                              (date.day < 11 || date.day > 13)) {
                            suffix = ["st", "nd", "rd"][digit - 1];
                          }
                          String formattedDate =
                              DateFormat("d'$suffix' MMMM, yyyy")
                                  .format(_dateTime!);
                          print(formattedDate);
                          texteditingController.text = formattedDate;
                        });
                      });
                    },
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.07,
              ),
              TextButton(
                style: TextButton.styleFrom(
                  primary: Colors.white,
                  // minimumSize: Size(MediaQuery.of(context).size.width * 0.7, MediaQuery.of(context).size.height * 0.06),
                  minimumSize:
                      Size(MediaQuery.of(context).size.width * 0.7, 40),
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12.0)),
                  ),
                  backgroundColor: Colors.amber,
                ),
                child: Text(
                  'Continue',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                  ),
                ),
                onPressed: () {
                  bool isValid = _formKey.currentState!.validate();
                  if (isValid) {
                    setState(() {
                      pressAttention = !pressAttention;
                    });
                    Navigator.of(context).pushReplacement(
                      CustomPageRoute(
                          child: EnterBioScreen(
                        name: widget.name,
                        username: widget.username,
                        birthDate: texteditingController.text,
                      )),
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
