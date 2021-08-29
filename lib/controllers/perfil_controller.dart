

import 'package:covid_19/models/user_model.dart';
import 'package:covid_19/repositories/user_repository.dart';
import 'package:get/get.dart';

enum StatePerfil {IDL, LOADING, ADDRESS}

class PerfilController extends GetxController{
  Rx<StatePerfil> statePerfil = StatePerfil.IDL.obs;

  Future<bool> putUser(UserModel user)async{
    try {
      statePerfil.value = StatePerfil.LOADING;
      final UserRepository userRepository = UserRepository();
      return await userRepository.putUser(user.toJson()).then((value){
        if(value){
          statePerfil.value = StatePerfil.IDL;
          return true;
        }else{
          statePerfil.value = StatePerfil.IDL;
          return false;
        }

      });

    }catch(e){
      return false;
    }
  }

}