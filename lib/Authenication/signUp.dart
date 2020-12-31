import 'package:EDI/Authenication/signIn.dart';
import 'package:EDI/DialogBox/errordialog.dart';
import 'package:EDI/Store/storehome.dart';
import 'package:EDI/config/config.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:ecomapp/DialogBox/errorDialog.dart';
//import 'package:ecomapp/Store/storehome.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

//import 'package:EDI/Config/config.dart';
import 'package:EDI/Widgets/customTextField.dart';

class AuthenticScreen extends StatefulWidget {
  @override
  _AuthenticScreenState createState() => _AuthenticScreenState();
}

class _AuthenticScreenState extends State<AuthenticScreen> {
  final TextEditingController _nameTextEditingController =
      TextEditingController();
  final TextEditingController _emailTextEditingController =
      TextEditingController();
  final TextEditingController _passwordTextEditingController =
      TextEditingController();
  final TextEditingController _cpasswordTextEditingController =
      TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Container(
              height: MediaQuery.of(context).size.height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "SignUp",
                        style: TextStyle(fontSize: 30, color: Colors.white),
                      )
                    ],
                  ),
                  SizedBox(height: 40),
                  Form(
                      key: _formkey,
                      child: Column(
                        children: [
                          TextFormField(
                            controller: _nameTextEditingController,
                            validator: (value) {
                              return value.isEmpty
                                  ? "Please Enter Your Name"
                                  : null;
                            },
                            decoration: InputDecoration(
                                labelText: "Name",
                                suffixIcon: Icon(
                                  Icons.person,
                                )),
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          TextFormField(
                            controller: _emailTextEditingController,
                            validator: (value) {
                              return value.isEmpty
                                  ? "Please Enter Your E-mail Id"
                                  : null;
                            },
                            decoration: InputDecoration(
                                labelText: "Email",
                                suffixIcon: Icon(
                                  Icons.email,
                                )),
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          TextFormField(
                            obscureText: true,
                            controller: _passwordTextEditingController,
                            validator: (value) {
                              return value.isEmpty
                                  ? "Please Enter Password"
                                  : null;
                            },
                            decoration: InputDecoration(
                                labelText: "Password",
                                suffixIcon: Icon(
                                  Icons.security,
                                )),
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          TextFormField(
                            obscureText: true,
                            controller: _cpasswordTextEditingController,
                            validator: (value) {
                              return value.isEmpty ? "Re-enter Password" : null;
                            },
                            decoration: InputDecoration(
                                labelText: "Confirm Password",
                                suffixIcon: Icon(
                                  Icons.person,
                                )),
                          ),
                        ],
                      )),
                  SizedBox(height: 20),
                  RaisedButton(
                    onPressed: UploadData,
                    elevation: 10.0,
                    color: Colors.greenAccent,
                    child: Text(
                      'Sign Up',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0)),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Already Have An Account?",
                        style: TextStyle(color: Color(0xff9B9BAF)),
                      ),
                      GestureDetector(
                          onTap: () {
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (context) => SignInPage()));
                          },
                          child: Text(
                            " SignIn",
                            style: TextStyle(color: Colors.green),
                          ))
                    ],
                  ),
                  SizedBox(
                    height: 50,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  FirebaseAuth _auth = FirebaseAuth.instance;
  void UploadData() async {
    FirebaseUser firebaseUser;

    await _auth
        .createUserWithEmailAndPassword(
      email: _emailTextEditingController.text.trim(),
      password: _passwordTextEditingController.text.trim(),
    )
        .then((auth) {
      firebaseUser = auth.user;
    }).catchError((error) {
      Navigator.pop(context);
      showDialog(
          context: context,
          builder: (c) {
            return ErrorAlertDialog(message: error.message.toString());
          });
    });

    if (firebaseUser != null) {
      saveinfoFirestore(firebaseUser);
      Route route = MaterialPageRoute(builder: (c) => StoreHome());
      Navigator.pushReplacement(context, route);
    }
  }

  Future saveinfoFirestore(FirebaseUser firebaseUser) {
    Firestore.instance.collection('users').document(firebaseUser.uid).setData({
      "uid": firebaseUser.uid,
      "email": firebaseUser.email,
      "name": _nameTextEditingController.text.trim(),
      EDIapp.userCartList: ["garbagevalue"]
    });

    EDIapp.sharedPreferences.setString("uid", firebaseUser.uid);
    EDIapp.sharedPreferences.setString("email", firebaseUser.email);
    EDIapp.sharedPreferences
        .setString("name", _nameTextEditingController.text.trim());
    EDIapp.sharedPreferences
        .setStringList(EDIapp.userCartList, ["garbageValue"]);
  }
}
