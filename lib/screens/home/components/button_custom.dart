import 'package:flutter/material.dart';

class ButtonCustom extends StatelessWidget {

  final String text;
  final VoidCallback navigation;
  final IconData icon;
  final Color color;

  ButtonCustom({required this.text, required this.navigation, required this.icon, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey,
                  blurRadius: 10.0,
                  offset: Offset(2.0, 2.0))
            ]),
        width: 150,
        height: 150,
        child: RaisedButton(
          onPressed: navigation,
          color: color,
          child: Row(
            mainAxisAlignment:
            MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "$text",
                style: TextStyle(color: Colors.white70),
              ),
              Icon(
                icon,
                size: 30,
                color: Colors.white70,
              )
            ],
          ),
        ));
  }
}
