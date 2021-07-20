import 'package:covid_19/common/botton_navigation_bar/bottom_navigation_bar_new.dart';
import 'package:covid_19/controllers/agendament_controller.dart';
import 'package:covid_19/controllers/clinicController.dart';
import 'package:covid_19/controllers/vaccine_controller.dart';
import 'package:covid_19/models/agendament_model.dart';
import 'package:covid_19/screens/agendament/autocomplete/data/getTime.dart';
import 'package:covid_19/screens/agendament/autocomplete/textFormField.dart';
import 'package:covid_19/screens/agendament/elements/googleMaps.dart';
import 'package:covid_19/utils/styles/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';

class Agendament extends StatefulWidget {
  @override
  _AgendamentState createState() => _AgendamentState();
}

class _AgendamentState extends State<Agendament> {
  AgendamentController agendamentController = Get.put(AgendamentController());
  String? _dropdownValue;

  TextEditingController vaccine = TextEditingController();
  TextEditingController data = TextEditingController();
  TextEditingController time = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  bool docilio = false;

  @override
  Widget build(BuildContext context) {
    print(VaccineController.to.getAll());
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.maxFinite,
              height: 260,
              color: Colors.white,
              child: Center(
                child: GoogleMapAgendament(),
              ),
            ),
            Card(
              color: kPrimaryColor,
              margin: EdgeInsets.all(0),
              child: Container(
                width: double.maxFinite,
                height: 50,
                child: Center(
                  child: Obx(
                    () {
                      String clinicName =
                          ClinicController.to.clinic.value.name ?? '';

                      return Text(
                        clinicName,
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
            Container(
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          left: 10, top: 20, right: 10, bottom: 10),
                      child: autocompleVaccines(context, vaccine),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                      // child: autoCompleteTime(),
                      // child: autocompleTime(),
                      child: DropdownButtonFormField<String>(
                        value: _dropdownValue,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                        focusColor: Colors.deepOrange,
                        icon: const Icon(
                          Icons.arrow_downward,
                          color: kPrimaryColor,
                        ),
                        hint: const Text('Horário'),
                        iconSize: 24,
                        elevation: 16,
                        style: const TextStyle(color: Colors.black87),
                        onChanged: (String? newValue) {
                          setState(() {
                            _dropdownValue = newValue;
                          });
                        },
                        items: GetTimeScheld.getTimer()
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Container(
                                width: 200,
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(right: 5),
                                      child: Icon(Icons.timer,
                                          color: kPrimaryColor),
                                    ),
                                    Text(value),
                                  ],
                                )),
                          );
                        }).toList(),
                        validator: (String? value) {
                          if (value == null) {
                            return 'Deve fazer uma seleção.';
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                      child: Container(
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Usar Cartão Cadastrado'),
                                Checkbox(value: true, onChanged: (value) {})
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                      child: Container(
                        child: GestureDetector(
                          onTap: () => Get.defaultDialog(
                            title: 'Endereço do Usuario',
                            content: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.only(
                                          top: 0, bottom: 0, left: 4, right: 4),
                                      labelText: 'CEP',
                                      border: OutlineInputBorder(),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.only(
                                          top: 0, bottom: 0, left: 4, right: 4),
                                      labelText: 'Número',
                                      border: OutlineInputBorder(),
                                    ),
                                    keyboardType: TextInputType.number,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.only(
                                          top: 0, bottom: 0, left: 4, right: 4),
                                      labelText: 'Complemento',
                                      border: OutlineInputBorder(),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            cancel: ElevatedButton.icon(
                              onPressed: () => Get.back(),
                              icon: Icon(Icons.cancel),
                              label: Text('Cancelar'),
                            ),
                            confirm: ElevatedButton.icon(
                              onPressed: () {},
                              icon: Icon(Icons.done),
                              label: Text('Adicionar'),
                            ),
                          ),
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.all(8),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Atendimento ao domicílio'),
                                  Checkbox(
                                      value: docilio, onChanged: (value) {})
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: 10, top: 10, right: 10, bottom: 10),
                      child: Container(
                        width: double.maxFinite,
                        child: ElevatedButton.icon(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateColor.resolveWith(
                                (states) => kPrimaryColor),
                          ),
                          onPressed: () {
                            return schedule();
                          },
                          icon: Obx(() => AgendamentController.to.loading.value
                              ? Container(
                                  width: 15,
                                  height: 15,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 2,
                                  ),
                                )
                              : Icon(Icons.add)),
                          label: Text('Agendar'),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBarNew(),
    );
  }

  TypeAheadFormField<String> autoCompleteTime() {
    return TypeAheadFormField(
      textFieldConfiguration: TextFieldConfiguration(
        decoration: InputDecoration(
          labelText: 'Horário',
          border: OutlineInputBorder(),
        ),
        controller: time,
      ),
      suggestionsCallback: (pattern) {
        return GetTimeScheld.getSuggestions(pattern);
      },
      itemBuilder: (context, String suggestion) {
        return ListTile(
          title: Text(suggestion),
          trailing: Text('0/5'),
        );
      },
      transitionBuilder: (context, suggestionsBox, controller) {
        return suggestionsBox;
      },
      onSuggestionSelected: (String suggestion) {
        time.text = suggestion;
      },
      validator: (value) => value!.isEmpty ? 'Please select a time' : null,
    );
  }

  schedule() {
    if (_formKey.currentState!.validate()) {
      AgendamentController.to.insert(AgendamentModel(
        vaccine: vaccine.text,
        data: time.text,
        time: time.text,
      ));
      _formKey.currentState!.reset();
    }
  }
}
