import 'package:covid_19/models/priceVacine.dart';
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

  getPriceVaccine() async {
    try {
      Dio? dio = CustomDio().instance;
      final storage = FlutterSecureStorage();
      final token = await storage.read(key: "token");

      dio!.options.headers["Cookie"] = token;
      // print('Token: ' + token.toString());
      final response = await dio.get(API_URL + 'clinics/price');
      // print("Resposta-> ${response.data}");

      return response.data;
    } catch (e) {
      Get.snackbar(
        'Erro',
        'Não possível obter os preços das vaccinas em stock',
        backgroundColor: Colors.red,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  getStockVaccineByIdClinic(String idClinic) async {
    try {
      Dio? dio = CustomDio().instance;
      final storage = FlutterSecureStorage();
      final token = await storage.read(key: "token");

      dio!.options.headers["Cookie"] = token;
      // print('Token: ' + token.toString());
      // final response = await dio.get(API_URL + 'clinics/storage/list');
      final response = await dio.post(
        API_URL + 'clinics/vaccines',
        data: {
          "clinic": int.parse(idClinic),
        },
      );
      // print("Resposta ID $idClinic Aqui-> ${response.data}");

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
          colorText: Colors.white,
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
        'oucorreu um erro interno',
        backgroundColor: Colors.red,
        snackPosition: SnackPosition.BOTTOM,
      );
      print('Error Insert $e');
    }
  }

  insertPrice(PriceVacine vacine) async {
    try {
      Dio? dio = CustomDio().instance;

      final storage = FlutterSecureStorage();

      final token = await storage.read(key: "token");
      dio!.options.headers["Cookie"] = token;

      final response = await dio.post(API_URL + 'clinics/price', data: {
        'price': vacine.price,
        'vaccine': vacine.vacine,
      });

      if (response.statusCode != 200) {
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
        'oucorreu um erro interno',
        backgroundColor: Colors.red,
        snackPosition: SnackPosition.BOTTOM,
      );
      print('Error Insert $e');
    }
  }

  delete(StockVacineModel stockvacine) async {
    try {
      Dio? dio = CustomDio().instance;

      final storage = FlutterSecureStorage();

      final token = await storage.read(key: "token");
      dio!.options.headers["Cookie"] = token;

      final response = await dio.delete(API_URL + 'clinics/storage', data: {
        'batch': stockvacine.lote.toString(),
        'expirationdate': stockvacine.dataValidade,
        'purge': true,
        // 'count': stockvacine.quantidade,
        // 'reserved': stockvacine.reserved,
        'vaccine': stockvacine.name
      });

      print({
        'batch': stockvacine.lote.toString(),
        'expirationdate': stockvacine.dataValidade,
        'purge': true,
        'count': stockvacine.quantidade,
        // 'count': stockvacine.quantidade,
        // 'reserved': stockvacine.reserved,
        'vaccine': stockvacine.name
      });

      if (response.statusCode == 200) {
        Get.snackbar(
          'Sucesso',
          'vacina removida do esqoque!',
          backgroundColor: Colors.green,
          colorText: Colors.white,
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
        'oucorreu um erro interno',
        backgroundColor: Colors.red,
        snackPosition: SnackPosition.BOTTOM,
      );
      print('Error Insert $e');
    }
  }
}
