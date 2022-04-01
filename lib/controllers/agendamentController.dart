import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:suvic_app/models/Clinic_model.dart';
import 'package:suvic_app/repositories/clinicRepository.dart';
import 'package:suvic_app/screens/agendament/schedule.dart';

class AgentamentController extends GetxController {
  final clinicsRepository = ClinicRepository();
  final latitude = 0.0.obs;
  final longitude = 0.0.obs;
  final raio = 0.0.obs;

  LatLng _position = LatLng(-23.571505, -46.689104);

  late GoogleMapController _mapsController;
  final markers = Set<Marker>();

  static AgentamentController get to => Get.find<AgentamentController>();
  get mapsController => _mapsController;
  get position => _position;
  String get distancia => raio.value < 1
      ? '${(raio.value * 1000).toStringAsFixed(0)} m'
      : '${(raio.value).toStringAsFixed(1)} km';

  onMapCreated(GoogleMapController gmc) async {
    _mapsController = gmc;
    getPosicao();
    loadClinics();
  }

  loadClinics() async {
    var clinicsList = await clinicsRepository.getAllClinis();

    clinicsList!.forEach((clinic) => addMarker(clinic));
  }

  addMarker(ClinicModel clinic) async {
    markers.add(
      Marker(
        markerId: MarkerId(clinic.id.toString()),
        position: LatLng(clinic.latitude!, clinic.longitude!),
        infoWindow: InfoWindow(title: clinic.name),
        icon: await BitmapDescriptor.fromAssetImage(
          ImageConfiguration(),
          'assets/images/hospital128px.png',
        ),
        onTap: () => showDetails(clinic),
      ),
    );
    update();
  }

  showDetails(ClinicModel clinic) {
    Get.to(Schedule(clinic: clinic));
  }

  Future<Position> _posicaoAtual() async {
    LocationPermission permissao;
    bool ativado = await Geolocator.isLocationServiceEnabled();

    if (!ativado) {
      return Future.error('Por favor, habilite a localização no smartphone.');
    }

    permissao = await Geolocator.checkPermission();
    if (permissao == LocationPermission.denied) {
      permissao = await Geolocator.requestPermission();

      if (permissao == LocationPermission.denied) {
        return Future.error('Você precisa autorizar o acesso à localização.');
      }
    }

    if (permissao == LocationPermission.deniedForever) {
      return Future.error('Autorize o acesso à localização nas configurações.');
    }

    return await Geolocator.getCurrentPosition();
  }

  getPosicao() async {
    try {
      final posicao = await _posicaoAtual();
      latitude.value = posicao.latitude;
      longitude.value = posicao.longitude;
      _mapsController.animateCamera(
          CameraUpdate.newLatLng(LatLng(latitude.value, longitude.value)));
    } catch (e) {
      Get.snackbar(
        'Erro',
        e.toString(),
        backgroundColor: Colors.grey[900],
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}
