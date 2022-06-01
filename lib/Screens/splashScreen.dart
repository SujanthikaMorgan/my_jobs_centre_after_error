// ignore_for_file: file_names, prefer_const_constructors

import 'dart:async';

import 'package:flutter/material.dart';

import 'Sign_In.dart';

class SplashScreenPage extends StatefulWidget {
  static const String idScreen = "splashScreenPage";
  const SplashScreenPage({Key? key}) : super(key: key);

  @override
  _SplashScreenPageState createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  @override
  void initState() {
    super.initState();
    Timer(
      Duration(seconds: 3),
      () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SignIn(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Image(
        image: AssetImage("assets/images/logo.png"),
      )),
    );
  }
}
