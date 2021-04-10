import 'package:covid_19/screens/vaccine_card/components/vaccine_item.dart';
import 'package:flutter/material.dart';

class VaccineCardScreen extends StatefulWidget {
  @override
  _VaccineCardScreenState createState() => _VaccineCardScreenState();
}

String vaccine;
Color color;

//Dados mockados
List<String> vaccines = [
  'Tétano e difteria',
  'Tríplice-viral',
  'Pneumo-13',
  'Gripe',
  'Hepatite B',
  'Febre amarela',
  'HPV',
  'Dengue'
];

// Função Get no storage em initState
List<int> _selectedIndex = [];

class _VaccineCardScreenState extends State<VaccineCardScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'SUVIC',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: GridView.count(
        // Create a grid with 2 columns. If you change the scrollDirection to
        // horizontal, this produces 2 rows.
        crossAxisCount: 2,
        // Generate 100 widgets that display their index in the List.
        children: List.generate(
          vaccines.length,
              (index) =>
              VaccineItem(
                index: index,
                // onSelected: () {
                //   color = Colors.red;
                // },
                // offSelect: () {
                //   // função delete no storage
                //   _selectedIndex.remove(index);
                // },
                vaccines: vaccines,
              ),
        ),
      ),
    );
  }
}
