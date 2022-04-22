import 'dart:io';

import 'package:another_flushbar/flushbar.dart';
import 'package:suvic_app/common/botton_navigation_bar/bottom_navigation_bar_new.dart';
import 'package:suvic_app/controllers/credit_card_controller.dart';
import 'package:suvic_app/controllers/stock_vacine_controller.dart';
import 'package:suvic_app/models/page_manager.dart';
import 'package:suvic_app/screens/agendament/scheduling.dart';

import 'package:suvic_app/screens/home/home_screen_new.dart';

import 'package:suvic_app/screens/menu/menu_screen.dart';

import 'package:suvic_app/screens/vaccine_card/vaccine_card_screen.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class BaseScreen extends StatefulWidget {
  @override
  _BaseScreenState createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  final PageManager pageManager = Get.put(PageManager());
  final CreditCardController creditCardController =
      Get.put(CreditCardController());
  final StockVacineController stockVacineController =
      Get.put(StockVacineController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    configFCM();
  }

  void configFCM() async {
    final FirebaseMessaging messaging = FirebaseMessaging.instance;
    if (Platform.isIOS) {
      NotificationSettings settings = await messaging.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true,
      );
      print(
          'Permissão concedida pelo usuário: ${settings.authorizationStatus}');
    }
    messaging.getToken().then((value) {
      print("token: $value");
    });
  }

  void showNotification(String? title, String? message) {
    print("aquiiiiiiiiiiiiiiiiiiii");
    Flushbar(
      title: title,
      message: message,
      flushbarPosition: FlushbarPosition.TOP,
      flushbarStyle: FlushbarStyle.GROUNDED,
      isDismissible: true,
      backgroundColor: Theme.of(context).primaryColor,
      duration: Duration(seconds: 5),
      icon: Icon(
        Icons.shopping_cart,
        color: Colors.white,
      ),
    ).show(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: pageManager.pageController,
        children: [
          HomeScreenNew(),
          VaccineCardScreen(),
          Agendament(),
          MenuScreen(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBarNew(),
    );
  }
}
