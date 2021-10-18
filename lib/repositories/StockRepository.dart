
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:suvic_app/models/priceVacine.dart';
import 'package:suvic_app/models/stock_vacine_model.dart';
import 'package:suvic_app/utils/constants.dart';
import 'package:suvic_app/utils/dio/custom_dio.dart';

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
        'Não possível obter as vaccinas',
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
        'Não possível obter as vaccinas em stock',
        backgroundColor: Colors.red,
        snackPosition: SnackPosition.BOTTOM,
      );
      return Future.error("error");
    }
  }

  getPiceByClinic(int idClinic) async {
    try {
      Dio? dio = CustomDio().instance;
      final storage = FlutterSecureStorage();
      final token = await storage.read(key: "token");

      dio!.options.headers["Cookie"] = token;
      // print('Token: ' + token.toString());
      final response = await dio.post(
        API_URL + 'clinics/price/search',
        data: {
          "clinic": idClinic,
        },
      );

      return response.data;
    } catch (e) {
      print(e);
      return [];
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

  Future<List<StockVacineModel>> getStockVaccineByIdClinic(
      String idClinic) async {
    try {
      Dio? dio = CustomDio().instance;
      final storage = FlutterSecureStorage();
      final token = await storage.read(key: "token");

      dio!.options.headers["Cookie"] = token;
      final response = await dio.post(
        API_URL + 'clinics/price/search',
        data: {
          "clinic": idClinic,
        },
      );
      // final response = await dio.post(
      //   API_URL + 'clinics/vaccines',
      //   data: {
      //     "clinic": int.parse(idClinic),
      //   },
      // );

      List<StockVacineModel> vacines = [];

      response.data.forEach((vaccine) async {
        vacines.add(
          StockVacineModel(
            name: vaccine['vaccineName'] ?? '',
            lote: '',
            dataValidade: '',
            quantidade: 0,
            price: vaccine['value'] ?? 0,
          ),
        );
      });

      return vacines;
    } catch (e) {
      Get.snackbar(
        'Erro',
        'Não possível obter as vaccinas em stock.',
        backgroundColor: Colors.red,
        snackPosition: SnackPosition.BOTTOM,
      );
      List<StockVacineModel> vacines = [];
      return vacines;
    }
  }

  insert(StockVacineModel stockvacine) async {
    try {
      Dio? dio = CustomDio().instance;

      final storage = FlutterSecureStorage();

      final token = await storage.read(key: "token");
      dio!.options.headers["Cookie"] = token;

      var inputFormat = DateFormat('dd/MM/yyyy');
      var date1 = inputFormat.parse(stockvacine.dataValidade);

      var outputFormat = DateFormat('yyyy-MM-dd');
      var date = outputFormat.format(date1); // 2019-08-18

      final response = await dio.post(API_URL + 'clinics/storage', data: {
        'batch': stockvacine.lote.toString(),
        'expirationDate': date,
        'count': stockvacine.quantidade,
        'reserved': 0,
        'vaccine': stockvacine.name
      });

      var mensager = response.data;

      if (mensager['message'] == 'Success') {
        await insertPrice(
          PriceVacine(
            vacine: stockvacine.name,
            price: stockvacine.price ?? 0,
          ),
        );
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
          'Valide o formulario',
          backgroundColor: Colors.red,
          snackPosition: SnackPosition.BOTTOM,
        );
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

      if (response.data['message'] != 'Success') {
        Get.snackbar(
          'Erro',
          'oucorreu um erro interno relacionado com preço}',
          backgroundColor: Colors.red,
          snackPosition: SnackPosition.BOTTOM,
        );
        print('Error code ${response.data}');
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

      // if (response.statusCode == 200) {
      //   Get.snackbar(
      //     'Sucesso',
      //     'vacina removida do esqoque!',
      //     backgroundColor: Colors.green,
      //     colorText: Colors.white,
      //     snackPosition: SnackPosition.BOTTOM,
      //   );
      // } else {
      //   Get.snackbar(
      //     'Erro',
      //     'oucorreu um erro interno code: ${response.statusCode}',
      //     backgroundColor: Colors.red,
      //     snackPosition: SnackPosition.BOTTOM,
      //   );
      //   print('Error code ${response.statusCode}');
      // }
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
