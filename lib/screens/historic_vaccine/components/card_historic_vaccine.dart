import 'package:covid_19/controllers/apply_vaccine_controller.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CardHistoricVaccine extends StatelessWidget {
  CardHistoricVaccine({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5),
      child: ExpansionTileCard(
        title: Text("Vacina x"),
        initiallyExpanded: false,
        elevation: 2,
        initialElevation: 2,
        children: [
          TextFormField(
            enabled: false,
            initialValue: '${DateFormat('dd/MM/yyyy').format(DateTime.now())}',
            decoration: InputDecoration(
              labelText: 'Data APlicação',
              border: InputBorder.none,
              prefixIcon: Icon(Icons.date_range),
              enabled: false,
            ),
          ),
          TextFormField(
            enabled: false,
            initialValue: 'Jackson Antunes',
            decoration: InputDecoration(
              labelText: 'Aplicador',
              border: InputBorder.none,
              prefixIcon: Icon(Icons.person),
              enabled: false,
            ),
          ),
          TextFormField(
            enabled: false,
            initialValue: 'Única',
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
