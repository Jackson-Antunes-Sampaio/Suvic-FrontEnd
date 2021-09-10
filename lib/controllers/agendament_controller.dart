import 'package:covid_19/controllers/user_controller.dart';
import 'package:covid_19/models/agendament_model.dart';
import 'package:covid_19/repositories/agendament_repository.dart';
import 'package:get/get.dart';

class AgendamentController extends GetxController {
  var repository = AgendamentRepository();
  UserController userController = Get.find();
  List agendaments = [].obs;
  var loading = false.obs;
  var dialg = false.obs;
  String userAdress = '';

  static AgendamentController get to => Get.find();

  getAll() async {
    agendaments.addAll(await repository.getAll());
  }

  checkedAdress() {
    if (userAdress.isEmpty) {
      dialg.value = true;
    } else {
      dialg.value = false;
    }
  }

  Future<int> insert(AgendementModel agendament) async {
    loading.value = true;
    var res = await repository.insert(agendament);
    loading.value = false;
    agendaments.add(agendament);
    update();
    return res;
  }

  Future<int> donePaid(AgendementModel agendament) async {
    loading.value = true;
    var res = await repository.donePaid(agendament);
    loading.value = false;
    agendaments.add(agendament);
    update();
    return res;
  }
}
