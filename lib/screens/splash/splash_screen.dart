import 'package:another_flushbar/flushbar.dart';
import 'package:connectivity/connectivity.dart';
import 'package:covid_19/controllers/user_controller.dart';
import 'package:covid_19/routes/app_page.dart';
import 'package:covid_19/screens/home/home_screen.dart';
import 'package:covid_19/screens/login/login_screen.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreenApp extends StatelessWidget {
  final UserController userController = Get.find();

  SplashScreenApp() {
    userLogged();
  }

  void userLogged() async {
    await Future.delayed(Duration(seconds: 3));

    var connectivityResult = await (Connectivity().checkConnectivity());

    if (connectivityResult == ConnectivityResult.none) {
      Get.offNamed(Routes.CONNECT);
    } else {
      await userController.loginDate();

      if (userController.user?.email != null) {
        Get.offNamed(Routes.BASE);
      } else {
        Get.offNamed(Routes.LOGIN);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [Color(0xff011579b), Color(0xffe0f2f1)],
          )),
        ),
        Align(
          alignment: Alignment.center,
          child: Image.asset(
            "assets/images/suvictrans.png",
            //fit: BoxFit.cover,
          ),
        )
      ],
    );
  }
}

// class SplashScreenApp2 extends StatefulWidget {
//   @override
//   _SplashScreenApp2State createState() => _SplashScreenApp2State();
// }
//
// class _SplashScreenApp2State extends State<SplashScreenApp2> {
//   final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
//
//   _registerOnFirebase() {
//     _firebaseMessaging.subscribeToTopic('all');
//     _firebaseMessaging.getToken().then((token) => print(token));
//   }
//
//   @override
//   void initState() {
//     _registerOnFirebase();
//     getMessage();
//     super.initState();
//   }
//
//   void getMessage() {
//     _firebaseMessaging.configure(
//       onMessage: (Map<String, dynamic> message) async {
//         print('received message');
//         showNotification(
//           message["notification"]["title"] as String,
//           message["notification"]["body"] as String,
//         );
//       },
//       onResume: (Map<String, dynamic> message) async {
//         print('on resume $message');
//         //_message = message["notification"]["body"];
//       },
//       onLaunch: (Map<String, dynamic> message) async {
//         print('on launch $message');
//         //_message = message["notification"]["body"];
//       },
//     );
//   }
//
//   void showNotification(String title, String message) {
//     Flushbar(
//       title: title,
//       message: message,
//       flushbarPosition: FlushbarPosition.TOP,
//       flushbarStyle: FlushbarStyle.GROUNDED,
//       isDismissible: true,
//       backgroundColor: Colors.black54,
//       duration: Duration(seconds: 5),
//       icon: Icon(
//         Icons.event,
//         color: Colors.white,
//       ),
//     ).show(context);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: <Widget>[
//         SplashScreen(
//           seconds: 5,
//           gradientBackground: LinearGradient(
//             begin: Alignment.topRight,
//             end: Alignment.bottomLeft,
//             colors: [Color(0xff011579b), Color(0xffe0f2f1)],
//           ),
//           navigateAfterSeconds: LoginScreen(),
//           loaderColor: Colors.transparent,
//         ),
//         Center(
//           child: Container(
//             height: 200,
//             width: 400,
//             decoration: BoxDecoration(
//               //color: Colors.blueAccent,
//                 image: DecorationImage(
//                   image: AssetImage("assets/images/suvictrans.png"),
//                   alignment: Alignment.center,
//                   fit: BoxFit.cover,
//                 )),
//           ),
//         )
//       ],
//     );
//   }
// }
//
//
//
