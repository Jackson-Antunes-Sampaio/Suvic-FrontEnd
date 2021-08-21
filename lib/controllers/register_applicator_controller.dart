

import 'package:covid_19/repositories/register_applicator_repository.dart';
import 'package:get/get.dart';

class RegisterApplicatorController extends GetxController{

  postRegisterApplicator(String CPF)async{
    RegisterApplicatorRepository registerApplicatorRepository = RegisterApplicatorRepository();
    String response = await registerApplicatorRepository.postRegisterApplicator(CPF);
    Get.snackbar("Alerta", response);
    print(response);
  }
}