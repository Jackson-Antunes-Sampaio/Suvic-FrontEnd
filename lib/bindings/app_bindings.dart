import 'package:covid_19/controllers/agendament_controller.dart';
import 'package:covid_19/controllers/clinicController.dart';
import 'package:covid_19/controllers/stock_vacine_controller.dart';
import 'package:covid_19/controllers/user_controller.dart';
import 'package:get/get.dart';

class AppBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(UserController(), permanent: true);
    // Get.put(ClinicController(), permanent: true);
    // Get.put(StockVacineController(), permanent: true);
    // Get.put(AgendamentController(), permanent: true);
  }
}
