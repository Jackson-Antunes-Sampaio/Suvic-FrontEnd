import 'package:get/get.dart';

enum StateApplyVaccine{IDLE, VACCINES, LOADING}

class ApplyVaccineController extends GetxController{
  Rx<StateApplyVaccine> stateApplyVaccine = StateApplyVaccine.IDLE.obs;
  RxString selectDose = 'Única'.obs;
  RxString userApply = ''.obs;
}