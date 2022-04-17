// ignore_for_file: prefer_const_constructors, curly_braces_in_flow_control_structures
import 'package:dbmsproject/login/registration/enterName.dart';
import 'package:dbmsproject/login/login.dart';
import 'package:dbmsproject/providers/authProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:developer' as developer;
import '../global.dart';
import '../home/home.dart';

class AuthChecker extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final _authState = watch(authStateProvider);
    return
      _authState.when(
        data: (value) {
          developer.log('value', name: value.toString());
          if (value != null) {
            return FutureBuilder(
              future:
              database.child('Users').child(value.uid).child('name').get(),
              builder: (context, AsyncSnapshot<dynamic> snapshot) {
                if (snapshot.connectionState == ConnectionState.done &&
                    snapshot.hasData) {
                  if (snapshot.data.value != null) {
                    return HomePage();
                  } else {
                    print("Enter name");
                    return EnterName();
                  }
                } else if (snapshot.hasError) {
                  print('Error : $snapshot.hasError');
                  return CircularProgressIndicator(
                    color: Colors.white,
                  );
                } else {
                  return Scaffold(
                    body: Center(
                      child: CircularProgressIndicator(
                        color: Colors.amber,
                      ),
                    ),
                  );
                }
              },
            );
          }
          return LoginPage();
        },
        loading: () {
          return Scaffold(
            body: CircularProgressIndicator(
              color: Colors.amber,
            ),
          );
        },
        error: (e, _s) {
          print(e);
          return Container();
        },
      );
  }
}