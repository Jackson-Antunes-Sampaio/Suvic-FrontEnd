

import 'package:covid_19/models/user_model.dart';
import 'package:covid_19/repositories/user_repository.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';

enum StatePerfil {IDL, LOADING, ADDRESS}

class PerfilController extends GetxController{
  Rx<StatePerfil> statePerfil = StatePerfil.IDL.obs;
  RxList<String> listbloodType = <String>[
    "A+", "A-", "B+", "B-", "O+", "O-", "AB+", "AB-"
  ].obs;

  Map<String, String> mapState = {
  "Alagoas" : "AL",
  "Amapá" : "AP",
  "Amazonas" : "AM",
  "Bahia" : "BA",
  "Ceará" : "CE",
  "Distrito Federal" : "DF",
  "Espírito Santo" : "ES",
  "Goiás" : "GO",
  "Maranhão" : "MA",
  "Mato Grosso" : "MT",
  "Mato Grosso do Sul" : "MS",
  "Minas Gerais" : "MG",
  "Pará" : "PA",
  "Paraíba" : "PB",
  "Paraná" : "PR",
  "Pernambuco" : "PE",
  "Piauí" : "PI",
  "Rio de Janeiro" : "RJ",
  "Rio Grande do Norte" : "RN",
  "Porto Alegre" : "RS",
  "Roraima" : "RR",
  "Santa Catarina" : "SC",
  "São Paulo" : "SP",
  "Sergipe" : "SE",
  "Tocantins" : "TO",
  };


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

  getAddress(String zipCode)async{

    try{
      List<Location> locations = await locationFromAddress(zipCode);
      List<Placemark> placemarks = await placemarkFromCoordinates(locations.first.latitude, locations.first.longitude);
      //print(placemarks);
      return placemarks.first.toJson();
    }catch(e){
      print("erro");
    }
  }

}