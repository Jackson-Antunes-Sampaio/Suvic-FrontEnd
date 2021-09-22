import 'dart:convert';
import 'dart:io';

import 'package:covid_19/models/passaport_model.dart';
import 'package:covid_19/repositories/passaport_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class PassaportController extends GetxController {
  var repository = PassaportRepository();
  File? image;
  PassaportModel passaport = PassaportModel();

  PassaportController() {
    getPassaport();
  }

  getPassaport() async {
    passaport = await repository.getpassaport();
    update();
  }

  Future pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;

      final imageTemporary = File(image.path);
      this.image = imageTemporary;

      //convert in byte
      // final bytes = File(image.path).readAsBytesSync();
      // String img64 = base64Encode(bytes);
      final bytes = File(image.path).readAsBytesSync();
      var utf8s = utf8.encode(bytes.toString());
      String img64 = base64Encode(utf8s);

      //insert
      await repository.postPassaport(PassaportModel(
        civilName: passaport.civilName,
        birthdate: passaport.birthdate,
        cpf: passaport.cpf,
        email: passaport.email,
        documentFront: img64,
      ));

      update();
    } on PlatformException catch (e) {
      Get.snackbar('Erro', 'Não houve imagem selecionada',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.black,
          colorText: Colors.white);
      print('Error pick Image: $e');
    }
  }
}
