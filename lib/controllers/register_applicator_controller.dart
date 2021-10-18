
import 'package:get/get.dart';
import 'package:suvic_app/repositories/register_applicator_repository.dart';

class RegisterApplicatorController extends GetxController{
  RxBool loading = false.obs;

  Future<bool> postRegisterApplicator(String cpf)async{
    try{
      loading.value = true;
      RegisterApplicatorRepository registerApplicatorRepository = RegisterApplicatorRepository();
      String response = await registerApplicatorRepository.postRegisterApplicator(cpf);
      print(response);
      if(response == "Usuario não encontrado no banco de dados."){
        loading.value = false;
        return false;
      }else{
        loading.value = false;
        return true;
      }
      //Get.snackbar("Alerta", response);
    }catch(e){
      loading.value = false;
      return false;
    }

  }
}