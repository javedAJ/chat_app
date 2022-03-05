import 'dart:async';

import 'package:chat_app/screens/auth_screen.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/colors.dart' as color;

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    Timer(
        Duration(seconds: 3),
        () => Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: ((context) => AuthScreen()),
              ),
            ));
    return Scaffold(
      backgroundColor: color.AppColor.red,
      body: const Center(
        child: Text("Loading..."),
      ),
    );
  }
}
