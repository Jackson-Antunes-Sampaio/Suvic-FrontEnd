import 'package:brasil_fields/brasil_fields.dart';
import 'package:suvic_app/common/button_custom.dart';
import 'package:suvic_app/controllers/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'components/input_text_field.dart';
import 'components/label_text.dart';

class SingUp extends StatefulWidget {
  SingUp({Key? key}) : super(key: key);

  @override
  _SingUpState createState() => _SingUpState();
}

class _SingUpState extends State<SingUp> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController cpfController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  final TextEditingController confirmPassController = TextEditingController();
  final TextEditingController birthdateController = TextEditingController();
  String? sexController;
  final UserController userController = UserController();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text("Criar conta"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: Form(
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                child: labelText('Nome:'),
              ),
              InputTextField(
                controller: nameController,
                hintText: "Nome",
                obscureText: false,
              ),
              SizedBox(
                height: 5,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                child: labelText('CPF:'),
              ),
              InputTextField(
                controller: cpfController,
                textInputType: TextInputType.number,
                textInputFormatter: [
                  FilteringTextInputFormatter.digitsOnly,
                  CpfInputFormatter(),
                ],
                hintText: "CPF",
                obscureText: false,
              ),
              SizedBox(
                height: 5,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                child: labelText('Email:'),
              ),
              InputTextField(
                controller: emailController,
                hintText: "Email",
                textInputType: TextInputType.emailAddress,
                obscureText: false,
              ),
              SizedBox(
                height: 5,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                child: labelText('Data de nascimento:'),
              ),
              InputTextField(
                controller: birthdateController,
                textInputFormatter: [
                  FilteringTextInputFormatter.digitsOnly,
                  DataInputFormatter()
                ],
                hintText: "21/04/1993",
                textInputType: TextInputType.number,
                obscureText: false,
              ),
              SizedBox(
                height: 5,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                child: labelText('Sexo:'),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(16, 3, 16, 6),
                child: DropdownButton<String>(
                  hint: Text("Selecione uma op????o"),
                  value: sexController,
                  elevation: 16,
                  isExpanded: true,
                  //style: const TextStyle(color: Colors.deepPurple),
                  underline: Container(
                    height: 1,
                    color: Colors.transparent,
                  ),
                  onChanged: (newValue) {
                    setState(() {
                      sexController = newValue;
                    });
                  },
                  items: ["M", "F", "N??o especificado"]
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value == "M"
                          ? "Masculino"
                          : value == "F"
                              ? "Feminino"
                              : value),
                    );
                  }).toList(),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                child: labelText('Senha:'),
              ),
              InputTextField(
                controller: passController,
                hintText: "*******",
                obscureText: true,
              ),
              Align(
                  alignment: Alignment.centerRight,
                  child: Text('Minimo de 8 digitos',style: TextStyle(fontSize: 10),)),
              SizedBox(
                height: 5,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                child: labelText('Confirmar Senha:'),
              ),
              InputTextField(
                controller: confirmPassController,
                hintText: "*******",
                obscureText: true,
              ),
              Align(
                  alignment: Alignment.centerRight,
                  child: Text('Minimo de 8 digitos',style: TextStyle(fontSize: 10),)),
              SizedBox(
                height: 20,
              ),
              Obx(() {
                if (userController.loading.value) {
                  return Align(
                    alignment: Alignment.centerRight,
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return ButtonCustom(
                    onPressed: () async {
                      print("come??o");
                      bool status = await userController.singUp(
                          nameController.text,
                          emailController.text,
                          cpfController.text,
                          passController.text,
                          confirmPassController.text,
                          birthdateController.text,
                          sexController == "N??o especificado" ? "NS" : sexController
                      );
                      if (status) {
                        print("foi ${status}");
                        scaffoldKey.currentState?.showSnackBar(
                          SnackBar(
                            content: Text("${userController.message}"),
                          ),
                        );
                        await Future.delayed(Duration(seconds: 2));
                        nameController.text = "";
                        emailController.text = "";
                        cpfController.text = "";
                        passController.text = "";
                        confirmPassController.text = "";
                        birthdateController.text = "";
                        Get.back();
                      } else {
                        print("n??o foi ${status}");
                        scaffoldKey.currentState?.showSnackBar(
                          SnackBar(
                            content: Text(
                              "${userController.message}",
                            ),
                            backgroundColor: Colors.red,
                          ),
                        );
                      }
                    },
                    title: "Cadastra-se",
                  );
                }
              })
            ],
          ),
        ),
      ),
    );
  }
}
