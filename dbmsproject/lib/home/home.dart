import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(90.0),
        child: Container(
          child: Text('Successfully logged in',style: TextStyle(color: Colors.black,fontSize: 20),)
        ),
      ),
    );
  }
}