import 'dart:ui';

import 'package:covid_19/common/botton_navigation_bar/bottom_navigation_bar_new.dart';
import 'package:covid_19/controllers/stock_vacine_controller.dart';
import 'package:covid_19/models/page_manager.dart';
import 'package:covid_19/models/stock_vacine_model.dart';
import 'package:covid_19/screens/stock/elements/chart.dart';
import 'package:covid_19/utils/styles/style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class StockVacina extends StatelessWidget {
  PageController pageController = PageController();
  PageManager pageManager = Get.put(PageManager());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                'Stock de Vacinas',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
              chartStock(context),
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: TextFormField(
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    labelText: 'Pesquisar vacinas',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Container(
                height: 368,
                child: GetBuilder<StockVacineController>(builder: (controller) {
                  List<StockVacineModel> vaccines = controller.vaccines;

                  return vaccines.length <= 0
                      ? Text('Sem dados!')
                      // : showVacines();
                      : showVaccinesInstock(vaccines);
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  ListView showVaccinesInstock(List<StockVacineModel> vaccines) {
    return ListView.builder(
        itemCount: vaccines.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(1),
            child: Container(
              padding: EdgeInsets.all(0),
              decoration: BoxDecoration(
                border: Border.all(
                  width: 2,
                  color: kPrimaryColor.withOpacity(0.55),
                ),
                borderRadius: const BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              child: ListTile(
                onTap: () {},
                minVerticalPadding: 0,
                leading: Icon(
                  Icons.medical_services,
                  color: kPrimaryColor,
                ),
                title: Text(vaccines[index].name),
                subtitle: Text(vaccines[index].lote.toString()),
                trailing: Icon(Icons.assignment_ind),
              ),
            ),
          );
        });
  }

  ListView showVacines() {
    return ListView(
      padding: EdgeInsets.all(1),
      children: [
        Container(
          padding: EdgeInsets.all(0),
          decoration: BoxDecoration(
            border: Border.all(
              width: 2,
              color: kPrimaryColor.withOpacity(0.55),
            ),
            borderRadius: const BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          child: ListTile(
            onTap: () {},
            minVerticalPadding: 0,
            leading: Icon(
              Icons.medical_services,
              color: kPrimaryColor,
            ),
            title: Text('Vacina'),
            subtitle: Text('Lote: +1000k'),
            trailing: Icon(Icons.assignment_ind),
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 16),
          padding: EdgeInsets.all(0),
          decoration: BoxDecoration(
            border: Border.all(
              width: 2,
              color: kPrimaryColor.withOpacity(0.55),
            ),
            borderRadius: const BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          child: ListTile(
            onTap: () {},
            minVerticalPadding: 0,
            leading: Icon(
              Icons.medical_services,
              color: Color(0xFF26E5FF),
            ),
            title: Text('Vacina'),
            subtitle: Text('Lote: +1000k'),
            trailing: Icon(Icons.assignment_ind),
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 16),
          padding: EdgeInsets.all(0),
          decoration: BoxDecoration(
            border: Border.all(
              width: 2,
              color: kPrimaryColor.withOpacity(0.55),
            ),
            borderRadius: const BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          child: ListTile(
            onTap: () {},
            minVerticalPadding: 0,
            leading: Icon(
              Icons.medical_services,
              color: Color(0xFFFFCF26),
            ),
            title: Text('Vacina'),
            subtitle: Text('Lote: +1000k'),
            trailing: Icon(Icons.assignment_ind),
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 16),
          padding: EdgeInsets.all(0),
          decoration: BoxDecoration(
            border: Border.all(
              width: 2,
              color: kPrimaryColor.withOpacity(0.55),
            ),
            borderRadius: const BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          child: ListTile(
            onTap: () {},
            minVerticalPadding: 0,
            leading: Icon(
              Icons.medical_services,
              color: Color(0xFFEE2727),
            ),
            title: Text('Vacina'),
            subtitle: Text('Lote: +1000k'),
            trailing: Icon(Icons.assignment_ind),
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 16),
          padding: EdgeInsets.all(0),
          decoration: BoxDecoration(
            border: Border.all(
              width: 2,
              color: kPrimaryColor.withOpacity(0.55),
            ),
            borderRadius: const BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          child: ListTile(
            onTap: () {},
            minVerticalPadding: 0,
            leading: Icon(
              Icons.medical_services,
              color: kPrimaryColor.withOpacity(0.1),
            ),
            title: Text('Vacina'),
            subtitle: Text('Lote: +1000k'),
            trailing: Icon(Icons.assignment_ind),
          ),
        ),
      ],
    );
  }
}
