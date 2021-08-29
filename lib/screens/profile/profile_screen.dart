import 'package:brasil_fields/brasil_fields.dart';
import 'package:covid_19/common/icon_button_custom.dart';
import 'package:covid_19/common/text_fiel_custom.dart';
import 'package:covid_19/controllers/perfil_controller.dart';
import 'package:covid_19/controllers/user_controller.dart';
import 'package:covid_19/screens/profile/components/header.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  final UserController userController = Get.find();
  final PerfilController perfilController = Get.put(PerfilController());
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController rgController = TextEditingController();
  final TextEditingController cpfController = TextEditingController();
  final TextEditingController birthdateController = TextEditingController();
  final TextEditingController sexController = TextEditingController();
  final TextEditingController healthProfessionalController = TextEditingController();
  final TextEditingController bloodTypeController = TextEditingController();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    perfilController.statePerfil.value = StatePerfil.IDL;
    nameController.text = userController.user?.civilName ?? '';
    emailController.text = userController.user?.email ?? '';
    rgController.text = userController.user?.rg.toString() ?? '';
    cpfController.text = userController.user?.cpf ?? '';
    birthdateController.text = userController.user!.birthdate == null ? '' : DateFormat("dd/MM/yyyy").format(DateTime.parse(userController.user!.birthdate!));
    sexController.text = userController.user?.sex ?? '';
    healthProfessionalController.text = userController.user!.healthProfessional! ? 'Sim'  : 'Não';
    bloodTypeController.text = userController.user?.bloodType ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Perfil"),
      ),
      body: Obx((){
        switch(perfilController.statePerfil.value){
          case StatePerfil.IDL:
            return SingleChildScrollView(
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
                      controller: nameController,
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
                      controller: emailController,

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
                      controller: cpfController,
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
                      controller: birthdateController,
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
                      controller: sexController,
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
                      controller: healthProfessionalController,
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
                      controller: bloodTypeController,
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
            );
            break;
          case StatePerfil.LOADING:
            return Center(
              child: CircularProgressIndicator(),
            );
            break;
        }
      }
      ),
      floatingActionButton: Obx((){
        if(perfilController.statePerfil.value == StatePerfil.LOADING){
          return Container();
        }else{
          return FloatingActionButton.extended(
              backgroundColor: Theme.of(context).primaryColor,
              onPressed: (){},
              label: Row(
                children: [
                  Icon(Icons.save),
                  SizedBox(width: 2,),
                  Text("Salvar")
                ],
              ));
        }

      }),
    );
  }
}
