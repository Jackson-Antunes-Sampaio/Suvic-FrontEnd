import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:suvic_app/utils/constants.dart';
import 'package:suvic_app/utils/dio/custom_dio.dart';

class B2cShowMyAgendamentsRepository{
  delete(myAgendament) async {
    try {
      Dio? dio = CustomDio().instance;

      final storage = FlutterSecureStorage();

      final token = await storage.read(key: "token");
      dio!.options.headers["Cookie"] = token;

      final response = await dio.delete(API_URL + 'clinics/schedule', data: {
        'clinic':myAgendament.clinicId,
        'date':myAgendament.updatedAt,
        'slot': myAgendament.slot,
        'vaccine': myAgendament.vaccineName,
        'houseCall':myAgendament.houseCall,
      });

      print({
        'clinic':myAgendament.clinicId.toString(),
        'date':myAgendament.updatedAt,
        'slot': myAgendament.slot.toString(),
        'vaccine': myAgendament.vaccineName,
        'houseCall':myAgendament.houseCall.toString(),      });

    } catch (e) {
      Get.snackbar(
        'Erro',
        'oucorreu um erro interno',
        backgroundColor: Colors.red,
        snackPosition: SnackPosition.BOTTOM,
      );
      print('Error Insert $e');
    }
  }

}