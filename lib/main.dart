import 'package:flutter/material.dart';
import 'package:flutter_chat_app/screens/welcome_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return WelcomeScreen();
  }
}