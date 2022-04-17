import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

var dbpath = FirebaseDatabase.instanceFor(
    app: Firebase.app(),
    databaseURL:
    "https://dbms-project-62596-default-rtdb.firebaseio.com/");