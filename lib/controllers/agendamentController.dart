import 'dart:async';
import 'package:covid_19/repositories/clinicRepository.dart';
import 'package:covid_19/screens/agendament/selectVacines.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AgentamentController extends GetxController {
  final clinicsRepository = ClinicRepository();
  final latitude = 0.0.obs;
  final longitude = 0.0.obs;
  final raio = 0.0.obs;

  // late StreamSubscription<Position> positionStream;
  // LatLng _position = LatLng(-23.571505, -46.689104);
  LatLng _position = LatLng(-30.0557, -51.1988);
  late GoogleMapController _mapsController;
  final markers = Set<Marker>();

  static AgentamentController get to => Get.find<AgentamentController>();
  get mapsController => _mapsController;
  get position => _position;
  String get distancia => raio.value < 1
      ? '${(raio.value * 1000).toStringAsFixed(0)} m'
      : '${(raio.value).toStringAsFixed(1)} km';

  // filtrarclinics() {
  //   final geo = Geoflutterfire();
  //   final db = DB.get();

  //   GeoFirePoint center = geo.point(
  //     latitude: latitude.value,
  //     longitude: longitude.value,
  //   );

  //   CollectionReference ref = db.collection('clinics');

  //   String field = 'position';

  //   Stream<List<DocumentSnapshot>> stream = geo
  //       .collection(collectionRef: ref)
  //       .within(center: center, radius: raio.value, field: field);

  //   stream.listen((List<DocumentSnapshot> clinics) {
  //     markers.clear();
  //     clinics.forEach((clinic) {
  //       addMarker(clinic);
  //       update();
  //     });
  //     Get.back();
  //   });
  // }

  onMapCreated(GoogleMapController gmc) async {
    _mapsController = gmc;
    // getPosicao();
    loadClinics();
    // var style = await rootBundle.loadString('assets/map/light.json');
    // _mapsController.setMapStyle(style);
    // var style = await rootBundle.loadString('assets/map/light.json');
    // _mapsController.setMapStyle(style);
  }

  loadClinics() async {
    var clinicsList = await clinicsRepository.getAllClinis();

    var clinics = [];

    clinicsList!.forEach((element) {
      clinics.add({
        'id': element.id.toString(),
        'name': element.name.toString(),
        'icon': 'assets/images/hospital128px.png',
        'position': {
          'latitude': element.latitude,
          'longitude': element.longitude
        }
      });

      print('latitude:' + element.latitude.toString());
      print('longitude:' + element.longitude.toString());
    });
    // final clinics = [
    //   {
    //     'id': '2',
    //     'name': 'Clinica Gira SOl',
    //     'icon': 'assets/images/clinic60.png',
    //     'position': {'latitude': -23.569030, 'longitude': -46.684490}
    //   },
    //   {
    //     'id': '3',
    //     'name': 'Clinica SOl do Brasil',
    //     'icon': 'assets/images/sus60.png',
    //     'position': {'latitude': -23.557411, 'longitude': -46.690906}
    //   },
    //   {
    //     'id': '4',
    //     'name': 'Clinica da Suvic',
    //     'icon': 'assets/images/clinic60.png',
    //     'position': {'latitude': -23.560479, 'longitude': -46.680606}
    //   },
    //   {
    //     'id': '5',
    //     'name': 'Clinica center Suvic',
    //     'icon': 'assets/images/sus60.png',
    //     'position': {'latitude': -23.562996, 'longitude': -46.695927}
    //   },
    //   {
    //     'id': '6',
    //     'name': 'Clinica Eduardo',
    //     'icon': 'assets/images/clinic60.png',
    //     'position': {'latitude': -23.572599, 'longitude': -46.692536}
    //   }
    // ];

    clinics.forEach((clinic) => addMarker(clinic));
  }

  addMarker(clinic) async {
    var point = clinic['position'];

    markers.add(
      Marker(
        markerId: MarkerId(clinic['id']),
        position: LatLng(point['latitude'], point['longitude']),
        infoWindow: InfoWindow(title: clinic['name']),
        icon: await BitmapDescriptor.fromAssetImage(
          ImageConfiguration(),
          clinic['icon'],
        ),
        onTap: () => showDetails(clinic),
      ),
    );
    update();
  }

  showDetails(clinic) {
    Get.to(SelectVacine(clinic: clinic['id']));
    // Get.bottomSheet(
    //   ClinicDetails(
    //     nome: clinic['name'],
    //     imagem: clinic['imagem'],
    //   ),
    //   barrierColor: Colors.transparent,
    // );
  }

  // watchPosicao() async {
  //   positionStream = Geolocator.getPositionStream().listen((Position position) {
  //     latitude.value = position.latitude;
  //     longitude.value = position.longitude;
  //   });
  // }

  // @override
  // void onClose() {
  //   positionStream.cancel();
  //   super.onClose();
  // }

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
