import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Login",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Container(
        width: 100,
        height: 100,
        padding: EdgeInsets.all(100),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                    child: Row(
                  children: [
                    Text(
                      "User",
                      style: TextStyle(color: Colors.black),
                    ),
                    Text(
                      "Password",
                      style: TextStyle(color: Colors.black),
                    )
                  ],
                ))
              ],
            )
          ],
        ),
      ),
    );
  }
}
