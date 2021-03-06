import 'package:flutter/material.dart';

// Colors
const kBackgroundColor = Color(0xFFFEFEFE);
const kTitleTextColor = Color(0xFF303030);
const kBodyTextColor = Color(0xFF4B4B4B);
const kTextLightColor = Color(0xFF959595);
const kInfectedColor = Color(0xFFFF8748);
const kDeathColor = Color(0xFFFF4848);
const kRecovercolor = Color(0xFF36C12C);
const kPrimaryColor = Color(0xFF3382CC);
final kShadowColor = Color(0xFFB7B7B7).withOpacity(.16);
final kActiveShadowColor = Color(0xFF4056C6).withOpacity(.15);
Color facebookColor = Color(0xFF416BC1);
Color googleColor = Color(0xFFCF4333);
Color twitterColor = Color(0xFF08A0E9);
Color instagramColor= Color(0xFF3f729b);
Color youTubeColor= Color(0xFFc4302b);

//Material Color
Map<int, Color> colorKPrimaryColor = {
  50: Color.fromRGBO(51, 130, 204, .1),
  100: Color.fromRGBO(51, 130, 204, .2),
  200: Color.fromRGBO(51, 130, 204, .3),
  300: Color.fromRGBO(51, 130, 204, .4),
  400: Color.fromRGBO(51, 130, 204, .5),
  500: Color.fromRGBO(51, 130, 204, .6),
  600: Color.fromRGBO(51, 130, 204, .7),
  700: Color.fromRGBO(51, 130, 204, .8),
  800: Color.fromRGBO(51, 130, 204, .9),
  900: Color.fromRGBO(51, 130, 204, 1),
};

MaterialColor mtrKPrimaryColor = MaterialColor(0xFF3382CC, colorKPrimaryColor);

// Text Style
const kHeadingTextStyle = TextStyle(
  fontSize: 22,
  fontWeight: FontWeight.w600,
);

const kSubTextStyle = TextStyle(fontSize: 16, color: kTextLightColor);

const kTitleTextstyle = TextStyle(
  fontSize: 18,
  color: kTitleTextColor,
  fontWeight: FontWeight.bold,
);

var raisedDecoration = BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(16),
    border: Border.all(
      color: Colors.grey[50]!,
    ),
    boxShadow: [
      BoxShadow(
        color: Colors.black26,
        offset: Offset(5, 2),
        blurRadius: 3.0,
        spreadRadius: 0.0,
      ),
      BoxShadow(
        color: Colors.white,
        offset: Offset(-5, -2),
        blurRadius: 3.0,
        spreadRadius: 0.0,
      ),
    ]);
