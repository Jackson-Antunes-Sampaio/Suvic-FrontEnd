import 'package:covid_19/models/agendament_model.dart';
import 'package:covid_19/repositories/agendament_repository.dart';
import 'package:get/get.dart';

class AgendamentController extends GetxController {
  var repository = AgendamentRepository();
  List agendaments = [].obs;
  var loading = false.obs;

  static AgendamentController get to => Get.find();

  getAll() async {
    agendaments.addAll(await repository.getAll());
  }

  insert(AgendamentModel agendament) async {
    loading.value = true;
    await repository.insert(agendament);
    loading.value = false;
    Get.snackbar('Sucesso', 'O seu agendamento foi efectuado com sucesso',
        snackPosition: SnackPosition.BOTTOM);
    agendaments.add(agendament);
  }
}
