import 'package:covid_19/controllers/user_controller.dart';
import 'package:covid_19/routes/app_page.dart';
import 'package:covid_19/screens/agendament/agendam.dart';
import 'package:covid_19/screens/agendament/scheduled.dart';

import 'package:covid_19/screens/menu/components/header_menu.dart';
import 'package:covid_19/screens/stock/stock_new.dart';
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
            email: '${userController.user?.civilName ?? '-'}',
            offset: 0,
          ),
          TextButton(
              onPressed: (){
                Get.toNamed(Routes.PROFILE);
              },
              child: Text("Editar perfil"),
          ),
          Padding(
            padding: EdgeInsets.only(top: 20, left: 10, right: 10),
            child: Column(
              children: [
                userController.user?.permissionLevel == "Superadmin"
                ? Card(
                  elevation: 4,
                  child: ListTile(
                    leading: Icon(Icons.person_add_alt_1),
                    title: Text('Cadastrar Aplicador'),
                    trailing: Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      Get.toNamed(Routes.REGISTRATIONUSERS);
                    },
                  ),
                ) : Container(),
                // Card(
                //   elevation: 4,
                //   child: ListTile(
                //     leading: Icon(Icons.add_alert_rounded),
                //     title: Text('Avisa-me'),
                //     trailing: Icon(Icons.arrow_forward_ios),
                //     onTap: () {
                //       Get.toNamed(Routes.NOTIFYCOVID);
                //     },
                //   ),
                // ),
                userController.user?.permissionLevel == "Applicator" || userController.user?.permissionLevel == "Oversser" || userController.user?.permissionLevel == "Admin" || userController.user?.permissionLevel == "Superadmin"
                ? Card(
                  elevation: 4,
                  child: ListTile(
                    leading: Icon(Icons.schedule),
                    title: Text('Agendados'),
                    trailing: Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      Get.to(DuaAgendament());
                    },
                  ),
                ) : Container(),
                userController.user?.permissionLevel == "Oversser" || userController.user?.permissionLevel == "Admin" || userController.user?.permissionLevel == "Superadmin"
                ? Card(
                  elevation: 4,
                  child: ListTile(
                    leading: Icon(Icons.qr_code),
                    title: Text('Estoque'),
                    trailing: Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      // Get.toNamed(Routes.StockVacina);
                      Get.to(Stock());
                    },
                  ),
                ) : Container(),
                // Card(
                //   elevation: 4,
                //   child: ListTile(
                //     leading: Icon(Icons.credit_card_outlined),
                //     title: Text('Adicionar cartão de crédito'),
                //     trailing: Icon(Icons.arrow_forward_ios),
                //     onTap: () {
                //       Get.toNamed(Routes.PRODUCTCARD);
                //     },
                //   ),
                // ),
                userController.user?.permissionLevel == "Applicator" || userController.user?.permissionLevel == "Admin" || userController.user?.permissionLevel == "Superadmin"
                ? Card(
                  elevation: 4,
                  child: ListTile(
                    leading: Icon(Icons.article_outlined),
                    title: Text('Aplicar vacina'),
                    trailing: Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      Get.toNamed(Routes.APPLYVACCINE);
                    },
                  ),
                ) : Container(),
                userController.user?.permissionLevel == "Applicator" || userController.user?.permissionLevel == "Admin" || userController.user?.permissionLevel == "Superadmin" || userController.user?.permissionLevel == "Overseer"
                ? Card(
                  elevation: 4,
                  child: ListTile(
                    leading: Icon(Icons.history),
                    title: Text('Historico de vacinas aplicadas'),
                    trailing: Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      Get.toNamed(Routes.HISTORICVACCINE);
                    },
                  ),
                ) : Container(),
                Card(
                  elevation: 4,
                  child: ListTile(
                    leading: Icon(Icons.logout),
                    title: Text('Sair'),
                    trailing: Icon(Icons.arrow_forward_ios),
                    onTap: () async{
                      await userController.logout();
                      Get.offAllNamed(Routes.LOGIN);
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
