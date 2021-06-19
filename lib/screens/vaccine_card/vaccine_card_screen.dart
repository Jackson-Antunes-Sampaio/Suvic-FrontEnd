import 'package:covid_19/common/icon_button_custom.dart';
import 'package:covid_19/common/my_header_widget.dart';
import 'package:covid_19/controllers/vaccines_controller.dart';
import 'package:covid_19/screens/vaccine_card/components/vaccine_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VaccineCardScreen extends StatefulWidget {
  @override
  _VaccineCardScreenState createState() => _VaccineCardScreenState();
}

class _VaccineCardScreenState extends State<VaccineCardScreen> {
  final controller = ScrollController();
  final VaccinesController vaccinesController = Get.put(VaccinesController());
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
                          Text("2 Dependentes", style: TextStyle(fontSize: 11),),
                          Icon(Icons.arrow_drop_down)
                        ],
                      ),
                      textColor: Colors.blue[700],
                    ),
                  ),
                ),
              ],
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: new NeverScrollableScrollPhysics(),
              itemCount: vaccinesController.vaccinesCard.length,
                itemBuilder: (build, index){
                String date = vaccinesController.vaccinesCard[index].applicationDate!.split("-").last + "/" + vaccinesController.vaccinesCard[index].applicationDate!.split("-")[1] + "/" + vaccinesController.vaccinesCard[index].applicationDate!.split("-").first;
                  return VaccineItem(
                      title: "${vaccinesController.vaccinesCard[index].vaccine?.name}",
                      quantity: "1º dose",
                      date: "${date}",
                      city: "São Paulo",
                      local: "Ubs Maria Tereza De Andrade"
                  );
                })
          ],
        ),
      ),

    );
  }
}
