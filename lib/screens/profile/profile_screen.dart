import 'package:brasil_fields/brasil_fields.dart';
import 'package:covid_19/common/icon_button_custom.dart';
import 'package:covid_19/common/text_fiel_custom.dart';
import 'package:covid_19/controllers/perfil_controller.dart';
import 'package:covid_19/controllers/user_controller.dart';
import 'package:covid_19/models/user_model.dart';
import 'package:covid_19/screens/profile/components/address_user.dart';
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
  String? sexController;
  String? healthProfessional;
  String? bloodTypeController;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    perfilController.statePerfil.value = StatePerfil.IDL;
    nameController.text = userController.user?.civilName ?? '';
    emailController.text = userController.user?.email ?? '';
    rgController.text = userController.user?.rg == null ? '' : '${userController.user?.rg}';
    cpfController.text = userController.user?.cpf ?? '';
    birthdateController.text = userController.user!.birthdate == null ? '' : DateFormat("dd/MM/yyyy").format(DateTime.parse(userController.user!.birthdate!));
    sexController = userController.user?.sex == "NS" ? "Não especificado" : userController.user?.sex ?? 'Não especificado';
    healthProfessional = userController.user!.healthProfessional! ? 'Sim'  : 'Não';
    bloodTypeController = userController.user?.bloodType;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Perfil"),
        actions: [
          Obx((){
            if(perfilController.statePerfil.value == StatePerfil.ADDRESS){
              return IconButtonCustom(
                onTap: (){
                  perfilController.statePerfil.value = StatePerfil.IDL;
                },
                iconData: Icons.close,
              );
            }else{
              return Container();
            }
          }),
          Container(width: 10,)
        ],
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
                    InkWell(
                      onTap: (){
                        final snackBar = SnackBar(
                          content: Text('Em manutenção'),
                          backgroundColor: Colors.red,
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text("Alterar senha"),
                          Icon(Icons.keyboard_arrow_right)
                        ],
                      ),
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
                      enabled: false,
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
                      textInputType: TextInputType.number,
                      textInputFormatter: [
                        //FilteringTextInputFormatter.digitsOnly,
                        MaskTextInputFormatter(mask: "##.###.###-#")
                      ],
                      validator: (value){
                        if(value!.isEmpty){
                          return null;
                        }else{
                          String newValue = value.replaceAll(".", "").replaceAll("-", "").replaceAll(" ", "");
                          if(newValue.length == 9){
                            return null;
                          }else{
                            return 'Campo inválido';
                          }
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
                        if(value!.isEmpty){
                          return 'Campo inválido';
                        }else{
                          String newValue = value.replaceAll(".", "").replaceAll("-", "").replaceAll(" ", "");
                          if(newValue.length == 11){
                            return null;
                          }else{
                            return 'Campo inválido';
                          }
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
                    Row(
                      children: [
                        Text("Sexo: "),
                        SizedBox(width: 10,),
                        DropdownButton<String>(
                          value: sexController,
                          elevation: 16,
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
                          items: ["M", "F", "Não especificado"]
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value == "M" ? "Masculino" : value == "F" ? "Feminino" : value),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                    SizedBox(height: 10,),
                    SizedBox(height: 10,),
                    Row(
                      children: [
                        Text("Profissional da saúde: "),
                        SizedBox(width: 10,),
                        DropdownButton<String>(
                          value: healthProfessional,
                          elevation: 16,
                          //style: const TextStyle(color: Colors.deepPurple),
                          underline: Container(
                            height: 1,
                            color: Colors.transparent,
                          ),
                          onChanged: (newValue) {
                            setState(() {
                              healthProfessional = newValue;
                            });
                          },
                          items: ["Sim", "Não"]
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value.toString()),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                    SizedBox(height: 10,),
                    Row(
                      children: [
                        Text("Tipo sanguineo: "),
                        SizedBox(width: 10,),
                        DropdownButton<String>(
                          value: bloodTypeController,
                          elevation: 16,
                          underline: Container(
                            height: 1,
                            color: Colors.transparent,
                          ),
                          onChanged: (newValue) {
                            setState(() {
                              bloodTypeController = newValue;
                            });
                          },
                          items: perfilController.listbloodType
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value.toString()),
                            );
                          }).toList(),
                        )
                      ],
                    ),
                    // TextFieldCustom(
                    //   controller: bloodTypeController,
                    //   hintText: "Tipo sanguineo",
                    //   labelText: "Tipo sanguineo",
                    //   textInputFormatter: [],
                    //   validator: (value){
                    //     return null;
                    //   },
                    // ),
                    SizedBox(height: 10,),
                    InkWell(
                      onTap: (){
                        perfilController.statePerfil.value = StatePerfil.ADDRESS;
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          userController.user?.addressStreetName != null
                             ? Text("Alterar Endereço")
                              : Text("Inserir Endereço"),
                          Icon(Icons.keyboard_arrow_right)
                        ],
                      ),
                    ),
                    SizedBox(height: 80,),
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
          case StatePerfil.ADDRESS:
            return AddressUser(
              user: userController.user!,
            );
        }
      }
      ),
      floatingActionButton: Obx((){
        if(perfilController.statePerfil.value == StatePerfil.LOADING || perfilController.statePerfil.value == StatePerfil.ADDRESS){
          return Container();
        }else{
          return FloatingActionButton.extended(
              backgroundColor: Theme.of(context).primaryColor,
              onPressed: ()async{
                UserModel? userModelFirst = userController.user;
                if(formKey.currentState!.validate()){
                  userController.user?.civilName = nameController.text;
                  userController.user?.email = emailController.text;
                  if(rgController.text.isNotEmpty){
                    int rg = int.parse(rgController.text.replaceAll(".", "").replaceAll("-", ""));
                    userController.user?.rg = rg;
                  }

                  String cpf = cpfController.text.replaceAll(".", "").replaceAll("-", "").replaceAll(" ", "");
                  userController.user?.cpf = cpf;
                  List listData = birthdateController.text.split("/");
                  userController.user?.birthdate = "${listData.last}-${listData[1]}-${listData.first}";
                  userController.user?.sex = sexController == "Não especificado" ? "NS" : sexController;
                  userController.user?.healthProfessional = healthProfessional == "Sim" ? true : false;
                  userController.user?.bloodType = bloodTypeController;
                  perfilController.putUser(userController.user!).then((value){
                    if(value){
                      final snackBar = SnackBar(
                        content: Text('Dados Atualizados'),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }else{
                      userController.user = userModelFirst;
                      final snackBar = SnackBar(
                        content: Text('Erro ao salvar dados'),
                        backgroundColor: Colors.red,
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }
                  });
                }else{
                  final snackBar = SnackBar(
                    content: Text('Verifique Campos inválidos'),
                    backgroundColor: Colors.red,
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }

              },
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
