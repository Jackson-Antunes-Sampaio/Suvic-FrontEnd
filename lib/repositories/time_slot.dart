import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:suvic_app/utils/constants.dart';
import 'package:suvic_app/utils/dio/custom_dio.dart';

class SlotTimesRepository {
  // Future<TimeSlotsModel?> getSlotsByClinic(id) async {
  //   try {
  //     Dio? dio = CustomDio().instance;
  //     final response = await dio!.get(API_URL + 'clinics/slots');
  //     List<TimeSlotsModel> slotsTime = [];
  //     response.data.forEach((element) {
  //       slotsTime.add(TimeSlotsModel.fromJson(element));
  //       print(slotsTime);
  //     });
  //   } catch (erro) {
  //     print(erro);
  //   }
  // }

  getSlotsByClinic(String idClinic, String date) async {
    try {
      Dio? dio = CustomDio().instance;
      final storage = FlutterSecureStorage();
      final token = await storage.read(key: "token");

      dio!.options.headers["Cookie"] = token;
      final response = await dio.post(
        API_URL + 'clinics/schedule/slots',
        data: {
          "clinic": int.parse(idClinic),
          "date": date,
        },
      );

      print(response.data);
      return response.data;
    } catch (e) {
      Get.snackbar(
        'Erro',
        'Não possível obter as vaccinas em stock, $e',
        backgroundColor: Colors.red,
        snackPosition: SnackPosition.BOTTOM,
      );
      return Future.error("error");
    }
  }
}
