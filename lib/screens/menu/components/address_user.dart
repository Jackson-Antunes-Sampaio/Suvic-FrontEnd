import 'package:brasil_fields/brasil_fields.dart';
import 'package:covid_19/common/button_custom.dart';
import 'package:covid_19/common/text_fiel_custom.dart';
import 'package:covid_19/controllers/perfil_controller.dart';
import 'package:covid_19/controllers/user_controller.dart';
import 'package:covid_19/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';


class AddressUser extends StatefulWidget {
  const AddressUser({Key? key, required this.user}) : super(key: key);

  final UserModel user;

  @override
  _AddressUserState createState() => _AddressUserState();
}

class _AddressUserState extends State<AddressUser> {

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final PerfilController perfilController = Get.find();

  final TextEditingController streetController = TextEditingController();
  final TextEditingController streetNumberController = TextEditingController();
  final TextEditingController zipCodeController = TextEditingController();
  final TextEditingController neighborhoodController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController stateController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    streetController.text = widget.user.addressStreetName ?? '';
    streetNumberController.text = widget.user.addressNumber ?? '';
    zipCodeController.text = widget.user.addressZip ?? '';
    neighborhoodController.text = widget.user.addressDistrict ?? '';
    cityController.text = widget.user.addressCity ?? '';
    stateController.text = widget.user.addressState ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              TextFieldCustom(
                controller: zipCodeController,
                hintText: 'CEP',
                labelText: 'CEP',
                validator: (value) {
                  if (value!.isEmpty) {
                    return null;
                  } else {
                    String newValue = value.replaceAll(".", "").replaceAll("-", "").replaceAll(" ", "");
                    if(newValue.length == 8){
                      return null;
                    }else{
                      return 'Campo inválido';
                    }
                  }
                },
                textInputFormatter: [
                  FilteringTextInputFormatter.digitsOnly,
                  CepInputFormatter()
                ],
                textInputType: TextInputType.number,
              ),
              SizedBox(height: 10,),
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: TextFieldCustom(
                      controller: streetController,
                      hintText: 'Av. Paulista',
                      labelText: 'Endereço',
                      validator: (text) {
                        if (text!.isEmpty) {
                          return 'Inválido';
                        } else {
                          return null;
                        }
                      },
                      textInputFormatter: [],
                      textInputType: TextInputType.text,

                    ),
                  ),
                  SizedBox(width: 10,),
                  Expanded(
                    child: TextFieldCustom(
                      controller: streetNumberController,
                      hintText: '111',
                      labelText: 'Número',
                      validator: (text) {
                        if (text!.isEmpty) {
                          return 'Inválido';
                        } else {
                          return null;
                        }
                      },
                      textInputFormatter: [],
                      textInputType: TextInputType.number,
                    ),
                  )
                ],
              ),
              SizedBox(height: 10,),
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: TextFieldCustom(
                      controller: neighborhoodController,
                      hintText: 'Centro',
                      labelText: 'Bairro',
                      validator: (text) {
                        if (text!.isEmpty) {
                          return 'Inválido';
                        } else {
                          return null;
                        }
                      },
                      textInputFormatter: [],
                      textInputType: TextInputType.text,
                    ),
                  ),
                  SizedBox(width: 10,),
                  Expanded(
                    flex: 2,
                    child: TextFieldCustom(
                      controller: cityController,
                      hintText: 'São Paulo',
                      labelText: 'Cidade',
                      validator: (text) {
                        if (text!.isEmpty) {
                          return 'Inválido';
                        } else {
                          return null;
                        }
                      },
                      textInputFormatter: [],
                      textInputType: TextInputType.text,
                    ),
                  ),
                  SizedBox(width: 10,),
                  Expanded(
                      child: TextFieldCustom(
                        controller: stateController,
                        hintText: 'SP',
                        labelText: 'Estado',
                        validator: (text) {
                          if (text!.isEmpty) {
                            return 'Inválido';
                          } else {
                            return null;
                          }
                        },
                        textInputFormatter: [
                          LengthLimitingTextInputFormatter(2),
                        ],
                        textInputType: TextInputType.text,
                      )),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              ButtonCustom(
                  onPressed: ()async{
                    UserModel userModel = widget.user;

                    if(formKey.currentState!.validate()){
                      widget.user.addressStreetName = streetController.text;
                      widget.user.addressNumber = streetNumberController.text;
                      widget.user.addressZip = zipCodeController.text.replaceAll(".", "").replaceAll("-", "");
                      widget.user.addressDistrict = neighborhoodController.text;
                      widget.user.addressCity = cityController.text;
                      widget.user.addressState = stateController.text;
                      perfilController.putUser(widget.user).then((value)async{
                        if(value){
                          //await _showMyDialog("Sucesspo", "Endereço alterado.");
                        }else{
                          //await _showMyDialog("Erro", "Erro ao salvar endereço.");
                        }
                      });

                    }else{
                      //await _showMyDialog("Alerta", "Verifique os campos inválido.");
                    }
                  },
                  title: "Salvar Endereço")
            ],
          ),
        ));
  }

  Future<void> _showMyDialog(String title, String message) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('$title'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('$message'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Ok'),
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

