import 'package:covid_19/models/Clinic_model.dart';
import 'package:covid_19/models/user_model.dart';
import 'package:covid_19/repositories/clinicRepository.dart';
import 'package:covid_19/repositories/user_repository.dart';
import 'package:covid_19/utils/styles/style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ClinicController extends GetxController {
  //Get User Repository
  final UserRepository userRepository = UserRepository();
  var userOn = UserModel().obs;
  //Clinic Repository
  var clinicRepository = ClinicRepository();
  var clinicAdress = ''.obs;
  var clinic = ClinicModel().obs;
  //Get Instance
  static ClinicController get to => Get.find();

  ClinicController() {
    getClinicAdress();
  }
  getClinicAdress() async {
    try {
      userOn.value = await userRepository.loginGetDate();
      var clinics = await clinicRepository.getClinicById(userOn.value.clinicId);
      clinic.value = clinics!;
    } catch (e) {
      Get.snackbar(
        'Erro',
        e.toString(),
        backgroundColor: kPrimaryColor,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}
