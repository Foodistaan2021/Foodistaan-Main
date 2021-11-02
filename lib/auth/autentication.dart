import 'package:firebase_auth/firebase_auth.dart';

class AuthMethod {
  checkUserLogin() {
    if (FirebaseAuth.instance.currentUser!.phoneNumber != null) {
      return FirebaseAuth.instance.currentUser!.phoneNumber;
    }
    return null;
  }
}
