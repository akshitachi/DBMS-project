// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables, must_be_immutable
import 'dart:io';
import 'package:dbmsproject/global.dart';
import 'package:dbmsproject/home/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class EnterBioScreen extends StatefulWidget {
  EnterBioScreen(
      {Key? key,
      @required this.name,
      @required this.username,
      @required this.birthDate})
      : super(key: key);
  String? name;
  String? username;
  String? birthDate;
  @override
  _EnterBioScreenState createState() => _EnterBioScreenState();
}

class _EnterBioScreenState extends State<EnterBioScreen> {
  final _formKey = GlobalKey<FormState>();
  File? image;
  bool pressAttention = true;
  final textEditingController = TextEditingController();

  _imgFromCamera() async {
    try {
      final imageTemp = await ImagePicker()
          .pickImage(source: ImageSource.camera, imageQuality: 50);
      final imageTemporary = File(imageTemp!.path);
      setState(() {
        image = imageTemporary;
      });
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  _imgFromGallery() async {
    try {
      final imageTemp = await ImagePicker()
          .pickImage(source: ImageSource.gallery, imageQuality: 50);
      final imageTemporary = File(imageTemp!.path);
      setState(() {
        image = imageTemporary;
      });
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  void _showPicker(context) {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        context: context,
        builder: (BuildContext bc) {
          return Wrap(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
                child: ListTile(
                  title: Text(
                    'Edit profile picture',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
                child: ListTile(
                  title: Text(
                    'Take photo using camera',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  onTap: () {
                    _imgFromCamera();
                    Navigator.of(context).pop();
                  },
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
                child: ListTile(
                    title: Text(
                      'Use photo using gallery',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    onTap: () {
                      _imgFromGallery();
                      Navigator.of(context).pop();
                    }),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
              ),
              Text('   ')
            ],
          );
        });
  }

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
                  'Almost Done!',
                  style: TextStyle(fontSize: 28),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                ),
                InkWell(
                  onTap: () {
                    _showPicker(context);
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(
                        MediaQuery.of(context).size.width * 0.3),
                    child: image != null
                        ? Image.file(
                            image!,
                            height: MediaQuery.of(context).size.height * 0.18,
                            width: MediaQuery.of(context).size.height * 0.18,
                            fit: BoxFit.cover,
                          )
                        : Container(
                            color: Colors.grey,
                            height: MediaQuery.of(context).size.height * 0.18,
                            width: MediaQuery.of(context).size.height * 0.18,
                          ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03,
                ),
                Text(
                  widget.username!,
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03,
                ),
                Text(
                  widget.name!,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03,
                ),
                Text(
                  'Bio',
                  style: TextStyle(color: Colors.grey, fontSize: 16),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.7,
                  child: Form(
                    key: _formKey,
                    child: TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your bio';
                        }
                      },
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(180),
                      ],
                      controller: textEditingController,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(0),
                        hintText: 'Tap to add something...',
                        hintStyle: TextStyle(
                            color: Colors.grey,
                            fontStyle: FontStyle.italic,
                            fontSize: 17),
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
                    backgroundColor: Color(0Xff02617d),
                  ),
                  child: Text(
                    'Continue',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                  onPressed: () async {
                    bool isValid = _formKey.currentState!.validate();
                    if (image == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Please pick an image.'),
                          backgroundColor: Colors.black,
                        ),
                      );
                      return;
                    }
                    if (isValid) {
                      setState(() {
                        pressAttention = !pressAttention;
                      });
                      var user = FirebaseAuth.instance.currentUser;
                      final ref = FirebaseStorage.instance
                          .ref()
                          .child('user_images')
                          .child(user!.uid)
                          .child(user.uid + '.jpg');
                      await ref.putFile(image!).whenComplete(() {
                        print('UPLOADED TO STORAGE');
                      });
                      final url = await ref.getDownloadURL();
                      Map<String, dynamic> map = {
                        'username': widget.username,
                        'bio': textEditingController.text,
                        'name': widget.name,
                        'birthDate': widget.birthDate,
                        'registrationTimestamp': ServerValue.timestamp,
                        'uid': user.uid,
                        'image_url': url,
                      };
                      await database
                          .child('Users')
                          .child(user.uid)
                          .set(map)
                          .then(
                        (value) {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => HomePage()),
                          );
                        },
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ));
  }
}
