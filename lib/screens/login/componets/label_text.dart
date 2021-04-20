import 'package:flutter/material.dart';

class labelText extends StatelessWidget {

  labelText(this.title);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: 24),
      child: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 16,
          color: Colors.black
        ),
      ),
    );
  }
}
