import 'package:dbmsproject/providers/sharedPrefs.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'dbpath.dart';
import 'login/authchecker.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final sharedPrefs = await SharedPreferences.getInstance();
  await Firebase.initializeApp();

  dbpath.setPersistenceEnabled(true);

  runApp(ProviderScope(overrides: [
    sharedPrefsProvider.overrideWithValue(sharedPrefs),
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Student Data',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      debugShowCheckedModeBanner: false,
      home: AuthChecker(),
    );
  }
}
