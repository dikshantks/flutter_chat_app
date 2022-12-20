// ignore_for_file: camel_case_types

import 'dart:ffi';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_app/screens/login_screen.dart';
import 'package:flutter_chat_app/screens/registration_screen.dart';

import '../components/button_1.dart';

class WelcomeScreen extends StatefulWidget {
  static String id = "/welcome";
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;

  late Animation animation;

  @override
  void initState() {
    super.initState();

    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    animation = ColorTween(
            begin: Color.fromARGB(132, 204, 204, 204), end: Color(0x40CCCCCC))
        .animate(animationController);
    animationController.forward();

    animationController.addListener(() {
      setState(() {});
      print(animationController.value);
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose

    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: animation.value,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Hero(
                  tag: "logo",
                  child: Container(
                    child: Image.asset('assets/images/logo.png'),
                    height: 60.0,
                  ),
                ),
                AnimatedTextKit(
                  animatedTexts: [
                    TypewriterAnimatedText("Not",
                        textStyle: TextStyle(fontSize: 45.0)),
                    TypewriterAnimatedText("Chat GPT",
                        textStyle: TextStyle(fontSize: 45.0)),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 48.0,
            ),
            Buttons_1(
              text: "Log in ",
              color: Colors.lightBlueAccent,
              onclick: () {
                Navigator.pushNamed(context, LoginScreen.id);
              },
            ),
            Buttons_1(
              text: "Register",
              color: Colors.blueAccent,
              onclick: () {
                Navigator.pushNamed(context, RegistrationScreen.id);
              },
            ),
          ],
        ),
      ),
    );
  }
}
