import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ImageController extends GetxController {
  RxString selectedImagePath = ''.obs;

  void getImage(ImageSource imageSource) async {
    final XFile? pickedFile = await ImagePicker().pickImage(
      source: imageSource,
    );

    if (pickedFile != null) {
      //salvar o pickedFile e passar para seletedImage o arquivo salvo
      final String path = pickedFile.path;
      selectedImagePath.value = path;
      pickedFile.saveTo(path);
      pickedFile.readAsString().then((value) => selectedImagePath.value);

      print({"valor de selectedImagePath $selectedImagePath"});
    } else {
      Get.snackbar('Erro', 'Não houve imagem selecionada',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.black,
          colorText: Colors.white);
    }
  }
}
