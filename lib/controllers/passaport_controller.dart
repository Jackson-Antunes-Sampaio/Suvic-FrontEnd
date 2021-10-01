import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:covid_19/models/passaport_model.dart';
import 'package:covid_19/repositories/passaport_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class PassaportController extends GetxController {
  var repository = PassaportRepository();
  File? image;
  Uint8List? imageByte;
  PassaportModel passaport = PassaportModel();

  bool loading = false;

  PassaportController() {
    getPassaport();
  }

  getPassaport() async {
    loading = true;
    var resPassaport = await repository.getpassaport();

    if (resPassaport != null) {
      var byteEnconde = resPassaport['data'];
      List<int> bytes = [];

      byteEnconde.forEach((byte) {
        bytes.add(byte);
      });

      if (bytes.isNotEmpty) {
        imageByte = base64Decode(utf8.decode(bytes));
      }
    }
    loading = false;

    update();
  }

  Future pickImage(ImageSource source) async {
    try {
      loading = true;

      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;

      final imageTemporary = File(image.path);
      this.image = imageTemporary;

      imageByte = null;

      //convert in byte
      final bytes = File(image.path).readAsBytesSync();
      // var utf8s = utf8.encode(bytes.toString());
      var utf8s = bytes.toList();
      String img64 = base64Encode(utf8s);

      //insert
      await repository.postPassaport(PassaportModel(
        civilName: passaport.civilName,
        birthdate: passaport.birthdate,
        cpf: passaport.cpf,
        email: passaport.email,
        documentFront: img64,
      ));

      loading = false;
      Get.snackbar('Concluído', 'Imagem carregada com sucesso',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white);
      update();
    } on PlatformException catch (e) {
      Get.snackbar('Erro', 'Não houve imagem selecionada',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
      print('Error pick Image: $e');
    }
  }
}
