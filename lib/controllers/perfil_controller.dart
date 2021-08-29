

import 'package:covid_19/repositories/user_repository.dart';
import 'package:get/get.dart';

enum StatePerfil {IDL, LOADING}

class PerfilController extends GetxController{
  Rx<StatePerfil> statePerfil = StatePerfil.IDL.obs;

  Future putUser()async{
    statePerfil.value = StatePerfil.LOADING;
    final UserRepository userRepository = UserRepository();
    us

  }

}