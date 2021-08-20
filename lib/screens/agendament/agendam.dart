import 'package:covid_19/controllers/agendamentController.dart';
import 'package:covid_19/utils/styles/style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Agendam extends StatefulWidget {
  const Agendam({Key? key}) : super(key: key);

  @override
  _AgendamState createState() => _AgendamState();
}

class _AgendamState extends State<Agendam> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: GetBuilder<AgentamentController>(
          init: AgentamentController(),
          builder: (controller) => GoogleMap(
            mapType: MapType.terrain,
            zoomControlsEnabled: false,
            initialCameraPosition: CameraPosition(
              target: controller.position,
              zoom: 13,
            ),
            onMapCreated: controller.onMapCreated,
            myLocationEnabled: true,
            mapToolbarEnabled: false,
            markers: controller.markers,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: kPrimaryColor,
        onPressed: () {},
        child: Icon(
          Icons.search,
        ),
      ),
    );
  }
}
