import 'package:covid_19/utils/styles/style.dart';
import 'package:flutter/material.dart';

class InputTextField extends StatelessWidget {

  InputTextField({@ required this.hintText, @ required this.obscureText});

  final String hintText;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      padding: EdgeInsets.fromLTRB(16, 3, 16, 6),
      margin: EdgeInsets.all(8),
      decoration: raisedDecoration,
      child: Center(
        child: TextField(
          obscureText: obscureText,
          decoration: InputDecoration(
              border: InputBorder.none,
              hintText: hintText,
              hintStyle: TextStyle(
                  color: Colors.black38
              )
          ),
        ),
      ),
    );
  }
}
