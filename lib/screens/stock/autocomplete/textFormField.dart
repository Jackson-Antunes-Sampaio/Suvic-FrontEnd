import 'package:covid_19/screens/stock/autocomplete/data/getAllVacines.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

Widget autocompleVaccines(BuildContext context, TextEditingController vacine) {
  return TypeAheadField(
    textFieldConfiguration: TextFieldConfiguration(
      controller: vacine,
      autofocus: true,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.medical_services),
        labelText: 'Vacina',
        border: OutlineInputBorder(),
      ),
    ),
    suggestionsCallback: (pattern) async {
      return await GetAllVacines.getSuggestions(pattern);
    },
    itemBuilder: (context, Map<String, String> suggestion) {
      return ListTile(
        leading: Icon(Icons.medical_services),
        title: Text(suggestion['name']!),
      );
    },
    onSuggestionSelected: (Map<String, String> suggestion) {
      vacine.text = suggestion['name']!;
      // Navigator.of(context).push(MaterialPageRoute(
      //     builder: (context) => ProductPage(product: suggestion)));
    },
  );
}