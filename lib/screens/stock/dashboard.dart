import 'package:covid_19/common/botton_navigation_bar/bottom_navigation_bar_new.dart';
import 'package:covid_19/controllers/stock_vacine_controller.dart';
import 'package:covid_19/models/page_manager.dart';
import 'package:covid_19/screens/stock/addStock.dart';
import 'package:covid_19/screens/stock/elements/dashboard_chart.dart';
import 'package:covid_19/screens/stock/stock.dart';
import 'package:covid_19/utils/styles/style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class DashboardStock extends StatelessWidget {
  final PageController pageController = PageController();
  final PageManager pageManager = Get.put(PageManager());
  var _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 65),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Card(
                    child: Container(
                      width: 170,
                      height: 130,
                      child: Padding(
                        padding: const EdgeInsets.all(13),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Icon(
                                    Icons.inbox,
                                    color: Colors.green,
                                    size: 20,
                                  ),
                                  Text(
                                    'Entra de Vacinas',
                                    style: TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.green),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(10),
                              child: GetBuilder<StockVacineController>(
                                init: StockVacineController(),
                                builder: (controller) {
                                  return Text(
                                    controller.vaccines.length.toString(),
                                    style: TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.green),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Card(
                    child: Container(
                      width: 170,
                      height: 130,
                      child: Padding(
                        padding: const EdgeInsets.all(13),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Icon(
                                    Icons.inbox,
                                    color: Colors.redAccent,
                                    size: 20,
                                  ),
                                  Text(
                                    'Saida de Vacinas',
                                    style: TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.redAccent),
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(10),
                              child: Text(
                                '10000K',
                                style: TextStyle(
                                  fontSize: 25,
                                  color: kPrimaryColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Card(
                child: Container(
                  width: double.maxFinite,
                  child: DashboardChart(),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      Get.to(StockVacina());
                    },
                    icon: Icon(Icons.timeline),
                    label: Text('Estatisticas'),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      Get.to(AddVacina());
                    },
                    icon: Icon(Icons.add),
                    label: Text('Adicionar'),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBarNew(),
    );
  }
}
