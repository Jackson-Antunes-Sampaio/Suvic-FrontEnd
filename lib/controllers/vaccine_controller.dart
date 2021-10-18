
import 'package:get/get.dart';
import 'package:suvic_app/repositories/stock_vacine_repository.dart';

class VaccineController extends GetxController {
  var repository = StockVacineRepository();
  List<String> vacines = [];

  static VaccineController get to => Get.find();




  VaccineController() {
    getAll();
  }
  //get all
  getAll() async {
    var vacine = await repository.getAllVacine();

    print(vacine);

    vacine.forEach((element) {
      vacines.add(element.name);
    });
    update();
  }
}
