import 'package:covid_19/models/priceVacine.dart';
import 'package:covid_19/models/stock_vacine_model.dart';
import 'package:covid_19/repositories/StockRepository.dart';
import 'package:get/get.dart';

class StockController extends GetxController {
  //user clinic
  var repository = StockRepository();
  List<String> vaccines = [];
  List<StockVacineModel> vaccineInStock = [];
  List<StockVacineModel> vaccineInChart = [];
  List<PriceVacine> priceVaccine = [];

  bool loading = false;
  String? idClinic;

  StockController({this.idClinic}) {
    var id = idClinic ?? '';
    if (id.isNotEmpty) {
      getVaccinesInStockByClinic(idClinic!);
    } else {
      init();
    }
  }

  init() {
    getVaccinesInStock();
    getVaccines();
    getPriceVaccines();
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

  getPriceVaccines() async {
    var getPricesVaccines = await repository.getPriceVaccine();

    if (getPricesVaccines.isNotEmpty) {
      getPricesVaccines.forEach((priceVaccines) {
        priceVaccine.add(
          PriceVacine(
            vacine: priceVaccines['vaccine']['name'],
            price: priceVaccines['value'],
          ),
        );
      });
      update();
    }
  }

  getVaccinesInStock() async {
    loading = true;
    vaccineInStock.clear();

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
            reserved: vaccine['reserved'] == null ? '' : vaccine['reserved'],
            dataValidade: vaccine['expirationdate'] == null
                ? ''
                : vaccine['expirationdate'],
            quantidade: vaccine['count'],
          ),
        );
      });
      getFourMoreVaccines();
      loading = false;
      update();
    }
  }

  getVaccinesInStockByClinic(String idClinic) async {
    // loading = true;

    var getvaccinesStock = await repository.getStockVaccineByIdClinic(idClinic);
    vaccineInStock.clear();

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
          ),
        );
      });
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

  delete(StockVacineModel vaccine) {
    repository.delete(vaccine);
    vaccineInStock.remove(vaccine);
    getFourMoreVaccines();
    update();
  }

  insertPrice(PriceVacine price) {
    repository.insertPrice(price);
    priceVaccine.add(price);
    update();
  }

  getFourMoreVaccines() {
    vaccineInChart.clear();
    var vacineS = vaccineInStock;
    if (vacineS.isNotEmpty && vacineS.length > 4) {
      vacineS.sort((a, b) => b.quantidade.compareTo(a.quantidade));

      //clear older vaccines
      vaccineInChart.clear();
      for (var x = 0; x < 4; x++) {
        vaccineInChart.add(vacineS[x]);
      }
    }
  }
}
