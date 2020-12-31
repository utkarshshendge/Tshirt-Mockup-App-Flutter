import 'dart:async';
import 'package:EDI/Authenication/signIn.dart';
import 'package:EDI/Store/storehome.dart';
import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'HomePage.dart';
import 'constants.dart';
import 'package:EDI/config/config.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  EDIapp.auth = FirebaseAuth.instance;
  EDIapp.sharedPreferences = await SharedPreferences.getInstance();
  EDIapp.firestore = await Firestore.instance;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ThemeProvider(
      initTheme: kDarkTheme,
      child: Builder(
        builder: (context) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeProvider.of(context),
            home: SplashScreen(),
          );
        },
      ),
    );

    // return MultiProvider(

    //   child: MaterialApp(
    //       title: 'e-Shop',
    //       debugShowCheckedModeBanner: false,
    //       theme: CustomTheme().buildTheme(),
    //       home: SplashScreen()),
    // );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    displaysplash();
  }

  displaysplash() {
    Timer(Duration(seconds: 4), () async {
      if (await EDIapp.auth.currentUser() != null) {
        Route route = MaterialPageRoute(builder: (_) => HomePage());
        Navigator.pushReplacement(context, route);
      } else {
        Route route = MaterialPageRoute(builder: (_) => SignInPage());
        Navigator.pushReplacement(context, route);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
