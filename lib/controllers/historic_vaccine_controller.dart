
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:suvic_app/models/historic_vaccine_model.dart';
import 'package:suvic_app/repositories/historic_vaccine_repository.dart';


enum StateHistoric {IDLE, LOADING}

class HistoricVaccineController extends GetxController{

  List<HistoricVaccineModel> listHistoric = [];
  List<HistoricVaccineModel> listFilterHistoric = [];

  Rx<StateHistoric> stateHistoric = StateHistoric.IDLE.obs;


  Future<void> getHistoricVaccine()async{
    stateHistoric.value = StateHistoric.LOADING;
    final HistoricVaccineRepository historicVaccineRepository = HistoricVaccineRepository();
    List<HistoricVaccineModel> list = await historicVaccineRepository.getHistoricVaccine();
    listHistoric = [];
    listFilterHistoric = [];
    listFilterHistoric.addAll(list);
    listHistoric.addAll(list);
    print(listHistoric);
    stateHistoric.value = StateHistoric.IDLE;
  }

  void filter(String value)async{

    stateHistoric.value = StateHistoric.LOADING;
    if(value == ""){
      await getHistoricVaccine();
    }else{
      value = value.toUpperCase();
      listFilterHistoric = [];
      var list = listHistoric.where((e) {

        String vaccine = e.vaccineName!.toUpperCase();
        String data = '${DateFormat('dd/MM/yyyy').format(DateTime.parse(e.applicationDate!))}';

        String uni = '$vaccine $data';


        return uni.contains("$value");
      });
      listFilterHistoric.addAll(list);
      print(listFilterHistoric);

    }
    stateHistoric.value = StateHistoric.IDLE;
  }

}