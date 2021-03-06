import 'package:suvic_app/common/icon_button_custom.dart';
import 'package:suvic_app/common/my_header_widget.dart';
import 'package:suvic_app/controllers/vaccines_controller.dart';
import 'package:suvic_app/screens/vaccine_card/components/vaccine_item.dart';
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
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

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
      key: scaffoldKey,
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
                          hintStyle: TextStyle(color: Colors.blue[700]),
                          border: OutlineInputBorder(
                            borderRadius: const BorderRadius.all(
                              const Radius.circular(10.0),
                            ),
                          ),
                        ),
                        onChanged: (value) {
                          vaccinesController.filter(value);
                        },
                      ),
                    ),
                  ),
                ),
                // Padding(
                //   padding: EdgeInsets.only(right: 10),
                //   child: Container(
                //     height: 45,
                //     decoration: BoxDecoration(
                //         color: Colors.white,
                //         borderRadius: BorderRadius.circular(10),
                //         border: Border.all(color: Colors.grey)),
                //     child: FlatButton(
                //       onPressed: () {
                //         scaffoldKey.currentState?.showSnackBar(
                //           SnackBar(content: Text("Em Manuten????o"))
                //         );
                //       },
                //       child: Row(
                //         children: [
                //           Text(
                //             "2 Dependentes",
                //             style: TextStyle(fontSize: 11),
                //           ),
                //           Icon(Icons.arrow_drop_down)
                //         ],
                //       ),
                //       textColor: Colors.blue[700],
                //     ),
                //   ),
                // ),
              ],
            ),
            Obx(() {
              if(vaccinesController.loading.value){
                return Center(
                  child: CircularProgressIndicator(),
                );
              }else{
                if(vaccinesController.vaccinesFilterCard.isEmpty){
                  return Column(
                    children: [
                      SizedBox(height: 30,),
                      Padding(padding: EdgeInsets.symmetric(horizontal: 20), child:
                      Text('''Caro usu??rio, nesse espa??o estar?? presente todo seu hist??rico de vacinas, em um primeiro momento constar??o todas vacinas que realizar diretamente pelo nosso app, estamos trabalhando para em pouco tempo trazer todas suas vacinas realizadas no SUS tamb??m, muita facilidade n??? adeus carteirinha de papel!
                      ''',
                        textAlign: TextAlign.center,
                      ),),
                    ],
                  );
                }else{
                  return ListView.builder(
                      shrinkWrap: true,
                      physics: new NeverScrollableScrollPhysics(),
                      itemCount: vaccinesController.vaccinesFilterCard.length,
                      itemBuilder: (build, index) {
                        String date;
                        if(vaccinesController.vaccinesFilterCard[index].applicationDate == null){
                          date = "-";
                        }else{
                          date = vaccinesController
                              .vaccinesFilterCard[index].applicationDate!
                              .split("-")
                              .last +
                              "/" +
                              vaccinesController
                                  .vaccinesFilterCard[index].applicationDate!
                                  .split("-")[1] +
                              "/" +
                              vaccinesController
                                  .vaccinesFilterCard[index].applicationDate!
                                  .split("-")
                                  .first;
                        }

                        return VaccineItem(
                            title:
                            "${vaccinesController.vaccinesFilterCard[index].vaccine?.name}",
                            quantity: vaccinesController.vaccinesFilterCard[index].doseNumber == null ? "" : "${vaccinesController.vaccinesFilterCard[index].doseNumber}?? dose",
                            date: "${date}",
                            city: "S??o Paulo",
                            status : vaccinesController.statusToUser("${vaccinesController.vaccinesFilterCard[index].status}"));
                      });

                }
              }
            }),
            SizedBox(height: 10,)
          ],

        ),
      ),
    );
  }
}
