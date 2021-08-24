import 'package:covid_19/models/schedule_model.dart';
import 'package:covid_19/models/vaccine_model.dart';
import 'package:covid_19/models/vacine_card_model.dart';
import 'package:covid_19/utils/constants.dart';
import 'package:covid_19/utils/dio/custom_dio.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class VaccineRepository {
  Future<List<VaccineCardModel>> getVaccineCard() async {
    try {
      Dio? dio = CustomDio().instance;

      final storage = FlutterSecureStorage();
      final token = await storage.read(key: "token");

      dio!.options.headers["Cookie"] = token;
      final response = await dio.get(API_URL + "users/vaccinecard");

      return (response.data as List).map<VaccineCardModel>((e) {
        return VaccineCardModel.fromJson(e);
      }).toList();
    } catch (e) {
      print(e);
      return Future.error("error");
    }
  }

  Future<List<ScheduleModel>> postUserVaccine(String cpf) async {
    try {
      Dio? dio = CustomDio().instance;

      final storage = FlutterSecureStorage();
      final token = await storage.read(key: "token");

      dio!.options.headers["Cookie"] = token;
      final response = await dio.post(API_URL + "clinics/schedule/user", data: {
        "cpf" : "$cpf"
      });

      return (response.data as List).map<ScheduleModel>((e) {
        return ScheduleModel.fromJson(e);
      }).toList();
    } catch (e) {
      print(e);
      return Future.error("error");
    }
  }

  Future<String> postApplyVaccine(String cpf, String date, String vaccine, int dose, String? manufacturer) async {
    try {

      Dio? dio = CustomDio().instance;
      final storage = FlutterSecureStorage();
      final token = await storage.read(key: "token");
      dio!.options.headers["Cookie"] = token;

      Map<String, dynamic> map = {
        "target" : cpf,
        "applicationDate" : date,
        "vaccine" : vaccine,
        "batch" : "1",
        "doseNumber" : dose,
        "manufacturer" : manufacturer
      };
      final response = await dio.post(API_URL + "users/vaccinecard", data: map);
      print(response);

      return response.data["message"];
    } catch (e) {
      print(e);
      return Future.error("error");
    }
  }

  Future<List<VaccinesModel>> getAllVaccines() async {
    try {

      Dio? dio = CustomDio().instance;
      final storage = FlutterSecureStorage();
      final token = await storage.read(key: "token");
      dio!.options.headers["Cookie"] = token;

      final response = await dio.get(API_URL + 'vaccines');

      print("response.data: ${response.data}");

      if (response.statusCode == 200) {
        return (response.data as List).map<VaccinesModel>((e) {
          return VaccinesModel.fromJson(e);
        }).toList();

      } else {
        print('Error code ${response.statusCode}');
        return [];
      }
    } catch (e) {
      return Future.error(e);
    }
  }

}
