import 'package:covid_19/models/agendament_model.dart';
import 'package:covid_19/repositories/agendament_repository.dart';
import 'package:get/get.dart';

class AgendamentController extends GetxController {
  var repository = AgendamentRepository();
  List agendaments = [].obs;

  static AgendamentController get to => Get.find();

  getAll() async {
    agendaments.addAll(await repository.getAll());
  }

  insert(AgendamentModel agendament) async {
    await repository.insert(agendament);
    agendaments.add(agendament);
  }
}
