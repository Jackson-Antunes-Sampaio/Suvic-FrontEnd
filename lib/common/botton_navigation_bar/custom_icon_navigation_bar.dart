import 'package:flutter/material.dart';

class CustomIconNavigationBar extends StatelessWidget {

  CustomIconNavigationBar(
      {this.text, this.iconData, this.color, this.onTap, this.size, });

  final String text;
  final IconData iconData;
  final Color color;
  final VoidCallback onTap;
  final double size;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(50),
      child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            child: Padding(
                padding: EdgeInsets.all(5),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      iconData,
                      color: onTap != null ? color : Colors.grey[400],
                      size: size ?? 24,
                    ),
                    Text(text, style: TextStyle(color: color, fontSize: 11),),
                  ],
                )
            ),
          )
      ),
    );
  }


}
