import 'package:covid_19/controllers/StockController.dart';

import 'package:get/get.dart';

class GetAllVacines {
  static Future<List<Map<String, String>>> getSuggestions(String query) async {
    await Future.delayed(Duration(seconds: 1));
    StockController stockController = Get.find();

    print('Vaccines' + stockController.vaccineInStock.toString());

    List<String> vaccines = [];
    stockController.vaccines.forEach((element) {
      vaccines.add(element);
    });

    vaccines.retainWhere(
      (element) => element.toLowerCase().contains(query.toLowerCase()),
    );

    return List.generate(vaccines.length, (index) {
      return {'name': vaccines[index]};
    });
  }
}
