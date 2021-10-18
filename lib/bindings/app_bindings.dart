
import 'package:get/get.dart';
import 'package:suvic_app/controllers/user_controller.dart';

class AppBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(UserController(), permanent: true);
    //Get.put(ClinicController(), permanent: true);
    // Get.put(StockVacineController(), permanent: true);
    // Get.put(AgendamentController(), permanent: true);
  }
}
