import 'package:covid_19/common/botton_navigation_bar/bottom_navigation_bar_new.dart';
import 'package:covid_19/common/text_fiel_custom.dart';
import 'package:flutter/material.dart';

class RegistrationUsersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBarNew(),
      appBar: AppBar(
        title: Text("Cadastrar Usuario/Operador"),
      ),
      body: Form(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Column(
            children: [
              TextFieldCustom(
                iconData: Icons.person,
                hintText: 'Nome',
                labelText: 'Nome',
                textInputType: TextInputType.name,
              ),
              SizedBox(height: 10,),
              TextFieldCustom(
                iconData: Icons.email,
                hintText: 'email@email.com',
                labelText: 'Email',
                textInputType: TextInputType.emailAddress,
              ),
              SizedBox(height: 10,),
              TextFieldCustom(
                iconData: Icons.category,
                hintText: 'Enfermeiro',
                labelText: 'Função',
                textInputType: TextInputType.name,
              ),
              SizedBox(height: 10,),
              Container(
                decoration: BoxDecoration(
                    color: Colors.red,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey,
                          blurRadius: 5.0,
                          offset: Offset(2.0, 2.0))
                    ]),
                height: 50,
                child: RaisedButton(
                  onPressed: () {

                  },
                  color: Colors.blueAccent,
                  child: Center(
                    child: Text(
                      "Enviar",
                      style: TextStyle(
                        color: Colors.white70,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
