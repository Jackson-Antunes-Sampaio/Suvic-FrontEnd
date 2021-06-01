import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';

class ButtonCustom extends StatelessWidget {
  ButtonCustom({required this.onPressed, required this.title});

  final Callback onPressed;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: RaisedButton(
        onPressed: onPressed,
        child: Text(
          "$title",
          style: TextStyle(fontSize: 16),
        ),
        color: Color(0xff303f9f),
        textColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
    );
  }
}
