import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:suvic_app/controllers/b2c_show_my_agendaments_controller.dart';
import 'package:suvic_app/controllers/home_controller.dart';
import 'package:suvic_app/utils/styles/style.dart';

class B2cShowMyAgendamentsPage extends StatelessWidget {
   B2cShowMyAgendamentsPage({Key? key}) : super(key: key);
  final ButtonStyle style = ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20,color:Colors.indigo  ));
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init:B2cShowMyAgendamentsController() ,
        builder: (B2cShowMyAgendamentsController controller)=>Scaffold(
        appBar: AppBar(
          backgroundColor: colorKPrimaryColor[900],
          title: Text('Meus Agendamentos'),
          centerTitle: true,
        ),
        body: Container(
          height: Get.height,
          child: Column(
            children: [
            SizedBox(height: 20,),
              Flexible(
                  flex: 2,
                  child: Text('Dados sobre seu atendimento:',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),)),
Flexible(
    flex: 4,
    child:               Column(
      mainAxisAlignment: MainAxisAlignment.center,
  children: [
    Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("Vacina:",style: TextStyle(fontWeight: FontWeight.bold),),
          Text(controller.data.vaccineName.toString())
        ],
      ),
    ),
    Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("Status:",style: TextStyle(fontWeight: FontWeight.bold),),
          Text(controller.statusToUser(controller.data.status.toString()))
        ],
      ),
    ),
    Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("Dose:",style: TextStyle(fontWeight: FontWeight.bold),),
          Text("${controller.data.doseNumber ?? '-'}")
        ],
      ),
    )
  ],
)),
Flexible(
    flex: 1,
    child:               Column(children: [
  ElevatedButton(onPressed:(){
    controller.alterAgendament();
  }, child:Text('ALTERAR AGENDAMENTO'),style: style,),
  ElevatedButton(onPressed:(){
    controller.cancelAgendament();
  }, child:Text('CANCELAR AGENDAMENTO'),style: style,)
],)
)            ],
          ),
        )

    ));
  }
}
