
import 'package:get/get.dart';
import 'package:suvic_app/controllers/vaccine_controller.dart';

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
