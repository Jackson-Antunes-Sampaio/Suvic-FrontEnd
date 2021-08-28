import 'package:brasil_fields/brasil_fields.dart';
import 'package:covid_19/common/icon_button_custom.dart';
import 'package:covid_19/common/text_fiel_custom.dart';
import 'package:covid_19/screens/profile/components/header.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController rgController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    rgController.text = "44.444.";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Perfil"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              Header(),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text("Alterar senha"),
                  Icon(Icons.keyboard_arrow_right)
                ],
              ),
              SizedBox(height: 10,),
              TextFieldCustom(
                controller: null,
                hintText: "Nome",
                labelText: "Nome",
                validator: (value){
                  if(value!.length < 5){
                    return 'Campo inválido';
                  }else{
                    return null;
                  }
                },
              ),
              SizedBox(height: 10,),
              TextFieldCustom(
                controller: null,
                hintText: "Email",
                labelText: "Email",
                validator: (value){
                  if(value!.length < 5){
                    return 'Campo inválido';
                  }else{
                    return null;
                  }
                },
              ),
              SizedBox(height: 10,),
              TextFieldCustom(
                //initialValue: "444444444444",
                controller: rgController,
                hintText: "RG",
                labelText: "RG",
                textInputFormatter: [
                  MaskTextInputFormatter(mask: "##.###.###-#")
                ],
                validator: (value){
                  if(value?.length == 12 || value?.length == 0){
                    return null;
                  }else{
                    return 'Campo inválido';
                  }
                },
              ),
              SizedBox(height: 10,),
              TextFieldCustom(
                controller: null,
                textInputType: TextInputType.number,
                hintText: "CPF",
                labelText: "CPF",
                textInputFormatter: [
                  FilteringTextInputFormatter.digitsOnly,
                  CpfInputFormatter(),
                ],
                validator: (value){
                  if(value?.length == 14){
                    return null;
                  }else{
                    return 'Campo inválido';
                  }
                },
              ),
              SizedBox(height: 10,),
              TextFieldCustom(
                controller: null,
                textInputType: TextInputType.number,
                hintText: "Data nascimento",
                labelText: "Data nascimento",
                textInputFormatter: [
                  FilteringTextInputFormatter.digitsOnly,
                  DataInputFormatter(),
                ],
                validator: (value){
                  if(value?.length == 10){
                    return null;
                  }else{
                    return 'Campo inválido';
                  }
                },
              ),
              SizedBox(height: 10,),
              TextFieldCustom(
                controller: null,
                textInputType: TextInputType.number,
                hintText: "Genero",
                labelText: "Genero",
                textInputFormatter: [
                  FilteringTextInputFormatter.digitsOnly,
                  DataInputFormatter(),
                ],
                validator: (value){
                  if(value?.length == 10){
                    return null;
                  }else{
                    return 'Campo inválido';
                  }
                },
              ),
              SizedBox(height: 10,),
              TextFieldCustom(
                controller: null,
                textInputType: TextInputType.number,
                hintText: "Profissional da saúde",
                labelText: "Profissional da saúde",
                textInputFormatter: [
                  FilteringTextInputFormatter.digitsOnly,
                  DataInputFormatter(),
                ],
                validator: (value){
                  if(value?.length == 10){
                    return null;
                  }else{
                    return 'Campo inválido';
                  }
                },
              ),
              SizedBox(height: 10,),
              TextFieldCustom(
                controller: null,
                textInputType: TextInputType.number,
                hintText: "Tipo sanguineo",
                labelText: "Tipo sanguineo",
                textInputFormatter: [
                  FilteringTextInputFormatter.digitsOnly,
                  DataInputFormatter(),
                ],
                validator: (value){
                  if(value?.length == 10){
                    return null;
                  }else{
                    return 'Campo inválido';
                  }
                },
              ),
              SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text("Alterar Endereço"),
                  Icon(Icons.keyboard_arrow_right)
                ],
              ),
              SizedBox(height: 60,),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Theme.of(context).primaryColor,
          onPressed: (){},
          label: Row(
            children: [
              Icon(Icons.save),
              SizedBox(width: 2,),
              Text("Salvar")
            ],
          )),
    );
  }
}
