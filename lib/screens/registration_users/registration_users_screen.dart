import 'package:covid_19/common/botton_navigation_bar/bottom_navigation_bar_new.dart';
import 'package:covid_19/common/button_custom.dart';
import 'package:covid_19/common/text_fiel_custom.dart';
import 'package:flutter/material.dart';

class RegistrationUsersScreen extends StatelessWidget {

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

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
                  iconData: Icons.person,
                  hintText: 'Nome',
                  labelText: 'Nome',
                  textInputType: TextInputType.name,
                  validator: (text){
                    if(text != null){
                      return 'Validar Campo';
                    }else{
                      return null;
                    }
                  },
                ),
                SizedBox(height: 10,),
                TextFieldCustom(
                  iconData: Icons.list,
                  hintText: '000.000.000-00',
                  labelText: 'CPF/RG',
                  textInputType: TextInputType.name,
                  validator: (text){
                    if(text != null){
                      return 'Validar Campo';
                    }else{
                      return null;
                    }
                  },
                ),
                SizedBox(height: 10,),
                TextFieldCustom(
                  iconData: Icons.art_track_outlined,
                  hintText: 'Enfermeiro',
                  labelText: 'Função',
                  textInputType: TextInputType.name,
                  validator: (text){
                    if(text != null){
                      return 'Validar Campo';
                    }else{
                      return null;
                    }
                  },
                ),
                SizedBox(height: 10,),
                TextFieldCustom(
                  iconData: Icons.article_sharp,
                  hintText: 'Certificação',
                  labelText: '123456479',
                  textInputType: TextInputType.emailAddress,
                  validator: (text){
                    if(text != null){
                      return 'Validar Campo';
                    }else{
                      return null;
                    }
                  },
                ),
                SizedBox(height: 10,),
                ButtonCustom(
                  title: "Enviar",
                  onPressed: (){
                    if(formKey.currentState!.validate()){
                      print("Ok");
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
