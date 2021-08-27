import 'package:covid_19/common/icon_button_custom.dart';
import 'package:covid_19/controllers/historic_vaccine_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'components/card_historic_vaccine.dart';

class HistoricVaccineScreen extends StatefulWidget {
  const HistoricVaccineScreen({Key? key}) : super(key: key);

  @override
  _HistoricVaccineScreenState createState() => _HistoricVaccineScreenState();
}

class _HistoricVaccineScreenState extends State<HistoricVaccineScreen> {
  final HistoricVaccineController historicVaccineController =
      Get.put(HistoricVaccineController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    historicVaccineController.getHistoricVaccine();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Historico de vacinas"),
      ),
      body: Obx(() {
        switch (historicVaccineController.stateHistoric.value) {
          case StateHistoric.IDLE:
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      child: Container(
                        height: 45,
                        child: TextField(
                          decoration: InputDecoration(
                            isDense: true,
                            prefixIcon: IconButtonCustom(
                              iconData: Icons.search,
                            ),
                            hintText: "Buscar",
                            hintStyle: TextStyle(color: Colors.grey),
                            border: OutlineInputBorder(
                              borderRadius: const BorderRadius.all(
                                const Radius.circular(10.0),
                              ),
                            ),
                          ),
                          onChanged: historicVaccineController.filter,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ListView.builder(
                        shrinkWrap: true,
                        physics: new NeverScrollableScrollPhysics(),
                        itemCount: historicVaccineController.listFilterHistoric.length,
                        itemBuilder: (build, index) {
                          String applicationDate = historicVaccineController.listFilterHistoric[index].applicationDate ?? "2021-08-24";
                          if(applicationDate == "2021-8-24"){
                            applicationDate = "2021-08-24";
                          }
                          return CardHistoricVaccine(
                            applicationDate: applicationDate,
                            doseNumber: historicVaccineController
                                .listFilterHistoric[index].doseNumber ?? 0,
                            user: historicVaccineController
                                .listFilterHistoric[index].user!,
                            vaccineName: historicVaccineController
                                .listFilterHistoric[index].vaccineName!,
                          );
                        })
                  ],
                ),
              ),
            );
            break;
          case StateHistoric.LOADING:
            return Center(
              child: CircularProgressIndicator(),
            );
            break;
        }
      }),
    );
  }
}
