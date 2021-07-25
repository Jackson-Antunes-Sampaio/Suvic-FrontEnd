import 'package:covid_19/common/icon_button_custom.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'components/card_historic_vaccine.dart';

class HistoricVaccineScreen extends StatefulWidget {
  const HistoricVaccineScreen({Key? key}) : super(key: key);

  @override
  _HistoricVaccineScreenState createState() => _HistoricVaccineScreenState();
}

class _HistoricVaccineScreenState extends State<HistoricVaccineScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Historico de vacinas"),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Container(
                  height: 45,
                  child: TextField(
                    decoration: InputDecoration(
                      isDense: true,
                      prefixIcon: IconButtonCustom(
                        iconData: Icons.search,
                      ),
                      hintText: "Buscar",
                      hintStyle: TextStyle(color: Colors.grey),
                      border: OutlineInputBorder(
                        borderRadius: const BorderRadius.all(
                          const Radius.circular(10.0),
                        ),
                      ),
                    ),
                    onChanged: (value) {},
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              ListView.builder(
                  shrinkWrap: true,
                  physics: new NeverScrollableScrollPhysics(),
                  itemCount: 10,
                  itemBuilder: (build, index) {
                    return CardHistoricVaccine();
                  })
            ],
          ),
        ),
      ),
    );
  }
}
