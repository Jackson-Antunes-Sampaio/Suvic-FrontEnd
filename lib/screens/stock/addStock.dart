import 'package:covid_19/common/botton_navigation_bar/bottom_navigation_bar_new.dart';
import 'package:covid_19/common/button_custom.dart';
import 'package:covid_19/common/my_header_widget.dart';
import 'package:covid_19/common/text_fiel_custom.dart';
import 'package:covid_19/models/page_manager.dart';
import 'package:covid_19/screens/stock/elements/herder_container_vacina.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';

class AddVacina extends StatefulWidget {
  @override
  _AddVacinaState createState() => _AddVacinaState();
}

class _AddVacinaState extends State<AddVacina> {
  DateTime _date = DateTime(2020, 11, 17);

  void _selectDate() async {
    final DateTime? newDate = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime(2017, 1),
      lastDate: DateTime(2022, 7),
      helpText: 'Select a date',
    );
    if (newDate != null) {
      setState(() {
        _date = newDate;
      });
    }
  }

  PageController pageController = PageController();
  PageManager pageManager = Get.put(PageManager());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(bottom: 30),
          child: Column(
            children: <Widget>[
              MyHeader(
                image: "assets/images/2vacine.png",
                textTop: "Adicionar Vacina",
                textBottom: "",
                offset: 0,
              ),
              Container(
                margin: EdgeInsets.only(left: 20, right: 20),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    TextFieldCustom(
                      validator: (text){},
                      textInputType: TextInputType.text,
                      labelText: "Vacina",
                      hintText: "Vacina",
                      iconData: Icons.medical_services,
                    ),
                    SizedBox(height: 10,),
                    TextFieldCustom(
                      validator: (text){},
                      textInputType: TextInputType.text,
                      labelText: "Lote",
                      hintText: "Lote",
                      iconData: Icons.add_box,
                    ),
                    SizedBox(height: 10,),
                    TextFieldCustom(
                      validator: (text){},
                      textInputType: TextInputType.text,
                      labelText: "Data de Validade",
                      hintText: "Data de Validade",
                      iconData: Icons.calendar_today,
                    ),
                    SizedBox(height: 10,),
                    TextFieldCustom(
                      validator: (text){},
                      textInputType: TextInputType.text,
                      labelText: "Quantidade",
                      hintText: "Quantidade",
                      iconData: Icons.plus_one,
                    ),
                    SizedBox(height: 10,),
                    TextFieldCustom(
                      validator: (text){},
                      textInputType: TextInputType.text,
                      labelText: "Valor",
                      hintText: "Valor",
                      iconData: Icons.attach_money,
                    ),
                    SizedBox(height: 10,),
                    ButtonCustom(
                        onPressed: (){},
                        title: "Adicionar"),

                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
