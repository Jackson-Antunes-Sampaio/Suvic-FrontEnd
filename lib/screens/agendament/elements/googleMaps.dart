import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapAgendament extends StatefulWidget {
  @override
  _GoogleMapAgendamentState createState() => _GoogleMapAgendamentState();
}

class _GoogleMapAgendamentState extends State<GoogleMapAgendament> {
  static const _initialCameraPosition = CameraPosition(
    target: LatLng(-23.58088094022838, -46.620059397520336),
    zoom: 11.5,
  );

  //late GoogleMapController _googleMapController;
  Completer<GoogleMapController> _googleMapController = Completer();

  Marker? _origin;
  Marker? _distination;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        myLocationButtonEnabled: false,
        zoomControlsEnabled: false,
        initialCameraPosition: _initialCameraPosition,
        onMapCreated: (GoogleMapController controller) {
          _googleMapController.complete(controller);
        },
        markers: {
          if (_origin != null) _origin!,
          if (_distination != null) _distination!,
        },
        onLongPress: _addMarker,
      ),
    );
  }

  void _addMarker(LatLng position) {
    if (_origin == null || (_origin != null && _distination != null)) {
      setState(() {
        _origin = Marker(
          markerId: const MarkerId('origin'),
          infoWindow: const InfoWindow(title: 'Origin'),
          icon:
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
          position: position,
        );
        //Reset destitnation
        _distination = null;
      });
    } else {
      setState(() {
        _distination = Marker(
          markerId: const MarkerId('destination'),
          infoWindow: const InfoWindow(title: 'destination'),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
          position: position,
        );
      });
    }
  }
}
