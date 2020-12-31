//import 'package:ecomapp/Admin/adminLogin.dart';
import 'package:EDI/Authenication/signUp.dart';
import 'package:EDI/Widgets/custombutton.dart';
import 'package:EDI/services/auth.dart';
import 'package:EDI/store/storehome.dart';
import 'package:EDI/helper/functions.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  String email, password;
  AuthService authService = new AuthService();
  signIn() async {
    if (_formKey.currentState.validate()) {
      setState(() {
        _isLoading = true;
      });
      authService.signInWithEmail(email, password).then((value) {
        if (value != null) {
          setState(() {
            _isLoading = false;
          });

          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => StoreHome()));
          HelperFunctions.setUserLoginDetails(isLoggedIn: true);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading
          ? Container(child: Center(child: CircularProgressIndicator()))
          : SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Padding(
                  padding: EdgeInsets.all(15),
                  child: Container(
                      height: 600,
                      //margin: EdgeInsets.symmetric(horizontal: 30),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Spacer(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                "Login",
                                style: TextStyle(
                                    fontSize: 30, color: Colors.white),
                              )
                            ],
                          ),
                          SizedBox(height: 50),
                          TextFormField(
                            validator: (value) {
                              return value.isEmpty ? "Plsse enter Email" : null;
                            },
                            inputFormatters: [
                              FilteringTextInputFormatter.deny(
                                  new RegExp(r"\s\b|\b\s"))
                            ],
                            decoration: InputDecoration(
                                hintText: "Email",
                                suffixIcon: Icon(
                                  Icons.email,
                                  color: Color(0xff9B9BAF),
                                )),
                            onChanged: (value) {
                              email = value;
                            },
                          ),
                          SizedBox(height: 40),
                          TextFormField(
                            validator: (value) {
                              return value.isEmpty
                                  ? "Plsse enter PAssword"
                                  : null;
                            },
                            inputFormatters: [
                              FilteringTextInputFormatter.deny(
                                  new RegExp(r"\s\b|\b\s"))
                            ],
                            decoration: InputDecoration(
                                hintText: "Password",
                                suffixIcon: Icon(
                                  Icons.enhanced_encryption,
                                  color: Color(0xff9B9BAF),
                                )),
                            onChanged: (value) {
                              password = value;
                            },
                          ),
                          SizedBox(height: 50),
                          GestureDetector(
                            onTap: () {
                              signIn();
                            },
                            child: customButton(label: 'LOGIN'),
                          ),
                          SizedBox(height: 25),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                "Dont Have An Account?",
                                style: TextStyle(color: Color(0xff9B9BAF)),
                              ),
                              GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                AuthenticScreen()));
                                  },
                                  child: Text(
                                    " SIGNUP",
                                    style: TextStyle(color: Colors.green),
                                  ))
                            ],
                          ),
                          SizedBox(height: 30)
                        ],
                      )),
                ),
              ),
            ),
    );
  }
}
