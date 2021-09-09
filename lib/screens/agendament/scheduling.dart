import 'package:covid_19/controllers/agendamentController.dart';
import 'package:covid_19/controllers/clinicController.dart';
import 'package:covid_19/screens/agendament/schedule.dart';
import 'package:covid_19/utils/styles/style.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Agendament extends StatefulWidget {
  const Agendament({Key? key}) : super(key: key);

  @override
  _AgendamentState createState() => _AgendamentState();
}

class _AgendamentState extends State<Agendament> {
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
          physics: NeverScrollableScrollPhysics(),
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
                      : clinics.length == 0
                          ? Center(
                              child: Text('Nenhuma clínica disponível'),
                            )
                          : ListView.builder(
                              itemCount: controller.clinics.length,
                              itemBuilder: (context, index) {
                                return Card(
                                  child: ListTile(
                                    onTap: () => Get.to(
                                      Schedule(
                                        clinic: clinics[index],
                                      ),
                                    ),
                                    leading: FaIcon(
                                      FontAwesomeIcons.hospitalSymbol,
                                      color: kPrimaryColor,
                                    ),
                                    title: Text(clinics[index].name ?? ''),
                                    subtitle:
                                        Text(clinics[index].address ?? ''),
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
    return GetBuilder<AgentamentController>(
      init: AgentamentController(),
      builder: (controller) => GoogleMap(
        mapType: MapType.normal,
        zoomControlsEnabled: true,
        initialCameraPosition: CameraPosition(
          target: controller.position,
          zoom: 13,
        ),
        onMapCreated: controller.onMapCreated,
        myLocationEnabled: true,
        mapToolbarEnabled: true,
        markers: controller.markers,
      ),
    );
  }
}
