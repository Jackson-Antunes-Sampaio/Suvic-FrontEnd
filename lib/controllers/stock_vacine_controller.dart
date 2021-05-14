import 'package:covid_19/models/stock_vacine_model.dart';
import 'package:covid_19/repositories/stock_vacine_repository.dart';
import 'package:get/get.dart';

class StockVacineController extends GetxController {
  var repository = StockVacineRepository();
  List vaccines = [].obs;

  getAll() async {
    vaccines.addAll(await repository.getAll());
  }

  insert(StockVacineModel vaccine) async {
    await repository.insert(vaccine);
    vaccines.add(vaccine);
  }
}
