import 'package:covid_19/models/Clinic_model.dart';
import 'package:covid_19/utils/constants.dart';
import 'package:covid_19/utils/dio/custom_dio.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:geocoding/geocoding.dart';

class ClinicRepository {
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
