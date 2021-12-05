import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:suvic_app/models/passaport_model.dart';
import 'package:suvic_app/repositories/old_vaccination_card_repository.dart';

class OldVaccinationCardController extends GetxController {
  var repository = OldVaccinationCardRepository();
  File? image;
  Uint8List? imageByte;
  PassaportModel passaport = PassaportModel();

  bool loading = false;

  OldVaccinationCardController() {
    getOldVaccinationCard();
  }

  getOldVaccinationCard() async {
    print('GET CARTEIRA ANTIGA');
    loading = true;
    var resPassaport = await repository.getCard();

    if (resPassaport != null) {
      var byteEnconde = resPassaport['paperCard']['data'];
      print('RESPONSE ===>${resPassaport['paperCard']['data']}');
      List<int> bytes = [];

      if (byteEnconde != null) {
        byteEnconde.forEach((byte) {
          bytes.add(byte);
        });
      }

      if (bytes.isNotEmpty) {
        imageByte = base64Decode(utf8.decode(bytes));
        print('SUCESSO ImageByte $imageByte');
      }
    }
    loading = false;

    update();
  }

  Future pickImage(ImageSource source) async {
    print('INICIANDO PICKIMAGE');
    print('SOURCE RECEBIDO ====> $source');
    try {
      loading = true;

      final image = await ImagePicker().pickImage(source: source);
      print('IMAGE ===> $image');
      //if (image == null) return;

      final imageTemporary = File(image!.path);
      this.image = imageTemporary;

      imageByte = null;

      //convert in byte
      final bytes = File(image.path).readAsBytesSync();
      var utf8s = bytes.toList();
      String img64 = base64Encode(utf8s);
      print('IMAGE BASE 64 ====> $img64');
      //insert
      await repository.insert(PassaportModel(
        documentFront: img64,
      ));
      Get.snackbar('Concluído', 'Imagem carregada com sucesso',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white);
      loading = false;

      update();
    } on PlatformException catch (e) {
      Get.snackbar('Erro', 'Não foi possível selecionar a imagem!',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.black,
          colorText: Colors.white);
      print('Error pick Image: $e');
    }
  }
}
