import 'dart:io';
import 'dart:ui';

import 'package:covid_19/controllers/passaport_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

// ignore: must_be_immutable
class Passaport extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text('Comprovante Covid-19'),
        centerTitle: true,
      ),
      body: Container(
        child: GetBuilder<PassaportController>(
            init: PassaportController(),
            builder: (controller) {
              return Column(
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
                      child: controller.image == null
                          ? Center(
                              child: Text(
                              'No image selected',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ))
                          // : Image.asset(_imageController.selectedImagePath.value);
                          : InteractiveViewer(
                              child: Image.file(
                                File(controller.image!.path),
                              ),
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
                                  controller.pickImage(ImageSource.camera);
                                  Get.back();
                                });
                          },
                          child: Text('Camera')),
                      ElevatedButton(
                          onPressed: () {
                            controller.pickImage(ImageSource.gallery);
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



// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:image_picker/image_picker.dart';

// class Passaport extends StatefulWidget {
//   const Passaport({Key? key}) : super(key: key);

//   @override
//   _PassaportState createState() => _PassaportState();
// }

// class _PassaportState extends State<Passaport> {
//   File? image;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.spaceAround,
//         children: [
//           image == null
//               ? Text('Select Image')
//               : Image.file(
//                   image!,
//                   width: double.maxFinite,
//                   height: 300,
//                   fit: BoxFit.cover,
//                 ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: [
//               ElevatedButton(
//                 onPressed: () {
//                   pickImage(ImageSource.camera);
//                 },
//                 child: Text('Pick'),
//               ),
//               ElevatedButton(
//                 onPressed: () {
//                   pickImage(ImageSource.gallery);
//                 },
//                 child: Text('Galerias'),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }






// import 'dart:io';

// import 'package:covid_19/controllers/passaport_controller.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:image_picker/image_picker.dart';

// // ignore: must_be_immutable
// class Passaport extends StatelessWidget {
//   ImageController _imageController = Get.put(ImageController());

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//         child: Scaffold(
//       appBar: AppBar(
//         title: Text('Comprovante Covid-19'),
//         centerTitle: true,
//       ),
//       body: Container(
//         child: Column(
//           children: [
//             Expanded(
//               child: Container(
//                 decoration: BoxDecoration(
//                   border: Border.all(
//                     color: Colors.blueAccent.shade100,
//                     width: 8,
//                   ),
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 child: Obx(() {
//                   return _imageController.selectedImagePath.value == ''
//                       ? Center(
//                           child: Text(
//                           'No image selected',
//                           style: TextStyle(fontWeight: FontWeight.bold),
//                         ))
//                       // : Image.asset(_imageController.selectedImagePath.value);
//                       : Image.file(
//                           File(_imageController.selectedImagePath.value));
//                 }),
//               ),
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 ElevatedButton(
//                     onPressed: () {
//                       _imageController.getImage(ImageSource.camera);
//                     },
//                     child: Text('Camera')),
//                 ElevatedButton(
//                     onPressed: () {
//                       _imageController.getImage(ImageSource.gallery);
//                     },
//                     child: Text('Galeria')),
//               ],
//             )
//           ],
//         ),
//       ),
//     ));
//   }
// }
