import 'package:covid_19/controllers/agendamentController.dart';
import 'package:covid_19/controllers/clinicController.dart';
import 'package:covid_19/screens/agendament/schedule.dart';
import 'package:covid_19/utils/styles/style.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class DuaAgendament extends StatefulWidget {
  const DuaAgendament({Key? key}) : super(key: key);

  @override
  _DuaAgendamentState createState() => _DuaAgendamentState();
}

class _DuaAgendamentState extends State<DuaAgendament> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: 0,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 50,
          automaticallyImplyLeading: false,
          backgroundColor: kPrimaryColor,
          bottom: TabBar(indicatorColor: Colors.white, tabs: [
            Tab(icon: Icon(Icons.map)),
            Tab(icon: Icon(Icons.list)),
          ]),
        ),
        body: TabBarView(
          children: [
            mapClinics(),
            listClinics(),
          ],
        ),
      ),
    );
  }

  Widget listClinics() {
    return Center(
      child: Column(
        children: [
          Expanded(
            child: Container(
              width: double.maxFinite,
              height: double.maxFinite,
              child: GetBuilder<ClinicController>(
                init: ClinicController(),
                builder: (controller) {
                  var clinics = controller.clinics;
                  return controller.loading
                      ? Center(
                          child: Container(
                            width: 50,
                            height: 50,
                            child: CircularProgressIndicator(),
                          ),
                        )
                      : ListView.builder(
                          itemCount: controller.clinics.length,
                          itemBuilder: (context, index) {
                            return Card(
                              child: ListTile(
                                onTap: () => Get.to(
                                  Schedule(
                                    clinic: clinics[index].id.toString(),
                                  ),
                                ),
                                leading:
                                    FaIcon(FontAwesomeIcons.hospitalSymbol),
                                title: Text(clinics[index].name ?? ''),
                                subtitle: Text(clinics[index].address ?? ''),
                              ),
                            );
                          },
                        );
                },
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget mapClinics() {
    return Center(
      child: Text('data'),
    );
  }
}
