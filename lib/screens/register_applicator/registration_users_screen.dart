import 'package:brasil_fields/brasil_fields.dart';
import 'package:covid_19/common/botton_navigation_bar/bottom_navigation_bar_new.dart';
import 'package:covid_19/common/button_custom.dart';
import 'package:covid_19/common/text_fiel_custom.dart';
import 'package:covid_19/controllers/register_applicator_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class RegisterApplicator extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final RegisterApplicatorController registerApplicatorController =
      Get.put(RegisterApplicatorController());
  final TextEditingController cpfController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      bottomNavigationBar: BottomNavigationBarNew(),
      appBar: AppBar(
        title: Text("Cadastrar Aplicador"),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextFieldCustom(
                        controller: cpfController,
                        iconData: Icons.list,
                        hintText: '000.000.000-00',
                        labelText: 'CPF',
                        textInputType: TextInputType.number,
                        onChanged: (text) {},
                        textInputFormatter: [
                          FilteringTextInputFormatter.digitsOnly,
                          CpfInputFormatter(),
                        ],
                        validator: (text) {
                          if (text?.length != 14) {
                            return 'Validar Campo';
                          } else {
                            return null;
                          }
                        },
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    RaisedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          registerApplicatorController
                              .postRegisterApplicator(cpfController.text
                                  .replaceAll(".", "")
                                  .replaceAll("-", ""))
                              .then((value) {
                            if (value) {
                              _scaffoldKey.currentState!.showSnackBar(
                                SnackBar(content: Text("Aplicador cadastrado com sucesso."))
                              );
                            } else {
                              _scaffoldKey.currentState!.showSnackBar(
                                  SnackBar(content: Text("Usuario não encontrado no banco de dados."), backgroundColor: Colors.red,)
                              );
                            }
                          });
                        } else {
                          _scaffoldKey.currentState!.showSnackBar(SnackBar(
                            content: Text(
                              "CPF incompleto",
                            ),
                            backgroundColor: Colors.red,
                          ));
                        }
                      },
                      color: Theme.of(context).primaryColor,
                      textColor: Colors.white,
                      child: Text("Cadastrar"),
                    )
                  ],
                ),
                // SizedBox(height: 10,),
                // ButtonCustom(
                //   title: "Enviar",
                //   onPressed: (){
                //     if(formKey.currentState!.validate()){
                //       print("Ok");
                //     }
                //   },
                // )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
