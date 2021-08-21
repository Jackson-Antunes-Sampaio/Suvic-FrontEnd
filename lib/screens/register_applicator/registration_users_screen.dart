import 'package:brasil_fields/brasil_fields.dart';
import 'package:covid_19/common/botton_navigation_bar/bottom_navigation_bar_new.dart';
import 'package:covid_19/common/button_custom.dart';
import 'package:covid_19/common/text_fiel_custom.dart';
import 'package:covid_19/controllers/register_applicator_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class RegisterApplicator extends StatelessWidget {

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final RegisterApplicatorController registerApplicatorController = Get.put(RegisterApplicatorController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBarNew(),
      appBar: AppBar(
        title: Text("Cadastrar Aplicador"),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Column(
              children: [
                TextFieldCustom(
                  iconData: Icons.list,
                  hintText: '000.000.000-00',
                  labelText: 'CPF',
                  textInputType: TextInputType.name,
                  onChanged: (text){
                    if(text.length == 14){
                      print("AQUI");
                      registerApplicatorController.postRegisterApplicator(text.replaceAll(".", "").replaceAll("-", ""));

                    }
                  },
                  textInputFormatter: [
                    FilteringTextInputFormatter.digitsOnly,
                    CpfInputFormatter(),
                  ],
                  validator: (text){
                    if(text != null){
                      return 'Validar Campo';
                    }else{
                      return null;
                    }
                  },
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
