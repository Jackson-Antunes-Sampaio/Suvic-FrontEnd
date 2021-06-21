import 'package:covid_19/common/botton_navigation_bar/bottom_navigation_bar_new.dart';
import 'package:covid_19/controllers/agendament_controller.dart';
import 'package:covid_19/controllers/clinicController.dart';
import 'package:covid_19/controllers/stock_vacine_controller.dart';
import 'package:covid_19/models/agendament_model.dart';
import 'package:covid_19/models/stock_vacine_model.dart';
import 'package:covid_19/repositories/stock_vacine_repository.dart';
import 'package:covid_19/screens/agendament/autocomplete/data/getTime.dart';
import 'package:covid_19/screens/agendament/autocomplete/textFormField.dart';
import 'package:covid_19/screens/agendament/elements/googleMaps.dart';
import 'package:covid_19/utils/styles/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class Agendament extends StatefulWidget {
  @override
  _AgendamentState createState() => _AgendamentState();
}

class _AgendamentState extends State<Agendament> {
  DateTime _date = DateTime.now();
  var date;

  void _selectDate() async {
    final DateTime? newDate = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime(2021, 1),
      lastDate: DateTime(2051, 1),
      helpText: 'Select a date',
    );
    if (newDate != null) {
      setState(() {
        _date = newDate;

        data.text = DateFormat('dd-MM-y').format(newDate);
        date = DateFormat('yyyy-MM-dd').format(newDate);
      });
    }
  }

  TextEditingController vaccine = TextEditingController();
  TextEditingController data = TextEditingController();
  TextEditingController time = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
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
                      child: TextFormField(
                        controller: data,
                        decoration: InputDecoration(
                          labelText: 'Data',
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.all(8),
                          suffix: IconButton(
                            onPressed: () => _selectDate(),
                            icon: Icon(Icons.date_range),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                      child: autoCompleteTime(),
                      // child: autocompleTime(),
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
                    )
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
        data: date,
        time: time.text,
      ));
      _formKey.currentState!.reset();
    }
  }
}
