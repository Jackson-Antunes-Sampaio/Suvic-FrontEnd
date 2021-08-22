import 'package:covid_19/models/schedule_model.dart';
import 'package:covid_19/repositories/vaccines_repository.dart';
import 'package:get/get.dart';

enum StateApplyVaccine{IDLE, VACCINES, LOADING, ERROR, SUCCESS}

class ApplyVaccineController extends GetxController{
  Rx<StateApplyVaccine> stateApplyVaccine = StateApplyVaccine.IDLE.obs;
  RxInt selectDose = 1.obs;
  //RxString userApply = ''.obs;
  VaccineRepository vaccineRepository = VaccineRepository();
  RxList<ScheduleModel> listvaccines = <ScheduleModel>[].obs;

  Future<void> postUserVaccine(String cpf) async{
    try {
      stateApplyVaccine.value = StateApplyVaccine.LOADING;
      await vaccineRepository.postUserVaccine(cpf).then((value){
        if(value is List<ScheduleModel> && value.isNotEmpty){
          listvaccines.value = <ScheduleModel>[];
          listvaccines.value = value;
          listvaccines.forEach((element) {
            element.cpf = cpf;
          });
          print(listvaccines);
          stateApplyVaccine.value = StateApplyVaccine.VACCINES;
        }else{
          listvaccines.value = <ScheduleModel>[];
          stateApplyVaccine.value = StateApplyVaccine.ERROR;
        }
      });
    }catch(e){
      stateApplyVaccine.value = StateApplyVaccine.VACCINES;
      print(e);
    }
  }

  Future<void> postApplyVaccine()async{
    stateApplyVaccine.value = StateApplyVaccine.LOADING;
    List<String> responses = [];
    for(var item in listvaccines){
      //String date = "${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}";
      String response = await vaccineRepository.postApplyVaccine(
          item.cpf!, item.date!, item.vaccine!.name!, item.vaccine!.dose!, item.vaccine?.manufacturer);
    }
    print(responses);
    listvaccines.value = [];
    stateApplyVaccine.value = StateApplyVaccine.SUCCESS;

  }
}