import 'package:covid_19/common/button_custom.dart';
import 'package:flutter/material.dart';

import 'components/input_text_field.dart';
import 'components/label_text.dart';

class SingUp extends StatefulWidget {
  const SingUp({Key? key}) : super(key: key);

  @override
  _SingUpState createState() => _SingUpState();
}

class _SingUpState extends State<SingUp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                hintText: "Email",
                obscureText: false,
              ),
              SizedBox(
                height: 5,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                child: labelText('Senha:'),
              ),
              InputTextField(
                hintText: "*******",
                obscureText: true,
              ),
              SizedBox(
                height: 5,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                child: labelText('Confirma Senha:'),
              ),
              InputTextField(
                hintText: "*******",
                obscureText: true,
              ),
              SizedBox(height: 20,),
              ButtonCustom(
                  onPressed: (){},
                  title: "Cadastra-se",
              )
            ],
          ),
        ),
      ),
    );
  }
}
