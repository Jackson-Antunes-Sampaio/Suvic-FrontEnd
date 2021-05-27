import 'package:covid_19/controllers/stock_vacine_controller.dart';
import 'package:covid_19/routes/app_page.dart';
import 'package:covid_19/utils/styles/style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

import 'bindings/app_bindings.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final StockVacineController stockVacineController =
      Get.put(StockVacineController());

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Suvic',
      theme: ThemeData(
          scaffoldBackgroundColor: kBackgroundColor,
          //scaffoldBackgroundColor: const Color.fromARGB(255,241,241,255),
          fontFamily: "Poppins",
          textTheme: TextTheme(
            body1: TextStyle(color: kBodyTextColor),
          )),
      //home: HomePage(),
      initialRoute: AppPage.INITIAL,
      initialBinding: AppBindings(),
      //initialBinding: AppBindings(),
      getPages: AppPage.routes,
    );
  }
}
