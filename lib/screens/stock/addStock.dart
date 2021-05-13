import 'package:covid_19/common/botton_navigation_bar/bottom_navigation_bar_new.dart';
import 'package:covid_19/models/page_manager.dart';
import 'package:covid_19/screens/stock/elements/autocomplete_time.dart';
import 'package:covid_19/screens/stock/elements/herder_container_vacina.dart';
import 'package:covid_19/utils/styles/style.dart';
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
              HeaderContainerVacina("Adicionar Vacina"),
              Container(
                margin: EdgeInsets.only(left: 20, right: 20),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 14, bottom: 12),
                      child: TextFormField(
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.medical_services),
                          labelText: 'Vacina',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: TextFormField(
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.add_box),
                          labelText: 'Lote',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: TextFormField(
                        onTap: _selectDate,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.calendar_today),
                          labelText: 'Data de Validade',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: TextFormField(
                        onTap: () {},
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.plus_one),
                          labelText: 'Quantidade',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: TextFormField(
                        onTap: () {},
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.real_estate_agent),
                          labelText: 'Valor',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    Container(
                      width: double.maxFinite,
                      child: ElevatedButton.icon(
                        onPressed: () {},
                        icon: Icon(Icons.add),
                        label: Text('Adicionar'),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBarNew(pageController),
    );
  }
}
