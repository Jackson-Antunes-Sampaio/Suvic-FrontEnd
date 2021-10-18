
import 'package:get/get.dart';
import 'package:suvic_app/models/priceVacine.dart';
import 'package:suvic_app/models/stock_vacine_model.dart';
import 'package:suvic_app/repositories/StockRepository.dart';

class StockController extends GetxController {
  //user clinic
  var repository = StockRepository();
  List<String> vaccines = [];
  List<StockVacineModel> vaccineInStock = [];
  List<StockVacineModel> vaccineInChart = [];
  List<StockVacineModel> vacineSelected = [];

  List<PriceVacine> priceVaccine = [];

  bool loading = false;
  bool loadingSubmit = false;

  String? idClinic;

  //Get Instance
  static StockController get to => Get.find();

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

  addVacineInCart(StockVacineModel vacine) {
    vacineSelected.clear();
    vacineSelected.add(vacine);
    update();
  }

  removeVacineInCart(StockVacineModel vacine) {
    vacineSelected.remove(vacine);
    update();
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
    }
    update();
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
            price: 0,
          ),
        );
      });
      getFourMoreVaccines();
      loading = false;
    } else {
      loading = false;
    }
    update();
  }

  getVaccinesInStockByClinic(String idClinic) async {
    loading = true;
    var getvaccinesStock = await repository.getStockVaccineByIdClinic(idClinic);

    if (getvaccinesStock.isNotEmpty) {
      // print(getvaccinesStock);
      vaccineInStock.clear();

      getvaccinesStock.forEach((vaccine) {
        var name = vaccine.name;

        if ((vaccineInStock.where((element) => element.name == name)).length ==
            0) {
          vaccineInStock.add(
            StockVacineModel(
              name: name,
              lote: "",
              dataValidade: "",
              quantidade: 0,
              price: vaccine.price,
            ),
          );
        }
      });
      loading = false;
      update();
    }
  }

  insert(StockVacineModel vaccine) async {
    loading = true;
    await repository.insert(vaccine);
    vaccineInStock.add(vaccine);
    //insert price
    priceVaccine.add(PriceVacine(
      vacine: vaccine.name,
      price: vaccine.price ?? 0,
    ));
    loading = false;
    getFourMoreVaccines();
    update();
  }

  delete(StockVacineModel vaccine) {
    repository.delete(vaccine);
    vaccineInStock.remove(vaccine);
    getFourMoreVaccines();
    update();
  }

  updateVaccines(StockVacineModel vaccine) async {
    //Removel old
    // repository.delete(vaccine);
    vaccineInStock.remove(vaccine);
    var index = vaccineInStock.indexWhere(
      (element) => element.name == vaccine.name && element.lote == vaccine.lote,
    );
    vaccineInStock.removeWhere(
      (element) => element.name == vaccine.name && element.lote == vaccine.lote,
    );
    await repository.delete(vaccine);

    await repository.insert(vaccine);

    vaccineInStock.insert(index, vaccine);
    getFourMoreVaccines();
    update();
  }

  // insertPrice(PriceVacine price) {
  //   repository.insertPrice(price);
  //   priceVaccine.add(price);
  //   update();
  // }

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
