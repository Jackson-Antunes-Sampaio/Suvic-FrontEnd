import 'package:covid_19/controllers/stock_vacine_controller.dart';
import 'package:covid_19/models/page_manager.dart';
import 'package:covid_19/models/stock_vacine_model.dart';
import 'package:covid_19/screens/stock/autocomplete/textFormField.dart';
import 'package:covid_19/screens/stock/elements/herder_container_vacina.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:intl/intl.dart';

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
      firstDate: DateTime(2021, 1),
      lastDate: DateTime(2021, 7),
      helpText: 'Select a date',
    );
    if (newDate != null) {
      setState(() {
        _date = newDate;
        // var formatter = new DateFormat('yyyy-MM-dd');
        // String formattedDate = formatter.format(newDate);
        // experationdate.text = formattedDate;
      });
    }
  }

  PageController pageController = PageController();
  PageManager pageManager = Get.put(PageManager());

  StockVacineController stockVacineController = Get.find();
  //Form key
  final _formKey = GlobalKey<FormState>();
  //fieldController
  TextEditingController vacineName = TextEditingController();
  TextEditingController lote = TextEditingController();
  TextEditingController experationdate = TextEditingController();
  TextEditingController quantidade = TextEditingController();
  TextEditingController valor = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(bottom: 30),
          child: Column(
            children: <Widget>[
              HeaderContainerVacina("Adicionar Vacina"),
              Form(
                key: _formKey,
                child: Container(
                  margin: EdgeInsets.only(left: 20, right: 20),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 14, bottom: 12),
                        child: autocompleVaccines(context, vacineName),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: TextFormField(
                          controller: lote,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.add_box),
                            labelText: 'Lote',
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Este é um campo obrigatório';
                            }
                            return null;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: TextFormField(
                          controller: experationdate,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.calendar_today),
                            labelText: 'Data de Validade',
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Este é um campo obrigatório';
                            }
                            return null;
                          },
                          keyboardType: TextInputType.datetime,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: TextFormField(
                          controller: quantidade,
                          onTap: () {},
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.plus_one),
                            labelText: 'Quantidade',
                            border: OutlineInputBorder(),
                          ),
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Este é um campo obrigatório';
                            }
                            return null;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: TextFormField(
                          controller: valor,
                          onTap: () {},
                          decoration: InputDecoration(
                            //prefixIcon: Icon(Icons.real_estate_agent),
                            labelText: 'Valor',
                            border: OutlineInputBorder(),
                          ),
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Este é um campo obrigatório';
                            }
                            return null;
                          },
                        ),
                      ),
                      Container(
                        width: double.maxFinite,
                        child: ElevatedButton.icon(
                          onPressed: () => addVacineInStock(),
                          icon: Icon(Icons.add),
                          label: Text('Adicionar'),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void addVacineInStock() {
    if (_formKey.currentState!.validate()) {
      stockVacineController.insert(
        StockVacineModel(
          idClinica: 'idClinica',
          name: vacineName.text,
          lote: int.parse(lote.text),
          dataValidade: experationdate.text,
          quantidade: int.parse(quantidade.text),
          valor: double.parse(valor.text),
        ),
      );
      //mensager sucesse
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              Icon(
                Icons.done,
                color: Colors.greenAccent,
              ),
              Text(' Vacina adicionado com sucesso!')
            ],
          ),
        ),
      );
    }
  }
}
