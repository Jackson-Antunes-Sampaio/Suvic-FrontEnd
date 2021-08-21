import 'package:brasil_fields/brasil_fields.dart';
import 'package:covid_19/common/button_custom.dart';
import 'package:covid_19/controllers/apply_vaccine_controller.dart';
import 'package:covid_19/screens/apply_vaccine/components/custom_expansion_tile.dart';
import 'package:covid_19/screens/credit_card/components/text_form_field.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ApplyVaccineScreen extends StatefulWidget {
  const ApplyVaccineScreen({Key? key}) : super(key: key);

  @override
  _ApplyVaccineScreenState createState() => _ApplyVaccineScreenState();
}

class _ApplyVaccineScreenState extends State<ApplyVaccineScreen> {
  final TextEditingController cpfController = TextEditingController();
  final ApplyVaccineController _applyVaccineController =
      Get.put(ApplyVaccineController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx((){
          if(_applyVaccineController.userApply.value != ''){
            return Text("${_applyVaccineController.userApply}");
          }else{
            return Text("Aplicação");
          }
        }),
        actions: [
          Obx(() {
            if (_applyVaccineController.userApply.value != '') {
              return IconButton(
                onPressed: () {
                  _applyVaccineController.userApply.value = '';
                  cpfController.text = '';
                  _applyVaccineController.stateApplyVaccine.value = StateApplyVaccine.IDLE;
                },
                icon: Icon(Icons.close),
              );
            } else {
              return Container();
            }
          })
        ],
      ),
      bottomSheet: Obx((){
        if(_applyVaccineController.userApply.value != ''){
          return Container(
            color: Colors.transparent,
            padding: EdgeInsets.symmetric(horizontal: 10),
            height: MediaQuery.of(context).size.height * 0.06,
            child: ButtonCustom(
              onPressed: (){
                _showMyDialog();
              },
              title: 'Aplicar Vacina',
            ),
          );
        }else{
          return Container(height: 1,);
        }
      }),
      body: Obx(() {
        switch (_applyVaccineController.stateApplyVaccine.value) {
          case StateApplyVaccine.IDLE:
            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    TextFormFieldCustom(
                        controller: cpfController,
                        hintText: '000.000.000-00',
                        labelText: 'CPF',
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'validar campo';
                          } else {
                            return '';
                          }
                        },
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          CpfInputFormatter()
                        ],
                        keyboardType: TextInputType.number,
                        onChanget: (value) {
                          if (value.length == 14) {
                            _applyVaccineController.userApply.value = value;
                            _applyVaccineController.stateApplyVaccine.value =
                                StateApplyVaccine.VACCINES;
                          }
                        }),
                    // SizedBox(
                    //   height: 10,
                    // ),
                    // Row(
                    //   children: [
                    //     Padding(
                    //       padding: EdgeInsets.symmetric(
                    //         horizontal: 10,
                    //       ),
                    //       child: Text("Vacina"),
                    //     ),
                    //     Expanded(
                    //         child: Container(
                    //           margin: EdgeInsets.symmetric(horizontal: 10),
                    //           padding: EdgeInsets.symmetric(horizontal: 10),
                    //           decoration: BoxDecoration(
                    //               borderRadius: BorderRadius.circular(10),
                    //               border: Border.all(color: Colors.grey)),
                    //           child: DropdownButton<String>(
                    //             value: 'One',
                    //             elevation: 16,
                    //             //style: const TextStyle(color: Colors.deepPurple),
                    //             underline: Container(
                    //               color: Colors.transparent,
                    //             ),
                    //             onChanged: (newValue) {},
                    //             items: <String>['One', 'Two', 'Free', 'Four']
                    //                 .map<DropdownMenuItem<String>>((String value) {
                    //               return DropdownMenuItem<String>(
                    //                 value: value,
                    //                 child: Text(value),
                    //               );
                    //             }).toList(),
                    //           ),
                    //         ))
                    //   ],
                    // ),
                    // SizedBox(
                    //   height: 10,
                    // ),
                    // Row(
                    //   children: [
                    //     Padding(
                    //       padding: EdgeInsets.symmetric(
                    //         horizontal: 10,
                    //       ),
                    //       child: Text("Dose   "),
                    //     ),
                    //     Expanded(
                    //       child: Container(
                    //         margin: EdgeInsets.symmetric(horizontal: 10),
                    //         padding: EdgeInsets.symmetric(horizontal: 10),
                    //         decoration: BoxDecoration(
                    //             borderRadius: BorderRadius.circular(10),
                    //             border: Border.all(color: Colors.grey)),
                    //         child: DropdownButton<String>(
                    //           value: 'Única',
                    //           elevation: 16,
                    //           //style: const TextStyle(color: Colors.deepPurple),
                    //           underline: Container(
                    //             height: 1,
                    //             color: Colors.transparent,
                    //           ),
                    //           onChanged: (newValue) {},
                    //           items: <String>['Única', '1º', '2º', '3º']
                    //               .map<DropdownMenuItem<String>>((String value) {
                    //             return DropdownMenuItem<String>(
                    //               value: value,
                    //               child: Text(value),
                    //             );
                    //           }).toList(),
                    //         ),
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    // SizedBox(
                    //   height: 10,
                    // ),
                    // Padding(
                    //   padding: EdgeInsets.symmetric(horizontal: 10),
                    //   child: ButtonCustom(
                    //       onPressed: () {
                    //
                    //       },
                    //       title: "Aplicar"),
                    // )
                  ],
                ),
              ),
            );
            break;
          case StateApplyVaccine.VACCINES:
            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  children: [
                    SizedBox(height: 10,),
                    TextFormField(
                      enabled: false,
                      initialValue:
                      'Fabiana Ap. Cruz',
                      decoration: InputDecoration(
                        labelText: 'Nome Paciente',
                        border: InputBorder.none,
                        prefixIcon: Icon(Icons.date_range),
                        enabled: false,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    CustomExpansionTile(),
                    SizedBox(
                      height: 10,
                    ),
                    ExpansionTileCard(
                      title: Text("Vacina y"),
                      initiallyExpanded: true,
                      elevation: 4,
                      initialElevation: 4,
                      children: [
                        TextFormField(
                          enabled: false,
                          initialValue:
                          '${DateFormat('dd/MM/yyyy').format(DateTime.now())}',
                          decoration: InputDecoration(
                            labelText: 'Data APlicação',
                            border: InputBorder.none,
                            prefixIcon: Icon(Icons.date_range),
                            enabled: false,
                          ),
                        ),
                        TextFormField(
                          enabled: false,
                          initialValue: 'Jackson Antunes',
                          decoration: InputDecoration(
                            labelText: 'Aplicador',
                            border: InputBorder.none,
                            prefixIcon: Icon(Icons.date_range),
                            enabled: false,
                          ),
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 10,
                              ),
                              child: Text("Dose   "),
                            ),
                            DropdownButton<String>(
                              value: _applyVaccineController.selectDose.value,
                              elevation: 16,
                              //style: const TextStyle(color: Colors.deepPurple),
                              underline: Container(
                                height: 1,
                                color: Colors.transparent,
                              ),
                              onChanged: (newValue) {
                                _applyVaccineController.selectDose.value =
                                newValue!;
                              },
                              items: <String>['Única', '1º', '2º', '3º']
                                  .map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    //ButtonCustom(onPressed: () {}, title: "Aplicar")
                  ],
                ),
              ),
            );
            break;
          case StateApplyVaccine.LOADING:
            return Center(
              child: CircularProgressIndicator(),
            );
            break;
        }
      }),
    );
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirma vacinas:'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('Vacina x'),
                Text('Vacina y'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Não'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Sim'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
