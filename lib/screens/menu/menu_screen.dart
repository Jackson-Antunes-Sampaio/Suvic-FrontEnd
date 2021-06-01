import 'package:covid_19/controllers/user_controller.dart';
import 'package:covid_19/models/user_model.dart';
import 'package:covid_19/routes/app_page.dart';
import 'package:covid_19/screens/menu/components/header_menu.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class MenuScreen extends StatelessWidget {

  final UserController userController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          HeaderMenu(
            image: "assets/images/unnamed.png",
            email: '${userController.user!.email}',
            offset: 0,
          ),
          Padding(
            padding: EdgeInsets.only(top: 20, left: 10, right: 10),
            child: Column(
              children: [
                Card(
                  elevation: 4,
                  child: ListTile(
                    leading: Icon(Icons.person_add_alt_1),
                    title: Text('Cadastrar Aplicador'),
                    trailing: Icon(Icons.arrow_forward_ios),
                    onTap: (){
                      Get.toNamed(Routes.REGISTRATIONUSERS);
                    },
                  ),
                ),
                Card(
                  elevation: 4,
                  child: ListTile(
                    leading: Icon(Icons.add_alert_rounded),
                    title: Text('Avisa-me'),
                    trailing: Icon(Icons.arrow_forward_ios),
                    onTap: (){
                      Get.toNamed(Routes.NOTIFYCOVID);
                    },
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
