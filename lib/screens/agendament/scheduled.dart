import 'package:covid_19/controllers/ScheduledController.dart';
import 'package:covid_19/controllers/StockController.dart';
import 'package:covid_19/controllers/user_controller.dart';
import 'package:covid_19/models/stock_vacine_model.dart';
import 'package:covid_19/repositories/ScheduledRepository.dart';
import 'package:covid_19/screens/agendament/graphics/pie_chart.dart';
import 'package:covid_19/utils/styles/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class Scheduled extends StatefulWidget {
  const Scheduled({Key? key}) : super(key: key);

  @override
  _ScheduledState createState() => _ScheduledState();
}

class _ScheduledState extends State<Scheduled> {
  TextEditingController vaccine = TextEditingController();
  TextEditingController lote = TextEditingController();
  TextEditingController datavalidade = TextEditingController();
  TextEditingController quantidade = TextEditingController();
  TextEditingController valor = TextEditingController();
  UserController user = Get.find();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 3,
        initialIndex: 1,
        child: Scaffold(
          appBar: AppBar(
            toolbarHeight: 74,
            automaticallyImplyLeading: false,
            backgroundColor: kPrimaryColor,
            bottom: TabBar(indicatorColor: Colors.white, tabs: [
              Tab(child: Text('Concluídos'), icon: Icon(Icons.done)),
              Tab(child: Text('Dashboard'), icon: Icon(Icons.dashboard)),
              Tab(child: Text('Pendentes'), icon: Icon(Icons.schedule)),
            ]),
          ),
          body: GetBuilder<ScheduledController>(
              init: ScheduledController(),
              builder: (controller) {
                return controller.loading
                    ? Center(
                        child: Container(
                          width: 50,
                          height: 50,
                          child: CircularProgressIndicator(
                            color: kPrimaryColor,
                          ),
                        ),
                      )
                    : TabBarView(children: [
                        Center(
                          child: agendamentDone(controller),
                        ),
                        Center(
                          child: dashbaordTabPage(controller),
                        ),
                        Center(
                          child: agendamentPendent(controller),
                        ),
                      ]);
              }),
        ),
      ),
    );
  }

  Widget agendamentDone(ScheduledController controller) {
    var scheduleds = controller.scheduleds
        .where((element) => element.status == 'complete')
        .toList();
    var price = 0;
    final oCcy = NumberFormat("R\$ #,##0.00", "en_US");

    return scheduleds.length == 0
        ? Center(child: Text('Sem agendamentos concluídos'))
        : Padding(
            padding: const EdgeInsets.all(10.0),
            child: ListView.builder(
                itemCount: scheduleds.length,
                itemBuilder: (context, index) {
                  var time = (scheduleds[index].time ?? 0.0).toString();
                  String? status;
                  switch (scheduleds[index].status) {
                    case 'scheduled':
                      status = 'Agendado';
                      break;
                    case 'late':
                      status = 'Atrasado';
                      break;
                    case 'complete':
                      status = 'Concluído';
                      break;
                    case 'scheduledPaid':
                      status = 'Agendado pago';
                      break;
                    case 'latePaid':
                      status = 'Atrasado pago';
                      break;
                    case 'canceledPaid':
                      status = 'Cancelado pago';
                      break;
                    default:
                      status = 'Desconhecido';
                  }
                  return Slidable(
                    actionPane: SlidableDrawerActionPane(),
                    actionExtentRatio: 0.25,
                    child: Container(
                      color: Colors.white,
                      child: Card(
                        child: ExpansionTile(
                          leading: Icon(
                            Icons.medication,
                            color: kPrimaryColor,
                          ),
                          title: Text(scheduleds[index].user?.civilName ?? ''),
                          subtitle: Text(
                            scheduleds[index].date ?? '',
                          ),
                          children: [
                            ListTile(
                              leading: Icon(Icons.inventory),
                              title: Text('Slot'),
                              subtitle: Text(scheduleds[index].slot.toString()),
                            ),
                            ListTile(
                              leading: Icon(Icons.timer),
                              title: Text('Horário'),
                              subtitle: Text(time),
                            ),
                            ListTile(
                              leading: Icon(Icons.military_tech),
                              title: Text('Estatus'),
                              subtitle: Text(status),
                            ),
                            ListTile(
                              leading: Icon(Icons.badge),
                              title: Text('CPF'),
                              subtitle: Text(scheduleds[index].user?.cpf ?? ''),
                            ),
                            ListTile(
                              leading: Icon(Icons.date_range),
                              title: Text('Data de nascimento'),
                              subtitle:
                                  Text(scheduleds[index].user?.birthdate ?? ''),
                            ),
                            ListTile(
                              leading:
                                  (scheduleds[index].user?.sex ?? '') == 'M'
                                      ? Icon(Icons.male)
                                      : Icon(Icons.female),
                              title: Text('Sexo'),
                              subtitle: Text(
                                  (scheduleds[index].user?.sex ?? '') == 'M'
                                      ? 'Masculino'
                                      : 'Femenino'),
                            ),
                            ListTile(
                              leading: Icon(Icons.date_range),
                              title: Text('E-mail'),
                              subtitle:
                                  Text(scheduleds[index].user?.email ?? ''),
                            ),
                            // ListTile(
                            //   leading: Icon(Icons.calendar_today),
                            //   title: Text('Data de Validade'),
                            //   subtitle: Text(vacines[index].dataValidade),
                            // ),
                            // ListTile(
                            //   leading: Icon(Icons.schedule),
                            //   title: Text('Reservadas'),
                            //   subtitle:
                            //       Text(vacines[index].reserved.toString()),
                            // ),
                            // ListTile(
                            //   leading: Icon(Icons.attach_money),
                            //   title: Text('Valor'),
                            //   subtitle: Text(oCcy.format(price)),
                            // ),
                          ],
                        ),
                      ),
                    ),
                    actions: <Widget>[
                      // IconSlideAction(
                      //   color: Colors.blue,
                      //   icon: Icons.add,
                      //   onTap: () => _add(vacines[index]),
                      // ),
                      // IconSlideAction(
                      //   color: Colors.indigo,
                      //   icon: Icons.remove,
                      //   onTap: () => _remove(vacines[index]),
                      // ),
                    ],
                    secondaryActions: <Widget>[
                      // IconSlideAction(
                      //   color: Colors.red,
                      //   icon: Icons.delete,
                      //   onTap: () => controller.delete(vacines[index]),
                      // ),
                    ],
                  );
                }),
          );
  }

  Widget dashbaordTabPage(ScheduledController controller) {
    return
        // controller.vaccineInChart.length == 4
        //     ?
        Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: double.maxFinite,
        height: 600,
        child: PieChartScheduled(scheduleds: controller.scheduleds),
      ),
    );
    // : Center(
    //     child: Text('Stock de Vacinas'),
    //   );
  }

  Widget agendamentPendent(ScheduledController controller) {
    var scheduleds = controller.scheduleds
        .where((element) => element.status != 'complete')
        .toList();
    var price = 0;
    final oCcy = NumberFormat("R\$ #,##0.00", "en_US");

    return scheduleds.length == 0
        ? Center(child: Text('Sem agendamentos concluídos'))
        : Padding(
            padding: const EdgeInsets.all(10.0),
            child: ListView.builder(
                itemCount: scheduleds.length,
                itemBuilder: (context, index) {
                  var time = (scheduleds[index].time ?? 0.0).toString();
                  String? status;
                  switch (scheduleds[index].status) {
                    case 'scheduled':
                      status = 'Agendado';
                      break;
                    case 'late':
                      status = 'Atrasado';
                      break;
                    case 'complete':
                      status = 'Concluído';
                      break;
                    case 'scheduledPaid':
                      status = 'Agendado pago';
                      break;
                    case 'latePaid':
                      status = 'Atrasado pago';
                      break;
                    case 'canceledPaid':
                      status = 'Cancelado pago';
                      break;
                    default:
                      status = 'Desconhecido';
                  }
                  return Slidable(
                    actionPane: SlidableDrawerActionPane(),
                    actionExtentRatio: 0.25,
                    child: Container(
                      color: Colors.white,
                      child: Card(
                        child: ExpansionTile(
                          leading: Icon(
                            Icons.medication,
                            color: kPrimaryColor,
                          ),
                          title: Text(scheduleds[index].user?.civilName ?? ''),
                          subtitle: Text(
                            scheduleds[index].date ?? '',
                          ),
                          children: [
                            ListTile(
                              leading: Icon(Icons.inventory),
                              title: Text('Slot'),
                              subtitle: Text(scheduleds[index].slot.toString()),
                            ),
                            ListTile(
                              leading: Icon(Icons.timer),
                              title: Text('Horário'),
                              subtitle: Text(time),
                            ),
                            ListTile(
                              leading: Icon(Icons.military_tech),
                              title: Text('Estatus'),
                              subtitle: Text(status),
                            ),
                            ListTile(
                              leading: Icon(Icons.badge),
                              title: Text('CPF'),
                              subtitle: Text(scheduleds[index].user?.cpf ?? ''),
                            ),
                            ListTile(
                              leading: Icon(Icons.date_range),
                              title: Text('Data de nascimento'),
                              subtitle:
                                  Text(scheduleds[index].user?.birthdate ?? ''),
                            ),
                            ListTile(
                              leading:
                                  (scheduleds[index].user?.sex ?? '') == 'M'
                                      ? Icon(Icons.male)
                                      : Icon(Icons.female),
                              title: Text('Sexo'),
                              subtitle: Text(
                                  (scheduleds[index].user?.sex ?? '') == 'M'
                                      ? 'Masculino'
                                      : 'Femenino'),
                            ),
                            ListTile(
                              leading: Icon(Icons.date_range),
                              title: Text('E-mail'),
                              subtitle:
                                  Text(scheduleds[index].user?.email ?? ''),
                            ),
                            // ListTile(
                            //   leading: Icon(Icons.calendar_today),
                            //   title: Text('Data de Validade'),
                            //   subtitle: Text(vacines[index].dataValidade),
                            // ),
                            // ListTile(
                            //   leading: Icon(Icons.schedule),
                            //   title: Text('Reservadas'),
                            //   subtitle:
                            //       Text(vacines[index].reserved.toString()),
                            // ),
                            // ListTile(
                            //   leading: Icon(Icons.attach_money),
                            //   title: Text('Valor'),
                            //   subtitle: Text(oCcy.format(price)),
                            // ),
                          ],
                        ),
                      ),
                    ),
                    actions: <Widget>[
                      // IconSlideAction(
                      //   color: Colors.blue,
                      //   icon: Icons.add,
                      //   onTap: () => _add(vacines[index]),
                      // ),
                      // IconSlideAction(
                      //   color: Colors.indigo,
                      //   icon: Icons.remove,
                      //   onTap: () => _remove(vacines[index]),
                      // ),
                    ],
                    secondaryActions: <Widget>[
                      // IconSlideAction(
                      //   color: Colors.red,
                      //   icon: Icons.delete,
                      //   onTap: () => controller.delete(vacines[index]),
                      // ),
                    ],
                  );
                }),
          );
  }

  void addVacineInStock(StockController controller) {
    if (_formKey.currentState!.validate()) {
      //valid name of vacine
      if (controller.vaccines.contains(vaccine.text)) {
        controller.insert(
          StockVacineModel(
            name: vaccine.text,
            lote: lote.text,
            dataValidade: datavalidade.text,
            quantidade: int.parse(quantidade.text),
            price: int.parse(valor.text),
          ),
        );
        // controller.insertPrice(
        //   PriceVacine(
        //     vacine: vaccine.text,
        //     price: int.parse(valor.text),
        //   ),
        // );
      } else {
        Get.snackbar(
          'Erro no Formulario',
          'Selecione nome valido na lista de vacinas',
          colorText: Colors.white,
          backgroundColor: Colors.deepOrange,
        );
      }
    }
  }

  _add(StockVacineModel vacine) {
    Get.defaultDialog(
      radius: 5,
      title: 'Adicionar',
      content: Container(
        width: 350,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: TextFormField(
                enabled: false,
                initialValue: vacine.name,
                decoration: InputDecoration(
                  isDense: true,
                  prefixIcon: Icon(Icons.medication),
                  //enabledBorder: InputBorder.none,
                  border: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(
                      const Radius.circular(10.0),
                    ),
                  ),
                ),
                keyboardType: TextInputType.number,
              ),
            ),
            TextFormField(
              decoration: InputDecoration(
                isDense: true,
                prefixIcon: Icon(Icons.plus_one),
                labelText: 'Quantidade',
                hintText: 'Quantidade',
                //enabledBorder: InputBorder.none,
                border: OutlineInputBorder(
                  borderRadius: const BorderRadius.all(
                    const Radius.circular(10.0),
                  ),
                ),
              ),
              keyboardType: TextInputType.number,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 150,
                    child: ElevatedButton(
                      onPressed: () => Get.back(),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                          Color(0xff303f9f),
                        ),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                        ),
                      ),
                      child: Text('Cancelar'),
                    ),
                  ),
                  Container(
                    width: 150,
                    child: ElevatedButton(
                      onPressed: () => Get.back(),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                          Color(0xff303f9f),
                        ),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                        ),
                      ),
                      child: Text('Adicionar'),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  _remove(StockVacineModel vacine) {
    Get.defaultDialog(
      radius: 5,
      title: 'Reduzir',
      content: Container(
        width: 350,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: TextFormField(
                enabled: false,
                initialValue: vacine.name,
                decoration: InputDecoration(
                  isDense: true,
                  prefixIcon: Icon(Icons.medication),
                  //enabledBorder: InputBorder.none,
                  border: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(
                      const Radius.circular(10.0),
                    ),
                  ),
                ),
                keyboardType: TextInputType.number,
              ),
            ),
            TextFormField(
              decoration: InputDecoration(
                isDense: true,
                prefixIcon: Icon(Icons.plus_one),
                labelText: 'Quantidade',
                hintText: 'Quantidade',
                //enabledBorder: InputBorder.none,
                border: OutlineInputBorder(
                  borderRadius: const BorderRadius.all(
                    const Radius.circular(10.0),
                  ),
                ),
              ),
              keyboardType: TextInputType.number,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 150,
                    child: ElevatedButton(
                      onPressed: () => Get.back(),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                          Color(0xff303f9f),
                        ),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                        ),
                      ),
                      child: Text('Cancelar'),
                    ),
                  ),
                  Container(
                    width: 150,
                    child: ElevatedButton(
                      onPressed: () => Get.back(),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                          Color(0xff303f9f),
                        ),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                        ),
                      ),
                      child: Text('Reduzir'),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
