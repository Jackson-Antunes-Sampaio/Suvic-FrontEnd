import 'package:covid_19/repositories/vaccines_repository.dart';
import 'package:get/get.dart';

class VaccineController extends GetxController {
  var repository = VaccineRepository();
  List vacines = [];
  Map<String, dynamic> vac = {};

  VaccineController() {
    getAll();
  }

  getAll() async {
    var vacine = await repository.getaAll();

    vacines.addAll(vacine);
    // print(vacine.toJson());
    update();
  }
}
