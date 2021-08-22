import 'package:covid_19/controllers/user_controller.dart';
import 'package:covid_19/models/stock_vacine_model.dart';
import 'package:covid_19/repositories/StockRepository.dart';
import 'package:get/get.dart';

class StockController extends GetxController {
  //user clinic
  var repository = StockRepository();
  List<String> vaccines = [];
  List<StockVacineModel> vaccineInStock = [];
  List<StockVacineModel> vaccineInChart = [];
  bool loading = false;

  StockController() {
    init();
  }

  init() {
    getVaccinesInStock();
    getVaccines();
  }

  getVaccines() async {
    var getvaccines = await repository.getVaccines();

    if (getvaccines != null) {
      getvaccines.forEach((vaccine) {
        vaccines.add(vaccine['name']);
      });
      update();
    }
  }

  getVaccinesInStock() async {
    loading = true;
    var getvaccinesStock = await repository.getStockVaccine();

    if (getvaccinesStock.isNotEmpty) {
      // print(getvaccinesStock);
      getvaccinesStock.forEach((vaccine) {
        var name;
        if (vaccine['vaccine'] == null) {
          name = '';
        } else {
          name = vaccine['vaccine']['name'];
        }

        vaccineInStock.add(
          StockVacineModel(
            name: name,
            // name: 'Teste',
            lote: vaccine['batch'] == null ? '' : vaccine['batch'],
            dataValidade: vaccine['expirationdate'] == null
                ? ''
                : vaccine['expirationdate'],
            quantidade: vaccine['count'],
            valor: 0,
          ),
        );
      });
      getFourMoreVaccines();
      loading = false;
      update();
    } else {
      loading = false;
      update();
    }
  }

  insert(StockVacineModel vaccine) {
    repository.insert(vaccine);
    vaccineInStock.add(vaccine);
    getFourMoreVaccines();
    update();
  }

  getFourMoreVaccines() {
    var vacineS = vaccineInStock;
    if (vacineS.isNotEmpty) {
      vacineS.sort((a, b) => b.quantidade.compareTo(a.quantidade));

      //clear older vaccines
      vaccineInChart.clear();
      for (var x = 0; x < 4; x++) {
        vaccineInChart.add(vacineS[x]);
      }
    }
  }
}
