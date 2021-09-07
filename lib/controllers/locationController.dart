// import 'dart:async';

// import 'package:covid_19/controllers/clinicController.dart';
// import 'package:covid_19/utils/styles/style.dart';
// import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:get/get.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';

// class LocationController extends GetxController {
//   final latitude = 0.0.obs;
//   final longitude = 0.0.obs;
//   late StreamSubscription<Position> positionStream;
//   final markers = Set<Marker>();

//   static LocationController get to => Get.find<LocationController>();

//   LatLng _initPosiion = LatLng(-23.58088094022838, -46.620059397520336);
//   LatLng get initPosiion => this._initPosiion;

//   late GoogleMapController _mapController;
//   GoogleMapController get mapController => this._mapController;

//   onMapCreated(GoogleMapController googleMapController) {
//     _mapController = googleMapController;
//     setClinicMarker();
//   }

//   setClinicMarker() async {
//     var clinic = ClinicController.to.clinic.value;

//     _mapController.animateCamera(
//         CameraUpdate.newLatLng(LatLng(clinic.latitude, clinic.longitude)));

//     markers.add(
//       Marker(
//         markerId: MarkerId(clinic.id.toString()),
//         position: LatLng(clinic.latitude, clinic.longitude),
//         icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
//       ),
//     );

//     update();
//   }

//   watchPosition() async {
//     positionStream = Geolocator.getPositionStream().listen((position) {
//       if (position.latitude != 0.0) {
//         latitude.value = position.latitude;
//         longitude.value = position.longitude;
//       }
//     });
//   }

//   @override
//   void onClose() {
//     positionStream.cancel();
//     super.onClose();
//   }

//   Future<Position> _currentPosition() async {
//     LocationPermission permission;
//     bool isActive = await Geolocator.isLocationServiceEnabled();

//     if (!isActive) {
//       return Future.error('Por favor, habilite a localização');
//     }

//     permission = await Geolocator.requestPermission();

//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();

//       if (permission == LocationPermission.denied) {
//         return Future.error('Você precisa autorizar o acesso à localização');
//       }
//     }

//     //Return corrent possition
//     return await Geolocator.getCurrentPosition();
//   }

//   getPosition() async {
//     try {
//       final position = await _currentPosition();
//       latitude.value = position.latitude;
//       longitude.value = position.longitude;
//     } catch (e) {
//       Get.snackbar(
//         'Erro',
//         e.toString(),
//         backgroundColor: kPrimaryColor,
//         colorText: Colors.white,
//         snackPosition: SnackPosition.BOTTOM,
//       );
//     }
//   }
// }
