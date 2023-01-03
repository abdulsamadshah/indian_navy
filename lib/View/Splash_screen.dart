import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter/material.dart';

import '../Resources/Routes/RoutesName.dart';

class Splash_screen extends StatefulWidget {
  const Splash_screen({Key? key}) : super(key: key);

  @override
  State<Splash_screen> createState() => _Splash_screenState();
}

class _Splash_screenState extends State<Splash_screen> {
  @override
  void initState() {
    // TODO: implement initState
    Timer(Duration(seconds: 3), () async {
      Navigator.pushNamed(context, RoutesName.Login_screen);
      SharedPreferences sp = await SharedPreferences.getInstance();
      String? email = sp.getString("email");
      String? password = sp.getString("password");

      if (email == null ||
          email == '' ||
          email.isEmpty ||
          password == null ||
          password == '' ||
          password.isEmpty) {
        Navigator.pushNamed(context, RoutesName.Login_screen);
      } else {
        Navigator.pushNamed(context, RoutesName.homescreen);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          "assets/images/indiannavilogo.png",
          height: 200,
          width: 250,
        ),
      ),
    );
  }
}
