import 'package:flutter/material.dart';

class Buttons_1 extends StatelessWidget {
  final String text;
  final VoidCallback onclick;
  final Color color;
  const Buttons_1(
      {Key? key,
      required this.color,
      required this.onclick,
      required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        elevation: 5.0,
        color: color,
        borderRadius: BorderRadius.circular(30.0),
        child: MaterialButton(
          onPressed: onclick,
          minWidth: 200.0,
          height: 42.0,
          child: Text(
            'Log In',
          ),
        ),
      ),
    );
  }
}
