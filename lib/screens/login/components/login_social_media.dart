import 'package:flutter/material.dart';

class LoginSocialMediaBtn extends StatelessWidget {

  LoginSocialMediaBtn({required this.icon, required this.color});

  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return SizedBox.fromSize(
      size: Size(54,54),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Material(
          elevation: 16,
          shadowColor: Colors.black,
          color: color,
          child: InkWell(
            splashColor: Colors.white12,
            onTap: (){},
            child: Center(
              child: Icon(icon,color: Colors.white, size: 24,),
            ),
          ),
        ),
      ),
    );
  }
}
