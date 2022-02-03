import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:suvic_app/routes/app_page.dart';
import 'package:suvic_app/utils/styles/style.dart';

class B2cMyAgendamentPage extends StatelessWidget {
  B2cMyAgendamentPage({Key? key}) : super(key: key);

  List<String> list =['a','b','c','d','e'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorKPrimaryColor[900],
        title: Text('Meus Agendamentos'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          child:
          Column(
            children: [
              ListView.builder(
                padding: EdgeInsets.only(bottom: 5),
                  shrinkWrap: true,
                  itemCount: list.length,
                  itemBuilder:(context, index){
                   return
                       SizedBox(
                         width: 300,
                         height: 120,
                         child: InkWell(
                           onTap: ()=>Get.toNamed(Routes.B2C_SHOW_MY_AGENDAMENTS_PAGE),
                           child: Card(
                             child:
                             Column(
                               children: [
                                 Padding(
                                   padding: const EdgeInsets.all(8.0),
                                   child: Row(
                                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                     children: [
                                       Text("Nome:",style: TextStyle(fontWeight: FontWeight.bold),),
                                       Text("Fulano de tal")
                                     ],
                                   ),
                                 ),
                                 Padding(
                                   padding: const EdgeInsets.all(8.0),
                                   child: Row(
                                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                     children: [
                                       Text("Data:",style: TextStyle(fontWeight: FontWeight.bold),),
                                       Text("dd/mm/aaaa")
                                     ],
                                   ),
                                 ),
                                 Padding(
                                   padding: const EdgeInsets.all(8.0),
                                   child: Row(
                                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                     children: [
                                       Text("Horário:",style: TextStyle(fontWeight: FontWeight.bold),),
                                       Text("hh:mm")
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
    );
  }
}
