import 'package:covid_19/models/Clinic_model.dart';
import 'package:covid_19/utils/constants.dart';
import 'package:covid_19/utils/dio/custom_dio.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';

class ClinicRepository {
  Future<List<ClinicModel>?> getAllClinis() async {
    try {
      Dio? dio = CustomDio().instance;
      final storage = FlutterSecureStorage();
      final token = await storage.read(key: "token");
      dio!.options.headers["Cookie"] = token;
      final response = await dio.get(API_URL + 'clinics');

      List<dynamic> data = response.data ?? [];
      List<ClinicModel> clinics = [];

      data.forEach((element) {
        print('mirror:' + element.toString());
        clinics.add(
          ClinicModel(
            id: element['id']!,
            name: element['corporateName'],
            phone: element['phone'],
            email: element['email'],
            address: element['address_district'],
            latitude: element['latitude'],
            longitude: element['longitude'],
          ),
        );
      });

      return clinics;
    } catch (e) {
      print(e);
      Get.snackbar(
        'Erro',
        e.toString(),
        colorText: Colors.white,
        backgroundColor: Colors.red,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  Future<ClinicModel?> getClinicById(id) async {
    try {
      Dio? dio = CustomDio().instance;
      final storage = FlutterSecureStorage();
      final token = await storage.read(key: "cookie");
      dio!.options.headers["Cookie"] = token;
      final response = await dio.get(API_URL + 'clinics');

      List<ClinicModel> clinics = [];

      response.data.forEach((element) {
        clinics.add(ClinicModel.fromJson(element));
      });

      var clinic = clinics.firstWhere((element) => element.id == id);
      //set Location (Latitude, Longitude)
      List<Location> locations = await locationFromAddress(clinic.address!);
      var localClinic = locations.first;

      return ClinicModel(
          id: clinic.id,
          name: clinic.name,
          phone: clinic.phone,
          email: clinic.email,
          address: clinic.address,
          latitude: localClinic.latitude,
          longitude: localClinic.latitude);
    } catch (e) {
      print(e);
      Future.error('Não foi possível localizar a clínica');
    }
  }
}
