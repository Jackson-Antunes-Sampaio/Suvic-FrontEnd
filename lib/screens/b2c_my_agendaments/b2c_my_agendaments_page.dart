import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:suvic_app/controllers/b2c_my_agendament_controller.dart';
import 'package:suvic_app/routes/app_page.dart';
import 'package:suvic_app/utils/styles/style.dart';

class B2cMyAgendamentPage extends StatelessWidget {
  B2cMyAgendamentPage({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorKPrimaryColor[900],
        title: Text('Meus Agendamentos'),
        centerTitle: true,
      ),
      body: GetBuilder(
        init: B2cMyagendamentController(),
        builder: (B2cMyagendamentController controller)=>
            SingleChildScrollView(
              child: Container(
                child:
                Column(
                  children: [
                    ListView.builder(
                        padding: EdgeInsets.only(bottom: 5),
                        shrinkWrap: true,
                        itemCount: controller.list.length,
                        itemBuilder:(context, index){
                          return
                            SizedBox(
                              width: 300,
                              height: 120,
                              child: InkWell(
                                onTap: ()=>Get.toNamed(Routes.B2C_SHOW_MY_AGENDAMENTS_PAGE,arguments: controller.list[index]),
                                child: Card(
                                  child:
                                  Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text("Vacina:",style: TextStyle(fontWeight: FontWeight.bold),),
                                            Text("${controller.list[index].vaccineName}")
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text("Status:",style: TextStyle(fontWeight: FontWeight.bold),),
                                            Text(controller.statusToUser(controller.list[index].status!))
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text("Dose:",style: TextStyle(fontWeight: FontWeight.bold),),
                                            Text("${controller.list[index].doseNumber ?? '-'}")
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                        })
                  ],
                ),
              ),
            )
        ,
      )    );
  }
}
