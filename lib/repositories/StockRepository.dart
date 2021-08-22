import 'package:covid_19/models/stock_vacine_model.dart';
import 'package:covid_19/utils/constants.dart';
import 'package:covid_19/utils/dio/custom_dio.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

class StockRepository {
  getVaccines() async {
    try {
      Dio? dio = CustomDio().instance;
      final storage = FlutterSecureStorage();
      final token = await storage.read(key: "token");

      dio!.options.headers["Cookie"] = token;
      final response = await dio.get(API_URL + 'vaccines');

      // print("StatusCode: ${response.statusCode}");
      // print("Resposta ${response.data}");

      return response.data;
    } catch (e) {
      Get.snackbar(
        'Erro',
        'Não possível obter os nomes das vaccinas',
        backgroundColor: Colors.red,
      );
      return Future.error("error");
    }
  }

  getStockVaccine() async {
    try {
      Dio? dio = CustomDio().instance;
      final storage = FlutterSecureStorage();
      final token = await storage.read(key: "token");

      dio!.options.headers["Cookie"] = token;
      // print('Token: ' + token.toString());
      final response = await dio.get(API_URL + 'clinics/storage/list');
      // print("Resposta-> ${response.data}");

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

  getStockVaccineByIdClinic(String idClinic) async {
    try {
      Dio? dio = CustomDio().instance;
      final storage = FlutterSecureStorage();
      final token = await storage.read(key: "token");

      dio!.options.headers["Cookie"] = token;
      // print('Token: ' + token.toString());
      final response = await dio.get(API_URL + 'clinics/storage/list');
      // final response = await dio.post(
      //   API_URL + 'clinics/vaccines',
      //   data: {
      //     "clinic": int.parse(idClinic),
      //   },
      // );
      // print("Resposta-> ${response.data}");

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

  insert(StockVacineModel stockvacine) async {
    try {
      Dio? dio = CustomDio().instance;

      final storage = FlutterSecureStorage();

      final token = await storage.read(key: "token");
      dio!.options.headers["Cookie"] = token;

      final response = await dio.post(API_URL + 'clinics/storage', data: {
        'batch': stockvacine.lote.toString(),
        'expirationdate': stockvacine.dataValidade,
        'count': stockvacine.quantidade,
        'reserved': 0,
        'vaccine': stockvacine.name
      });

      if (response.statusCode == 200) {
        Get.snackbar(
          'Sucesso',
          'nova vacina adicionada ao esqoque!',
          backgroundColor: Colors.green,
          snackPosition: SnackPosition.BOTTOM,
        );
      } else {
        Get.snackbar(
          'Erro',
          'oucorreu um erro interno code: ${response.statusCode}',
          backgroundColor: Colors.red,
          snackPosition: SnackPosition.BOTTOM,
        );
        print('Error code ${response.statusCode}');
      }
    } catch (e) {
      Get.snackbar(
        'Erro',
        'oucorreu um erro interno: $e',
        backgroundColor: Colors.red,
        snackPosition: SnackPosition.BOTTOM,
      );
      print('Error Insert $e');
    }
  }
}
