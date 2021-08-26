import 'package:covid_19/controllers/StockController.dart';
import 'package:covid_19/models/stock_vacine_model.dart';

import 'package:get/get.dart';

class GetAllVacinesAgendament {
  static Future<List<Map<String, dynamic>>> getSuggestions(String query) async {
    await Future.delayed(Duration(seconds: 1));
    StockController stockController = Get.find();

    List<StockVacineModel> vaccines = [];
    stockController.vaccineInStock.forEach((element) {
      vaccines.add(element);
    });

    vaccines.retainWhere(
      (element) => element.name.toLowerCase().contains(query.toLowerCase()),
    );

    return List.generate(vaccines.length, (index) {
      return vaccines[index].toJson();
    });
  }
}
