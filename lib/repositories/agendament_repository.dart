import 'package:covid_19/controllers/clinicController.dart';
import 'package:covid_19/models/agendament_model.dart';
import 'package:covid_19/utils/constants.dart';
import 'package:covid_19/utils/dio/custom_dio.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AgendamentRepository {
  final String service = 'clinics/schedule';
  Future<List<AgendementModel>> getAll() async {
    try {
      Dio dio = Dio();
      final response = await dio.get(API_URL + service);

      if (response.statusCode == 200) {
        print('OK');
      } else {
        print('Error');
      }
      return response.data;
    } catch (e) {
      print('Error in get all Vaccines');
      return [];
    }
  }

  Future<int> insert(AgendementModel agendamentModel) async {
    try {
      Dio? dio = CustomDio().instance;

      final storage = FlutterSecureStorage();
      final token = await storage.read(key: "token");
      dio!.options.headers["Cookie"] = token;

      var inputFormat = DateFormat('dd/MM/yyyy');
      var date1 = inputFormat.parse(agendamentModel.date!);

      var outputFormat = DateFormat('yyyy-MM-dd');
      var date = outputFormat.format(date1);

      var res = await dio.post(API_URL + service, data: {
        "clinic": agendamentModel.clinicId!,
        "date": date,
        "slot": agendamentModel.slot,
        "vaccine": agendamentModel.vaccine,
        "houseCall": false,
      });

      //mensager
      var mesagerError = ['&', 'User already has vaccine appointment on day'];

      if (res.data['message'] != 'Success') {
        return mesagerError
            .indexWhere((element) => element == res.data['error']);
      } else {
        return 0;
      }

      // Get.snackbar(
      //   'Sucesso',
      //   'O seu agendamento foi efectuado!',
      //   backgroundColor: Colors.green,
      //   colorText: Colors.white,
      //   snackPosition: SnackPosition.BOTTOM,
      // );
    } catch (e) {
      // Get.snackbar(
      //   'Erro',
      //   'não possível realizar o agendamento!',
      //   backgroundColor: Colors.red,
      //   colorText: Colors.white,
      //   snackPosition: SnackPosition.BOTTOM,
      // );
      print(e);
      print('Error Insert');
      return 111;
    }
  }

  Future<int> donePaid(AgendementModel agendamentModel) async {
    try {
      Dio? dio = CustomDio().instance;

      final storage = FlutterSecureStorage();
      final token = await storage.read(key: "token");
      dio!.options.headers["Cookie"] = token;

      var inputFormat = DateFormat('dd/MM/yyyy');
      var date1 = inputFormat.parse(agendamentModel.date!);

      var outputFormat = DateFormat('yyyy-MM-dd');
      var date = outputFormat.format(date1);

      var res = await dio.post(API_URL + 'clinics/schedule/status/paid', data: {
        "clinic": agendamentModel.clinicId!,
        "date": date,
        "slot": agendamentModel.slot,
        "vaccine": agendamentModel.vaccine,
        "houseCall": false,
      });

      //mensager
      var mesagerError = ['&', 'User already has vaccine appointment on day'];

      print(res.data);

      if (res.data['message'] != 'Success') {
        return mesagerError
            .indexWhere((element) => element == res.data['error']);
      } else {
        return 0;
      }
    } catch (e) {
      print(e);
      print('Error Insert');
      return 111;
    }
  }
}
