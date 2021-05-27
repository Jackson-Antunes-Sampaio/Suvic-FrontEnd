import 'package:covid_19/common/botton_navigation_bar/bottom_navigation_bar_new.dart';
import 'package:covid_19/models/page_manager.dart';
import 'package:covid_19/screens/agendament/elements/autocomplete_time.dart';
import 'package:covid_19/screens/agendament/elements/autocomplete_vaccine.dart';
import 'package:covid_19/screens/agendament/elements/googleMaps.dart';
import 'package:covid_19/utils/styles/style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Agendament extends StatefulWidget {
  @override
  _AgendamentState createState() => _AgendamentState();
}

class _AgendamentState extends State<Agendament> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(bottom: 30),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: double.maxFinite,
                height: 250,
                color: Colors.white,
                child: Center(
                  child: GoogleMapAgendament(),
                ),
              ),
              Container(
                width: double.maxFinite,
                height: 50,
                color: kPrimaryColor,
                child: Center(
                  child: Text(
                    'Nome da Clinica',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Container(
                child: Form(
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            left: 10, top: 20, right: 10, bottom: 10),
                        child: autocompleVaccine(),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.only(left: 10, right: 10, bottom: 10),
                        child: TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Data',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.only(left: 10, right: 10, bottom: 10),
                        child: autocompleTime(),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.only(left: 10, right: 10, bottom: 10),
                        child: Container(
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.all(8),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                              onPressed: () {},
                              icon: Icon(Icons.add),
                              label: Text('Agendar')),
                        ),
                      )
                    ],
                  ),
                ),
              )
              // Expanded(
              //   child: Container(
              //     margin: EdgeInsets.only(left: 20, right: 20, top: 30),
              //     child: Column(
              //       mainAxisSize: MainAxisSize.max,
              //       children: [
              //         Center(
              //           child: Row(
              //             children: [
              //               ChoiceChip(
              //                 selectedColor: kPrimaryColor,
              //                 label: Text(
              //                   'Vacina 1',
              //                   style: TextStyle(
              //                       color: Colors.white,
              //                       fontWeight: FontWeight.bold),
              //                 ),
              //                 selected: true,
              //               ),
              //               ChoiceChip(
              //                 label: Text('Vacina 2'),
              //                 selected: false,
              //               ),
              //               ChoiceChip(
              //                 label: Text('Vacina 3'),
              //                 selected: false,
              //               ),
              //               ChoiceChip(
              //                 label: Text('Vacina 4'),
              //                 selected: false,
              //               ),
              //             ],
              //           ),
              //         ),
              //         Padding(
              //           padding: const EdgeInsets.only(top: 14, bottom: 12),
              //           child: TextFormField(
              //             onTap: _selectDate,
              //             decoration: InputDecoration(
              //               prefixIcon: Icon(Icons.calendar_today),
              //               labelText: 'Selecionar Data',
              //               border: OutlineInputBorder(),
              //             ),
              //           ),
              //         ),
              //         Padding(
              //           padding: const EdgeInsets.only(bottom: 12),
              //           child: autocompleTime(),
              //         ),
              //         Padding(
              //           padding: const EdgeInsets.only(bottom: 12),
              //           child: TextFormField(
              //             onTap: () {},
              //             decoration: InputDecoration(
              //               prefixIcon: Icon(Icons.card_membership),
              //               labelText: 'Usar Cartão Cadastrado',
              //               border: OutlineInputBorder(),
              //             ),
              //           ),
              //         ),
              //         Expanded(
              //           child: Center(
              //             child: Container(
              //               width: double.maxFinite,
              //               child: ElevatedButton(
              //                 onPressed: () {},
              //                 child: Row(
              //                   mainAxisAlignment: MainAxisAlignment.center,
              //                   children: [
              //                     Icon(Icons.assessment),
              //                     Text(' Agendar')
              //                   ],
              //                 ),
              //               ),
              //             ),
              //           ),
              //         ),
              //       ],
              //     ),
              //   ),
              // )
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBarNew(),
    );
  }
}
