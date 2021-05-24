import 'package:covid_19/routes/app_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class MenuScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: 20),
        child: Column(
          children: [
            Icon(Icons.person, size: 100,),
            Text("Jackson Antunes Sampaio"),
            Divider(),
            ListTile(
              leading: Icon(Icons.person_add_alt_1),
              title: Text('Cadastrar Operadores'),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: (){
                Get.toNamed(Routes.REGISTRATIONUSERS);
              },
            )
          ],
        ),
      ),
    );
  }
}
