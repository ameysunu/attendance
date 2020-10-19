
import 'package:firebase_auth/firebase_auth.dart';

class AuthProvider {
  Future<void> login(String email,String password) async {
    UserCredential userCredential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    User user=  userCredential.user;
    return user;
  }
}
