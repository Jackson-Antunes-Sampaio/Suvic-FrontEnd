import 'package:covid_19/controllers/apply_vaccine_controller.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CustomExpansionTile extends StatelessWidget {
  CustomExpansionTile({Key? key}) : super(key: key);
  final ApplyVaccineController _applyVaccineController = Get.find();

  @override
  Widget build(BuildContext context) {
    return ExpansionTileCard(
      title: Text("Vacina x"),
      initiallyExpanded: true,
      elevation: 4,
      initialElevation: 4,
      children: [
        TextFormField(
          enabled: false,
          initialValue:
          '${DateFormat('dd/MM/yyyy').format(DateTime.now())}',
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
        Row(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 10,
              ),
              child: Text("Dose   "),
            ),
            DropdownButton<String>(
              value: "_applyVaccineController.selectDose.value",
              elevation: 16,
              //style: const TextStyle(color: Colors.deepPurple),
              underline: Container(
                height: 1,
                //color: Colors.grey.shade300,
                color: Colors.transparent,
              ),
              onChanged: (newValue) {
                _applyVaccineController.selectDose.value = newValue! as int;
              },
              items: <String>['Única', '1º', '2º', '3º']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            )
          ],
        ),
        SizedBox(
          height: 10,
        )
      ],
    );
  }
}
