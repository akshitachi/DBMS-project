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
}
