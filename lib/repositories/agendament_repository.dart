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
  Future<List<AgendamentModel>> getAll() async {
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

  insert(AgendamentModel agendamentModel) async {
    try {
      Dio? dio = CustomDio().instance;

      final storage = FlutterSecureStorage();
      final token = await storage.read(key: "token");
      dio!.options.headers["Cookie"] = token;

      await dio.post(API_URL + service, data: {
        'start': (agendamentModel.data ?? '') +
            ' ' +
            (agendamentModel.time ?? '') +
            ':00',
        'end': (agendamentModel.data ?? '') +
            ' ' +
            DateFormat('HH:mm:ss').format(DateTime.now()),
        'title': agendamentModel.vaccine,
        'clinic': agendamentModel.idClinica,
      });

      Get.snackbar(
        'Sucesso',
        'O seu agendamento foi efectuado!',
        backgroundColor: Colors.green,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      Get.snackbar(
        'Erro',
        'não possível realizar o agendamento!',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
      print(e);
      print('Error Insert');
    }
  }
}
