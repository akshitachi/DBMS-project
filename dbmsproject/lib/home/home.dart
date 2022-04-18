// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors

import 'package:dbmsproject/database/database.dart';
import 'package:dbmsproject/home/user_tile.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0Xff02617d),
        title: Text(
          'Student Data',
        ),
        centerTitle: true,
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Expanded(
              child: FutureBuilder(
                  future: DataBaseService().getStudents(),
                  builder: (context, snapshot) {
                    if (snapshot.data != null) {
                      List userData = (snapshot.data) as List;
                      return ListView.builder(
                        itemCount: userData.length,
                        itemBuilder: (context, index) {
                          return UserTile(
                            userData: userData[index],
                          );
                        },
                      );
                    } else {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
