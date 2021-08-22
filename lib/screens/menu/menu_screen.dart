import 'package:covid_19/controllers/user_controller.dart';
import 'package:covid_19/routes/app_page.dart';
import 'package:covid_19/screens/agendament/agendam.dart';

import 'package:covid_19/screens/menu/components/header_menu.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MenuScreen extends StatelessWidget {
  final UserController userController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          HeaderMenu(
            image: "assets/images/unnamed.png",
            email: '${userController.user?.socialName ?? '-'}',
            offset: 0,
          ),
          InkWell(
            onTap: () async {
              await userController.logout();
              Get.offAllNamed(Routes.LOGIN);
            },
            child: Padding(
              padding: EdgeInsets.only(right: 20),
              child: Align(
                alignment: Alignment.centerRight,
                child: Text(
                  "Sair",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
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
                    onTap: () {
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
                    onTap: () {
                      Get.toNamed(Routes.NOTIFYCOVID);
                    },
                  ),
                ),
                // Card(
                //   elevation: 4,
                //   child: ListTile(
                //     leading: Icon(Icons.add),
                //     title: Text('Estoque'),
                //     trailing: Icon(Icons.arrow_forward_ios),
                //     onTap: () {
                //       Get.toNamed(Routes.StockVacina);
                //     },
                //   ),
                // ),
                Card(
                  elevation: 4,
                  child: ListTile(
                    leading: Icon(Icons.qr_code),
                    title: Text('Estoque'),
                    trailing: Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      Get.toNamed(Routes.StockVacina);
                    },
                  ),
                ),
                Card(
                  elevation: 4,
                  child: ListTile(
                    leading: Icon(Icons.credit_card_outlined),
                    title: Text('Cartão de Credito'),
                    trailing: Icon(Icons.arrow_forward_ios),
                    onTap: () {

                      Get.toNamed(Routes.PRODUCTCARD);
                    },
                  ),
                ),
                Card(
                  elevation: 4,
                  child: ListTile(
                    leading: Icon(Icons.article_outlined),
                    title: Text('Aplicar Vacina'),
                    trailing: Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      Get.toNamed(Routes.APPLYVACCINE);
                    },
                  ),
                ),
                Card(
                  elevation: 4,
                  child: ListTile(
                    leading: Icon(Icons.history),
                    title: Text('Historico de vacinas'),
                    trailing: Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      Get.toNamed(Routes.HISTORICVACCINE);
                    },
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
