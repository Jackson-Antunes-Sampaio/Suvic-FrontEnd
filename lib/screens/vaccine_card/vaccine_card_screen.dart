import 'package:covid_19/common/icon_button_custom.dart';
import 'package:covid_19/common/my_header_widget.dart';
import 'package:covid_19/screens/vaccine_card/components/vaccine_item.dart';
import 'package:flutter/material.dart';

class VaccineCardScreen extends StatefulWidget {
  @override
  _VaccineCardScreenState createState() => _VaccineCardScreenState();
}

class _VaccineCardScreenState extends State<VaccineCardScreen> {
  final controller = ScrollController();
  double offset = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.addListener(onScroll);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    controller.dispose();
    super.dispose();
  }

  void onScroll() {
    setState(() {
      offset = (controller.hasClients) ? controller.offset : 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        controller: controller,
        child: Column(
          children: [
            MyHeader(
              image: "assets/images/covid-19-vaccine.png",
              offset: offset,
              textTop: "\nCarteira",
              textBottom: "de vacina",
            ),
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Container(
                      height: 45,
                      child: TextField(
                        decoration: InputDecoration(
                          isDense: true,
                          prefixIcon: IconButtonCustom(
                            iconData: Icons.search,
                          ),
                          hintText: "Filtro",
                          hintStyle: TextStyle(
                            color: Colors.blue[700]
                          ),
                          border: OutlineInputBorder(
                            borderRadius: const BorderRadius.all(
                              const Radius.circular(10.0),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 10),
                  child: Container(
                    height: 45,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.grey)
                    ),
                    child: FlatButton(
                      onPressed: () {},
                      child: Row(
                        children: [
                          Text("2 Vacinas", style: TextStyle(fontSize: 11),),
                          Icon(Icons.arrow_drop_down)
                        ],
                      ),
                      textColor: Colors.blue[700],
                    ),
                  ),
                ),
              ],
            ),
            VaccineItem(
              title: "Novo Coronavirus (2019) - COVID 19",
              quantity: "1º dose",
              date: "25/03/2020",
              city: "São Paulo",
              local: "Ubs Maria Tereza De Andrade"
            ),
            VaccineItem(
                title: "Novo Coronavirus (2019) - COVID 19",
                quantity: "2º dose",
                date: "25/04/2020",
                city: "São Paulo",
                local: "Ubs Maria Tereza De Andrade"
            ),
          ],
        ),
      ),

    );
  }
}
