import 'dart:io';

import 'package:suvic_app/controllers/old_vacination_card_controller.dart';
import 'package:suvic_app/utils/styles/style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

// ignore: must_be_immutable
class OldVaccinationCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text('Carteira Antiga'),
        centerTitle: true,
      ),
      body: Container(
        child: GetBuilder<OldVaccinationCardController>(
            init: OldVaccinationCardController(),
            builder: (controller) {
              return controller.loading
                  ? Center(
                      child: CircularProgressIndicator(
                        color: kPrimaryColor,
                      ),
                    )
                  : Column(
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.blueAccent.shade100,
                                width: 8,
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: controller.imageByte == null
                                ? controller.image == null
                                    ? Center(
                                        child: Text(
                                        'Nenhuma imagem selecionada',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ))
                                    // : Image.asset(_imageController.selectedImagePath.value);
                                    : InteractiveViewer(
                                        child: Image.file(
                                          File(controller.image!.path),
                                          width: double.maxFinite,
                                          height: double.maxFinite,
                                        ),
                                      )
                                : Image.memory(
                                    controller.imageByte!,
                                    width: double.maxFinite,
                                    height: double.maxFinite,
                                    fit: BoxFit.fill,
                                  ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ElevatedButton(
                                onPressed: () {
                                  Get.defaultDialog(
                                      radius: 8,
                                      title: 'Declaração de responsabilidade',
                                      titleStyle: TextStyle(fontSize: 16),
                                      middleText:
                                          'Declaro, para os devidos fins de direito, sob as pena da lei, que as informações prestadas e documentos anexados são verdadeiros e autênticos.',
                                      textCancel: 'Cancelar',
                                      textConfirm: 'Confirma',
                                      confirmTextColor: Colors.white,
                                      onConfirm: () {
                                        controller
                                            .pickImage(ImageSource.camera);
                                        Get.back();
                                      });
                                },
                                child: Text('Camera')),
                            ElevatedButton(
                                onPressed: () {
                                  Get.defaultDialog(
                                      radius: 8,
                                      title: 'Declaração de responsabilidade',
                                      titleStyle: TextStyle(fontSize: 16),
                                      middleText:
                                          'Declaro, para os devidos fins de direito, sob as pena da lei, que as informações prestadas e documentos anexados são verdadeiros e autênticos.',
                                      textCancel: 'Cancelar',
                                      textConfirm: 'Confirma',
                                      confirmTextColor: Colors.white,
                                      onConfirm: () {
                                        controller
                                            .pickImage(ImageSource.gallery);
                                        Get.back();
                                      });
                                },
                                child: Text('Galeria')),
                          ],
                        )
                      ],
                    );
            }),
      ),
    ));
  }
}
