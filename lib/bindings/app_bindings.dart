import 'package:covid_19/controllers/user_controller.dart';
import 'package:get/get.dart';

class AppBindings implements Bindings{

  @override
  void dependencies() {
    Get.put(UserController(),permanent: true);
  }

}