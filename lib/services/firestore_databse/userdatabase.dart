import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserDataFirestore {
  Future<String> UserId() async {
    final FirebaseUser user = await FirebaseAuth.instance.currentUser();
    final String uid = user.uid.toString();
    return uid;
  }

  Future<void> addUserDataFirestore(Map userData) async {
    String uid;
    uid = await UserId();

    Firestore.instance
        .collection("Users")
        .document(uid)
        .setData(userData)
        .catchError((e) {
      print(e);
    });
  }

  Future<void> retriveUserDataFirestore() async {
    String uid;
    uid = await UserId();

   Future<DocumentSnapshot> retrivedDocument= Firestore.instance
        .collection("Users")
        .document(uid)
        .get()
        .catchError((e) {
      print(e);
    });
  }
}
