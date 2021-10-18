import 'package:suvic_app/utils/styles/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InputTextField extends StatelessWidget {

  InputTextField({required this.hintText, required this.obscureText, this.controller, this.textInputFormatter, this.textInputType});

  final String hintText;
  final bool obscureText;
  final TextEditingController? controller;
  final List<TextInputFormatter>? textInputFormatter;
  final TextInputType? textInputType;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      padding: EdgeInsets.fromLTRB(16, 3, 16, 6),
      margin: EdgeInsets.all(8),
      decoration: raisedDecoration,
      child: Center(
        child: TextField(
          inputFormatters: textInputFormatter,
          keyboardType: textInputType,
          controller: controller,
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
