

import 'package:get/get.dart';

class NotifyCovidController extends GetxController{

  RxString selectUf = "Estado".obs;
  RxBool selectNotify = true.obs;

  List<String> stateUf = [
    "Estado",
    "SP",
    "AC",
    "AL",
    "AP",
    "AM",
    "BA",
    "CE",
    "DF",
    "ES",
    "GO",
    "MA",
    "MT",
    "MS",
    "MG",
    "PA",
    "PB",
    "PR",
    "PE",
    "PI",
    "RJ",
    "RN",
    "RS",
    "RO",
    "RR",
    "SC",
    "SE",
    "TO",
  ];

}