import 'dart:async';

import 'package:covid_19/controllers/locationController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapAgendament extends StatefulWidget {
  @override
  _GoogleMapAgendamentState createState() => _GoogleMapAgendamentState();
}

class _GoogleMapAgendamentState extends State<GoogleMapAgendament> {
  LocationController locationController = Get.put(LocationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<LocationController>(
        builder: (controler) => GoogleMap(
          mapType: MapType.normal,
          initialCameraPosition: CameraPosition(
            target: controler.initPosiion,
            zoom: 11.5,
          ),
          onMapCreated: controler.onMapCreated,
          myLocationEnabled: false,
          zoomControlsEnabled: false,
          markers: controler.markers,
        ),
      ),
    );
  }
}
