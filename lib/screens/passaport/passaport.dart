import 'package:covid_19/controllers/passaport_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class Passaport extends StatelessWidget {
  final _imageController = ImageController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text('Comprovante Covid-19'),
        centerTitle: true,
      ),
      body: Container(
        child: Column(
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
                child: Obx(() {
                  return _imageController.selectedImagePath.value == ''
                      ? Center(
                          child: Text(
                          'No image selected',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ))
                      : Image.asset(_imageController.selectedImagePath.value);
                }),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                    onPressed: () {
                      _imageController.getImage(ImageSource.camera);
                    },
                    child: Text('Camera')),
                ElevatedButton(
                    onPressed: () {
                      _imageController.getImage(ImageSource.gallery);
                    },
                    child: Text('Galeria')),
              ],
            )
          ],
        ),
      ),
    ));
  }
}
