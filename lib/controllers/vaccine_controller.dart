import 'package:covid_19/repositories/stock_vacine_repository.dart';
import 'package:get/get.dart';

class VaccineController extends GetxController {
  var repository = StockVacineRepository();
  List<String> vacines = [];

  VaccineController() {
    getAll();
  }
  //get all
  getAll() async {
    var vacine = await repository.getAllVacine();

    vacine.forEach((element) {
      vacines.add(element.name);
    });
    update();
  }
}
