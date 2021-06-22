import 'package:covid_19/controllers/vaccine_controller.dart';
import 'package:covid_19/utils/constants.dart';
import 'package:covid_19/utils/dio/custom_dio.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

class GetAllVacines {
  static Future<List<Map<String, String>>> getSuggestions(String query) async {
    await Future.delayed(Duration(seconds: 1));
    VaccineController vaccineController = Get.find();

    List vaccines = vaccineController.vacines;

    vaccines.retainWhere(
      (element) => element.toLowerCase().contains(
            query.toLowerCase(),
          ),
    );

    return List.generate(vaccines.length, (index) {
      return {'name': vaccines[index], 'price': '5'};
    });
  }
}
