// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:dbmsproject/database/database.dart';
import 'package:dbmsproject/global.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({
    Key? key,
    required this.uid,
  }) : super(key: key);
  final uid;

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return FutureBuilder(
        future: DataBaseService().getUserDetails(widget.uid),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var userData = snapshot.data;
            var userName = (userData as Map)['username'];
            var name = userData['name'];
            var bio = (userData)['bio'];
            var imageUrl = (userData)['image_url'];
            var birthdate = userData['birthDate'];
            return Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                elevation: 0,
                centerTitle: true,
                leading: InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Icon(
                    Icons.arrow_back_ios_outlined,
                    color: Colors.black,
                  ),
                ),
                backgroundColor: Colors.white,
                title: Text(
                  userName,
                  style: TextStyle(
                      fontSize: 21,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
              ),
              body: Container(
                padding: EdgeInsets.only(top: 10, right: 20, left: 20),
                child: Column(
                  children: [
                    Row(
                      children: [
                        imageUrl == null || imageUrl == ''
                            ? CircleAvatar(
                                backgroundColor: Colors.grey,
                                maxRadius:
                                    MediaQuery.of(context).size.width * 0.12,
                              )
                            : CircleAvatar(
                                maxRadius:
                                    MediaQuery.of(context).size.width * 0.12,
                                backgroundImage: NetworkImage(
                                  imageUrl,
                                ),
                              ),
                        SizedBox(
                          width: 25,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              name,
                              style: TextStyle(
                                fontSize: 24,
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.55,
                              child: Text(
                                bio,
                                maxLines: 3,
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.calendar_month_outlined,
                                  size: 20,
                                  color: Colors.black,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  birthdate,
                                  style:
                                      TextStyle(fontSize: 18, color: subFont),
                                ),
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),
            );
          } else {
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        });
  }
}
