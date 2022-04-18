import 'package:firebase_auth/firebase_auth.dart';

import '../global.dart';

class DataBaseService {
  FirebaseAuth auth = FirebaseAuth.instance;
  var user = FirebaseAuth.instance.currentUser;

  Future<bool> checkUserDocExists() async {
    var result = await database
        .child('Users')
        .child(user!.uid)
        .get()
        .then((data) => data.value);
    print('%%%%%%%%%%%%$result');
    if (result != null) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> getUserExistence(String username) async {
    var result = await database
        .child('Users')
        .orderByChild('username')
        .equalTo(username)
        .get()
        .then((data) => data.value);
    if (result != null) {
      return true;
    } else {
      return false;
    }
  }

  Future<List> getStudents() async {
    List userData = [];
    var result = await database.child('Users').get().then((data) => data.value);
    (result as Map).forEach((key, value) {
      userData.add(value);
    });
    return userData;
  }

  Future getUserDetails(String uid) async {
    var result = await database
        .child('Users')
        .child(uid)
        .get()
        .then((data) => data.value);
    return result;
  }
}
