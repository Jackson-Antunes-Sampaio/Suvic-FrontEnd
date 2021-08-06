import 'package:covid_19/controllers/apply_vaccine_controller.dart';
import 'package:covid_19/models/historic_vaccine_model.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CardHistoricVaccine extends StatelessWidget {
  CardHistoricVaccine({
    required this.vaccineName,
    required this.applicationDate,
    required this.user,
    required this.doseNumber
});

  final String vaccineName;
  final String applicationDate;
  final User user;
  final int doseNumber;


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5),
      child: ExpansionTileCard(
        title: Text("$vaccineName"),
        initiallyExpanded: false,
        elevation: 2,
        initialElevation: 2,
        children: [
          TextFormField(
            enabled: false,
            initialValue: '${DateFormat('dd/MM/yyyy').format(DateTime.parse(applicationDate))}',
            decoration: InputDecoration(
              labelText: 'Data APlicação',
              border: InputBorder.none,
              prefixIcon: Icon(Icons.date_range),
              enabled: false,
            ),
          ),
          TextFormField(
            enabled: false,
            initialValue: '${user.socialName}',
            decoration: InputDecoration(
              labelText: 'Aplicador',
              border: InputBorder.none,
              prefixIcon: Icon(Icons.person),
              enabled: false,
            ),
          ),
          TextFormField(
            enabled: false,
            initialValue: '$doseNumber',
            decoration: InputDecoration(
              labelText: 'Dose',
              border: InputBorder.none,
              prefixIcon: Icon(Icons.all_inbox),
              enabled: false,
            ),
          ),
          SizedBox(
            height: 10,
          )
        ],
      ),
    );
  }
}
