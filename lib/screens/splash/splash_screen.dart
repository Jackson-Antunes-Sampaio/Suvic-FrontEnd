
import 'package:another_flushbar/flushbar.dart';
import 'package:covid_19/screens/home/home_screen.dart';
import 'package:covid_19/screens/login/login_screen.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';

class SplashScreenApp extends StatefulWidget {
  @override
  _SplashScreenAppState createState() => _SplashScreenAppState();
}

class _SplashScreenAppState extends State<SplashScreenApp> {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();


  _registerOnFirebase() {
    _firebaseMessaging.subscribeToTopic('all');
    _firebaseMessaging.getToken().then((token) => print(token));
  }

  @override
  void initState() {
    _registerOnFirebase();
    getMessage();
    super.initState();
  }

  void getMessage() {
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print('received message');
        showNotification(
          message["notification"]["title"] as String,
          message["notification"]["body"] as String,
        );

      },
      onResume: (Map<String, dynamic> message) async {
        print('on resume $message');
        //_message = message["notification"]["body"];
      },
      onLaunch: (Map<String, dynamic> message) async {
        print('on launch $message');
        //_message = message["notification"]["body"];
      },
    );
  }

  void showNotification(String title, String message){
    Flushbar(
      title: title,
      message: message,
      flushbarPosition: FlushbarPosition.TOP,
      flushbarStyle: FlushbarStyle.GROUNDED,
      isDismissible: true,
      backgroundColor: Colors.black54,
      duration: Duration(seconds: 5),
      icon: Icon(Icons.event, color: Colors.white,),
    ).show(context);

  }


  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        SplashScreen(
          seconds: 5,
          gradientBackground: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Color(0xff011579b),
              Color(0xffe0f2f1)
            ],
          ),
          navigateAfterSeconds: LoginScreen(),
          loaderColor: Colors.transparent,
        ),
        Center(
          child: Container(
            height: 200,
            width: 400,
            decoration: BoxDecoration(
              //color: Colors.blueAccent,
                image: DecorationImage(
                  image: AssetImage("assets/images/suvictrans.png"),
                  alignment: Alignment.center,
                  fit: BoxFit.cover,
                )),
          ),
        )
      ],
    );
  }
}


