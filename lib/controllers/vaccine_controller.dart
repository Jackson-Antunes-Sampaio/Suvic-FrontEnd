import 'package:covid_19/models/vaccine_model.dart';
import 'package:covid_19/repositories/stock_vacine_repository.dart';
import 'package:get/get.dart';

class VaccineController extends GetxController {
  var repository = StockVacineRepository();
  List<VaccinesModel> listVaccines = [];
  List<String> vacines = [];

  static VaccineController get to => Get.find();

  @override
  void onInit() {
    super.onInit();
    getAllVaccines();
  }


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

  getAllVaccines()async{
    listVaccines = [];
    var response = await repository.getAllVaccines();
    listVaccines.addAll(response);
    print(listVaccines);
  }

}
