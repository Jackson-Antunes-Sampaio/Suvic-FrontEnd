import 'package:covid_19/controllers/StockController.dart';
import 'package:covid_19/controllers/clinicController.dart';
import 'package:covid_19/models/stock_vacine_model.dart';
import 'package:covid_19/screens/stock/autocomplete/data/getAllVacinesAgend.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

Widget autocompleVaccinesAgendaments(
    BuildContext context, ClinicController controller) {
  TextEditingController vacine = TextEditingController();
  StockController stockController = Get.find();
  var prices = stockController.priceVaccine;
  final oCcy = NumberFormat("R\$ #,##0.00", "en_US");

  return TypeAheadField(
    textFieldConfiguration: TextFieldConfiguration(
      controller: vacine,
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
        fillColor: Colors.white,
        isDense: true,
        prefixIcon: Icon(
          Icons.search,
          color: Colors.white,
        ),
        suffixIcon: IconButton(
          onPressed: () => controller.changeSeachStatus(),
          icon: Icon(
            Icons.close,
            color: Colors.white,
            size: 18,
          ),
        ),
        suffixStyle: TextStyle(
          color: Colors.white,
        ),
        hoverColor: Colors.white,
        labelText: 'Pequisar Vacinas',
        hintText: 'Digite o nome da Vacina',
        labelStyle: TextStyle(
          color: Colors.white,
        ),
        hintStyle: TextStyle(
          color: Colors.white,
        ),
        //enabledBorder: InputBorder.none,
        border: OutlineInputBorder(
          borderRadius: const BorderRadius.all(
            const Radius.circular(10.0),
          ),
          borderSide: BorderSide(
            color: Colors.white,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(
            const Radius.circular(10.0),
          ),
          borderSide: BorderSide(
            color: Colors.white,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: const BorderRadius.all(
            const Radius.circular(10.0),
          ),
          borderSide: BorderSide(
            color: Colors.white,
          ),
        ),
      ),
    ),
    suggestionsCallback: (pattern) async {
      return await GetAllVacinesAgendament.getSuggestions(pattern);
    },
    itemBuilder: (context, Map<String, dynamic> suggestion) {
      var price = 0;
      if ((prices.where((element) => element.vacine == suggestion['name']))
              .length !=
          0) {
        price = prices
            .firstWhere((element) => element.vacine == suggestion['name'])
            .price;
      } else {
        price = 0;
      }
      return ListTile(
        leading: Image.asset(
          'assets/images/iconVacine.png',
          width: 30,
          height: 30,
        ),
        title: Text(suggestion['name']!),
        trailing: Text(
          oCcy.format(price),
        ),
      );
    },
    onSuggestionSelected: (Map<String, dynamic> suggestion) {
      var price = 0;
      if ((prices.where((element) => element.vacine == suggestion['name']))
              .length !=
          0) {
        price = prices
            .firstWhere((element) => element.vacine == suggestion['name'])
            .price;
      } else {
        price = 0;
      }
      controller.addVacineInCart(
        StockVacineModel(
          name: suggestion['name'],
          lote: suggestion['lote'],
          dataValidade: suggestion['dataValidade'],
          quantidade: 1,
          price: price,
        ),
      );
      print('Vaccine: ' + suggestion.toString());
    },
  );
}
