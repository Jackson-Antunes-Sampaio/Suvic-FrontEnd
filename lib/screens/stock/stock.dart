import 'dart:ui';

import 'package:covid_19/common/botton_navigation_bar/bottom_navigation_bar_new.dart';
import 'package:covid_19/models/page_manager.dart';
import 'package:covid_19/screens/stock/pages/agendament.dart';
import 'package:covid_19/utils/styles/style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../elements/chart.dart';

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
                child: ListView(
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
                        onTap: () {
                          Get.to(Agendament());
                        },
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
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBarNew(pageController),
    );
  }
}
