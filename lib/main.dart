import 'package:covid_19/routes/app_page.dart';
import 'package:covid_19/styles/constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';




void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Suvic',
      theme: ThemeData(
          scaffoldBackgroundColor: kBackgroundColor,
          fontFamily: "Poppins",
          textTheme: TextTheme(
            body1: TextStyle(color: kBodyTextColor),
          )),
      //home: HomePage(),
      initialRoute: AppPage.INITIAL,
      //initialBinding: AppBindings(),
      getPages: AppPage.routes,
    );
  }
}


// void main() => runApp(MyApp());
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Material App',
//       home: HomePage(),
//     );
//   }
// }
//
//
// class HomePage extends StatefulWidget {
//   HomePage({Key key}) : super(key: key);
//
//   @override
//   _HomePageState createState() => _HomePageState();
// }
//
// class _HomePageState extends State<HomePage> {
//   final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
//   String _message = '';
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
//         onMessage: (Map<String, dynamic> message) async {
//           print('received message');
//          _message = message["notification"]["body"];
//           showNotification(
//             message["notification"]["title"] as String,
//             message["notification"]["body"] as String,
//           );
//
//         },
//         onResume: (Map<String, dynamic> message) async {
//           print('on resume $message');
//           _message = message["notification"]["body"];
//         },
//         onLaunch: (Map<String, dynamic> message) async {
//           print('on launch $message');
//           _message = message["notification"]["body"];
//         },
//         );
//   }
//
//   void showNotification(String title, String message){
//     Flushbar(
//       title: title,
//       message: message,
//       flushbarPosition: FlushbarPosition.TOP,
//       flushbarStyle: FlushbarStyle.GROUNDED,
//       isDismissible: true,
//       backgroundColor: Colors.black54,
//       duration: Duration(seconds: 5),
//       icon: Icon(Icons.event, color: Colors.white,),
//     ).show(context);
//
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Push Notifications Test'),
//       ),
//       body: Container(
//           child: Center(
//             child: Text("Message: $_message"),
//           )),
//     );
//   }
// }
//
