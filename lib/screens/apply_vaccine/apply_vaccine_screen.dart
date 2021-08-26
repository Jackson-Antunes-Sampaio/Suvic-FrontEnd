import 'package:brasil_fields/brasil_fields.dart';
import 'package:covid_19/common/button_custom.dart';
import 'package:covid_19/controllers/apply_vaccine_controller.dart';
import 'package:covid_19/controllers/user_controller.dart';
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
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final UserController _userController = Get.find();
  final ApplyVaccineController _applyVaccineController =
  Get.put(ApplyVaccineController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Obx(() {
          if(_applyVaccineController.listvaccines.isNotEmpty){
            if(_applyVaccineController.listvaccines.first.user?.civilName != '') {
              return Text("${cpfController.text}");
            } else {
              return Text("Aplicação");
            }
          }else{
            return Text("Aplicação");
          }
        }),
        actions: [
          Obx(() {
            if(_applyVaccineController.listvaccines.isNotEmpty){
              if (_applyVaccineController.listvaccines.first.user!.civilName != '') {
                return IconButton(
                  onPressed: () {
                    _applyVaccineController.listvaccines.first.user!.civilName =
                    '';
                    cpfController.text = '';
                    _applyVaccineController.stateApplyVaccine.value =
                        StateApplyVaccine.IDLE;
                  },
                  icon: Icon(Icons.close),
                );
              } else {
                return Container();
              }
            }else{
              return Container();
            }

          })
        ],
      ),
      bottomSheet: Obx(() {
        if(_applyVaccineController.listvaccines.isNotEmpty){
          if (_applyVaccineController.listvaccines.first.user!.civilName != '') {
            return Container(
              color: Colors.transparent,
              padding: EdgeInsets.symmetric(horizontal: 10),
              height: MediaQuery
                  .of(context)
                  .size
                  .height * 0.06,
              child: ButtonCustom(
                onPressed: () async{
                  if(_formKey.currentState != null){
                    if(_formKey.currentState!.validate()){
                      await _showMyDialog();
                    }else{
                      print("aquii");
                      scaffoldKey.currentState!.showSnackBar(
                          SnackBar(content: Text("Preencha os campos obrigatórios"))
                      );
                    }
                  }
                },
                title: 'Aplicar Vacina',
              ),
            );
          } else {
            return Container(height: 1,);
          }
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
                            _applyVaccineController.postUserVaccine(value.replaceAll(".", "").replaceAll("-", ""));
                            //_applyVaccineController.userApply.value = value;
                            //_applyVaccineController.stateApplyVaccine.value = StateApplyVaccine.VACCINES;
                          }
                        }),
                    SizedBox(height: 30,),
                    Image.asset("assets/images/clinic.jpeg"),
                  ],
                ),
              ),
            );
            break;
          case StateApplyVaccine.VACCINES:
            return SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    children: [
                      SizedBox(height: 10,),
                      TextFormField(
                        enabled: false,
                        initialValue: '${_applyVaccineController.listvaccines.first.user!.civilName}',
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
                      //CustomExpansionTile(),
                      SizedBox(
                        height: 10,
                      ),
                      Column(
                        children: _applyVaccineController.listvaccines.map((
                            e) {
                          return Column(
                            children: [
                              ExpansionTileCard(
                                title: Text("${e.vaccineName}"),
                                initiallyExpanded: true,
                                elevation: 4,
                                initialElevation: 4,
                                children: [
                                  TextFormField(
                                    enabled: false,
                                    initialValue:
                                    '${DateFormat('dd/MM/yyyy').format(
                                        DateTime.now())}',
                                    decoration: InputDecoration(
                                      labelText: 'Data APlicação',
                                      border: InputBorder.none,
                                      prefixIcon: Icon(Icons.date_range),
                                      enabled: false,
                                    ),
                                  ),
                                  TextFormField(
                                    enabled: false,
                                    initialValue: '${_userController.user?.civilName}',
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
                                      DropdownButton<int>(
                                        value: e.vaccine!.dose,
                                        elevation: 16,
                                        //style: const TextStyle(color: Colors.deepPurple),
                                        underline: Container(
                                          height: 1,
                                          color: Colors.transparent,
                                        ),
                                        onChanged: (newValue) {
                                          e.vaccine!.dose = newValue!;
                                          setState(() {

                                          });
                                        },
                                        items: e.vaccine?.listDose
                                            ?.map<DropdownMenuItem<int>>((int value) {
                                          return DropdownMenuItem<int>(
                                            value: value,
                                            child: Text(value.toString()),
                                          );
                                        }).toList(),
                                      )
                                    ],
                                  ),
                                  e.vaccine?.name == "COVID-19"
                                  ? TextFormField(
                                    onChanged: (value){
                                      e.vaccine?.manufacturer = value;
                                    },
                                    decoration: InputDecoration(
                                      labelText: 'Fabricante',
                                      border: InputBorder.none,
                                      prefixIcon: Icon(Icons.corporate_fare),
                                    ),
                                    validator: (value){
                                      if(value!.isEmpty){
                                        if(e.vaccineName == "COVID-19"){
                                          return "Campo inválido";
                                        }else{
                                          return null;
                                        }

                                      }else{
                                        return null;
                                      }
                                    },
                                  ) : Container(),
                                  SizedBox(
                                    height: 10,
                                  )
                                ],
                              ),
                              SizedBox(height: 10,),
                            ],
                          );
                        }).toList(),
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      //ButtonCustom(onPressed: () {}, title: "Aplicar")
                    ],
                  ),
                ),
              ),
            );
            break;
          case StateApplyVaccine.LOADING:
            return Center(
              child: CircularProgressIndicator(),
            );
            break;
          case StateApplyVaccine.ERROR:
            return Center(
              child: Text("Erro"),
            );
          case StateApplyVaccine.SUCCESS:
            return Center(
              child: Text("Sucesso"),
            );
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
              children: _applyVaccineController.listvaccines.map((element){
                return Text('${element.vaccineName}');
              }).toList(),
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
              onPressed: () async{
                Navigator.of(context).pop();
                await _applyVaccineController.postApplyVaccine();
              },
            ),
          ],
        );
      },
    );
  }
}
