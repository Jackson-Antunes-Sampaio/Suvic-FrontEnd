
import 'package:get/get.dart';
import 'package:suvic_app/models/stock_vacine_model.dart';
import 'package:suvic_app/repositories/stock_vacine_repository.dart';

class StockVacineController extends GetxController {
  var repository = StockVacineRepository();
  List<StockVacineModel> vaccines = [];

  StockVacineController() {
    getAll();
  }

  getAll() async {
    var res = await repository.getAllVacine();
    vaccines.addAll(res);
    //vaccines.addAll(await repository.getAll());
    print(vaccines);
    update();
  }

  insert(StockVacineModel vaccine) async {
    await repository.insert(vaccine);
    vaccines.add(vaccine);
    update();
  }
}
