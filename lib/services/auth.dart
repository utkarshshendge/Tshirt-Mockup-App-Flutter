import 'package:firebase_auth/firebase_auth.dart';
import 'package:EDI/models/user.dart';

class AuthService {
  FirebaseAuth _auth = FirebaseAuth.instance;
  User _userFromFirebase(FirebaseUser user) {
    return user != null ? User(uId: user.uid) : null;
  }

  Future signInWithEmail(String email, String password) async {
    try {
      AuthResult authResult = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser firebaseUser = authResult.user;
      return _userFromFirebase(firebaseUser);
    } catch (e) {
      print(e.toString());
    }
  }

  Future signUpWithEmailAndPass(String email, String password) async {
    try {
      AuthResult authResult = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser firebaseUser = authResult.user;
      return _userFromFirebase(firebaseUser);
    } catch (e) {
      print(e.toString());
    }
  }

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }
}
