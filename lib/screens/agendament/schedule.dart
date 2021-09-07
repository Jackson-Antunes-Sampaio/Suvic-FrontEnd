import 'package:brasil_fields/brasil_fields.dart';
import 'package:cool_stepper_reloaded/cool_stepper_reloaded.dart';
import 'package:covid_19/common/icon_button_custom.dart';
import 'package:covid_19/controllers/StockController.dart';
import 'package:covid_19/controllers/agendament_controller.dart';
import 'package:covid_19/controllers/clinicController.dart';
import 'package:covid_19/controllers/credit_card_controller.dart';
import 'package:covid_19/controllers/time_slot.dart';
import 'package:covid_19/models/agendament_model.dart';
import 'package:covid_19/models/stock_vacine_model.dart';
import 'package:covid_19/models/time_slot.dart';
import 'package:covid_19/routes/app_page.dart';
import 'package:covid_19/screens/agendament/autocomplete/data/getTime.dart';
import 'package:covid_19/utils/styles/style.dart';
import 'package:flutter/material.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:get/get.dart';

import 'elements/cardInfoClinic.dart';

class Schedule extends StatefulWidget {
  final String clinic;
  Schedule({Key? key, required this.clinic}) : super(key: key);

  @override
  _ScheduleState createState() => _ScheduleState();
}

class _ScheduleState extends State<Schedule> {
  // String? selectedRole = 'Escrever';
  //schedule
  final AgendamentController agendamentController =
      Get.put(AgendamentController());
  final _formKey = GlobalKey<FormState>();
  final TextEditingController vaccine = TextEditingController();
  final TextEditingController time = TextEditingController();
  final TextEditingController data = TextEditingController();

  var maskDate = new MaskTextInputFormatter(mask: '##-##-####');
  final oCcy = NumberFormat("R\$ #,##0.00", "en_US");

  String? _dropdownValue;
  int? _dropdownValueSeleted;

  bool docilio = false;
  final markers = Set<Marker>();

  //producCard
  final CreditCardController creditCardController = Get.find();
  final GlobalKey<ScaffoldState> keyScaffold = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _keyForm = GlobalKey<FormState>();
  final TextEditingController clinicsController = TextEditingController();
  final TextEditingController productController = TextEditingController();
  final TextEditingController valueController = TextEditingController();

  @override
  void initState() {
    super.initState();
    creditCardController.stateProductCard.value = StateProductCard.IDL;
  }

  var load = false;

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    final StockController stockController =
        Get.put(StockController(idClinic: widget.clinic));
    final steps = [
      CoolStep(
          content: Container(
            width: double.maxFinite,
            height: 500,
            child: GetBuilder<StockController>(
              init: StockController(idClinic: widget.clinic),
              builder: (controllerStock) {
                var vaccines = controllerStock.vaccineInStock;
                var prices = controllerStock.priceVaccine;
                return controllerStock.loading
                    ? Center(
                        child: Container(
                          child: CircularProgressIndicator(
                            color: kPrimaryColor,
                          ),
                        ),
                      )
                    : vaccines.length == 0
                        ? Center(
                            child: Text('Sem vacina em estoque!'),
                          )
                        : ListView.builder(
                            padding: EdgeInsets.only(top: 0),
                            itemCount: vaccines.length,
                            itemBuilder: (context, index) {
                              var price = 0;

                              if ((prices.where((element) =>
                                      element.vacine ==
                                      vaccines[index].name)).length !=
                                  0) {
                                price = prices
                                    .firstWhere((element) =>
                                        element.vacine == vaccines[index].name)
                                    .price;
                              } else {
                                price = 0;
                              }

                              return (controllerStock.vacineSelected.where(
                                        (element) =>
                                            element.name ==
                                                vaccines[index].name &&
                                            element.lote ==
                                                vaccines[index].lote,
                                      )).length >
                                      0
                                  ? Card(
                                      child: ListTile(
                                        selected: true,
                                        leading: Image.asset(
                                          'assets/images/iconVacine.png',
                                          width: 30,
                                          height: 30,
                                        ),
                                        title: Text(vaccines[index].name),
                                        trailing: Text(oCcy.format(price)),
                                        onTap: () =>
                                            controllerStock.addVacineInCart(
                                          StockVacineModel(
                                            name: vaccines[index].name,
                                            lote: vaccines[index].lote,
                                            dataValidade:
                                                vaccines[index].dataValidade,
                                            quantidade: 1,
                                            reserved: 1,
                                            price: price,
                                          ),
                                        ),
                                      ),
                                    )
                                  : Card(
                                      child: ListTile(
                                        selected: false,
                                        leading: Image.asset(
                                          'assets/images/iconVacine.png',
                                          width: 30,
                                          height: 30,
                                        ),
                                        title: Text(vaccines[index].name),
                                        trailing: Text(oCcy.format(price)),
                                        onTap: () =>
                                            controllerStock.addVacineInCart(
                                          StockVacineModel(
                                            name: vaccines[index].name,
                                            lote: vaccines[index].lote,
                                            dataValidade:
                                                vaccines[index].dataValidade,
                                            quantidade: 1,
                                            reserved: 1,
                                            price: price,
                                          ),
                                        ),
                                      ),
                                    );
                            },
                          );
              },
            ),
          ),
          validation: () {
            if (StockController.to.vacineSelected.length == 0) {
              return 'clique em uma vacina para selecionar';
            } else {
              return null;
            }
          }),
      CoolStep(
        content: Form(
          key: _formKey,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(
                  top: 10,
                  bottom: 10,
                ),
                child: GetBuilder<StockController>(builder: (cStock) {
                  var value = '';
                  if ((cStock.vacineSelected).length > 0) {
                    value = cStock.vacineSelected.first.name;
                  } else {
                    value = '';
                  }
                  return TextFormField(
                    controller: vaccine..text = value,
                    enabled: false,
                    decoration: InputDecoration(
                      labelText: 'Vacina',
                      isDense: true,
                      disabledBorder: OutlineInputBorder(
                        borderRadius: const BorderRadius.all(
                          const Radius.circular(10.0),
                        ),
                        borderSide: BorderSide(
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  );
                }),
              ),
              GetBuilder<TimeSlotController>(
                  init: TimeSlotController(idClinic: widget.clinic),
                  builder: (controllerSlot) {
                    return controllerSlot.loading
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(bottom: 10),
                                child: GestureDetector(
                                  onTap: () async {
                                    controllerSlot.selectDate(context);
                                  },
                                  child: TextFormField(
                                    enabled: false,
                                    controller: data
                                      ..text = controllerSlot.showDate ?? '',
                                    keyboardType: TextInputType.number,
                                    inputFormatters: [
                                      //maskDate
                                      FilteringTextInputFormatter.digitsOnly,
                                      DataInputFormatter()
                                    ],
                                    // validator: (value) {
                                    //   if ((value ?? '').isEmpty) {
                                    //     return 'Selecione uma data';
                                    //   }
                                    //   // return '';
                                    // },
                                    decoration: InputDecoration(
                                      labelText: 'Data',
                                      isDense: true,
                                      prefixIcon: Icon(Icons.calendar_today),
                                      disabledBorder: OutlineInputBorder(
                                        borderRadius: const BorderRadius.all(
                                          const Radius.circular(10.0),
                                        ),
                                        borderSide: BorderSide(
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              controllerSlot.timeSlots.length > 0
                                  ? Padding(
                                      padding: EdgeInsets.only(
                                        bottom: 10,
                                      ),
                                      child: dropdownButtonSelectTimer(
                                          controllerSlot),
                                    )
                                  : Text(''),
                            ],
                          );
                  }),
            ],
          ),
        ),
        validation: () {
          if (!_formKey.currentState!.validate() || data.text.isEmpty) {
            return 'Preencha o formulário corretamente';
          }
          return null;
        },
      ),
      CoolStep(
        content: Obx(() {
          switch (creditCardController.stateProductCard.value) {
            case StateProductCard.LOADING:
              return Center(
                child: CircularProgressIndicator(),
              );
              break;
            case StateProductCard.IDL:
              return SingleChildScrollView(
                child: load
                    ? Container(
                        width: double.maxFinite,
                        height: 300,
                        child: Center(
                            child: Container(
                          width: 50,
                          height: 50,
                          child: CircularProgressIndicator(
                            color: kPrimaryColor,
                          ),
                        )),
                      )
                    : Form(
                        key: _keyForm,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 10, bottom: 8),
                          child: Column(
                            children: [
                              TextFormField(
                                controller: clinicsController
                                  ..text = ClinicController.to.clinic.name
                                      .toString(),
                                enabled: false,
                                decoration: InputDecoration(
                                  labelText: 'Nome da Clinica',
                                  isDense: true,
                                  disabledBorder: OutlineInputBorder(
                                    borderRadius: const BorderRadius.all(
                                      const Radius.circular(10.0),
                                    ),
                                    borderSide: BorderSide(
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              GetBuilder<StockController>(builder: (cStock) {
                                var value = '';
                                if ((cStock.vacineSelected).length > 0) {
                                  value = cStock.vacineSelected.first.name;
                                } else {
                                  value = '';
                                }
                                return TextFormField(
                                  controller: productController..text = value,
                                  enabled: false,
                                  decoration: InputDecoration(
                                    labelText: 'Produto/Vacina',
                                    isDense: true,
                                    disabledBorder: OutlineInputBorder(
                                      borderRadius: const BorderRadius.all(
                                        const Radius.circular(10.0),
                                      ),
                                      borderSide: BorderSide(
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                                );
                              }),
                              SizedBox(
                                height: 10,
                              ),
                              GetBuilder<StockController>(builder: (cStock) {
                                var value = 0;
                                if ((cStock.vacineSelected).length > 0) {
                                  value =
                                      cStock.vacineSelected.first.price ?? 0;
                                } else {
                                  value = 0;
                                }
                                return TextFormField(
                                  controller: valueController
                                    ..text = value.toString(),
                                  enabled: false,
                                  decoration: InputDecoration(
                                    labelText: 'Valor (R\$',
                                    isDense: true,
                                    disabledBorder: OutlineInputBorder(
                                      borderRadius: const BorderRadius.all(
                                        const Radius.circular(10.0),
                                      ),
                                      borderSide: BorderSide(
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                                );
                              }),
                              SizedBox(
                                height: 10,
                              ),
                              Obx(() {
                                return Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    creditCardController.pagarMeModel.value
                                                .cardNumber ==
                                            null
                                        ? FlatButton(
                                            color: Colors.blueAccent,
                                            textColor: Colors.white,
                                            onPressed: () {
                                              Get.toNamed(Routes.CREDITCARDS2);
                                            },
                                            child: Text(
                                              "Adicionar Cartão",
                                            ),
                                          )
                                        : Expanded(
                                            child: Container(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 10, horizontal: 10),
                                              decoration: BoxDecoration(
                                                  color: kPrimaryColor,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          15)),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    "N° Cartão: *******${creditCardController.pagarMeModel.value.cardNumber?.substring(16 - 4)}",
                                                    style: TextStyle(
                                                        fontSize: 20,
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  IconButtonCustom(
                                                    onTap: () {},
                                                    iconData: Icons.edit,
                                                    color: Colors.white,
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                  ],
                                );
                              }),
                            ],
                          ),
                        ),
                      ),
              );
              break;
            case StateProductCard.SUCCESS:
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Transação realizada com sucesso",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Icon(
                      Icons.check,
                      color: Colors.green,
                      size: 100,
                    )
                  ],
                ),
              );
              break;
            case StateProductCard.FAIL:
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Transação recusada, tente novamente mais tarde",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Icon(
                      Icons.close,
                      color: Colors.red,
                      size: 100,
                    )
                  ],
                ),
              );
              break;
          }
        }),
        validation: () {
          if (!_keyForm.currentState!.validate()) {
            return 'Preencha o formulário corretamente';
          } else {
            if (creditCardController.pagarMeModel.value.cardNumber == null) {
              return 'Adicione um Cartão de Credito';
            }
          }
          return null;
        },
      ),
    ];

    void _onFinish() async {
      // PAGAR-ME
      creditCardController.pagarMeModel.value.items![0]!.quantity = 1;
      creditCardController.pagarMeModel.value.items![0]!.id = "1";
      creditCardController.pagarMeModel.value.amount =
          int.parse(valueController.text) * 100;
      creditCardController.pagarMeModel.value.items![0]!.unitPrice =
          int.parse(valueController.text) * 100;
      creditCardController.pagarMeModel.value.items![0]!.title =
          productController.text;
      creditCardController.pagarMeModel.value.items![0]!.tangible = true;
      creditCardController.transactionsPagarme();

      final flush = Flushbar(
        message: 'Agendamento concluído com sucesso!',
        flushbarStyle: FlushbarStyle.FLOATING,
        margin: EdgeInsets.all(8.0),
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
        icon: Icon(
          Icons.check_circle_outline_outlined,
          size: 28.0,
          color: Colors.green,
        ),
        duration: Duration(seconds: 2),
        leftBarIndicatorColor: Colors.green,
      );

      setState(() {
        load = true;
      });

      var res = await AgendamentController.to.insert(AgendementModel(
        vaccine: vaccine.text,
        date: data.text,
        slot: _dropdownValueSeleted,
        clinicId: int.parse(widget.clinic),
      ));

      setState(() {
        load = false;
      });

      if (res == 0) {
        flush.show(context);
      } else {
        switch (res) {
          case 1:
            Flushbar(
              message: 'Já tens um agendamento marcado para este dia',
              flushbarStyle: FlushbarStyle.FLOATING,
              margin: EdgeInsets.all(8.0),
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
              icon: Icon(
                Icons.info_outline_rounded,
                size: 28.0,
                color: Colors.orange,
              ),
              duration: Duration(seconds: 3),
              leftBarIndicatorColor: Colors.orange,
            ).show(context);
            break;
          default:
            Flushbar(
              message: 'Ocorreu um erro interno',
              flushbarStyle: FlushbarStyle.FLOATING,
              margin: EdgeInsets.all(8.0),
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
              icon: Icon(
                Icons.cancel_outlined,
                //             Icons.info_outline_rounded,
                size: 28.0,
                color: Colors.red,
              ),
              duration: Duration(seconds: 3),
              leftBarIndicatorColor: Colors.red,
            ).show(context);
        }
      }
    }

    final stepper = CoolStepper(
      showErrorSnackbar: true,
      isHeaderEnabled: false,
      hasRoundedCorner: false,
      onCompleted: _onFinish,
      contentPadding: EdgeInsets.only(left: 4, right: 4),
      config: CoolStepperConfig(
        stepText: '',
        ofText: 'de',
        headerColor: Colors.white,
        stepColor: Colors.white,
        finishButton: Container(
          child: ElevatedButton.icon(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(
                kPrimaryColor,
              ),
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
            ),
            onPressed: () {},
            icon: Icon(Icons.done),
            label: Text('Finalizar'),
          ),
        ),
        backButton: ElevatedButton.icon(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(
              kPrimaryColor,
            ),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
            ),
          ),
          onPressed: () {},
          icon: Icon(Icons.navigate_before),
          label: Text('Voltar'),
        ),
        nextButton: ElevatedButton.icon(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(
              kPrimaryColor,
            ),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
            ),
          ),
          onPressed: () {},
          icon: Icon(Icons.navigate_next),
          label: Text('Proxímo'),
        ),
      ),
      steps: steps,
    );

    return Scaffold(
      body: widget.clinic.isEmpty
          ? Center(child: Text('Selecione uma clinica'))
          : SafeArea(
              child: GetBuilder<ClinicController>(
                  init: ClinicController(idClinic: widget.clinic),
                  builder: (controller) {
                    //clinic selected by id
                    var clinic = controller.clinic;
                    //Get all vacine in stock
                    var vaccinesInCart = StockController.to.vacineSelected;
                    //data GEOLOCATION
                    var latitude = clinic.latitude ?? 0.0;
                    var longitude = clinic.longitude ?? 0.0;
                    return controller.loading
                        ? Center(
                            child: Container(
                              width: 70,
                              height: 70,
                              child: CircularProgressIndicator(
                                color: kPrimaryColor,
                              ),
                            ),
                          )
                        : Container(
                            child: Column(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    child: Column(
                                      children: [
                                        Expanded(
                                          child: Container(
                                            width: double.maxFinite,
                                            child: GoogleMap(
                                              mapType: MapType.terrain,
                                              zoomControlsEnabled: false,
                                              initialCameraPosition:
                                                  CameraPosition(
                                                target: LatLng(
                                                  latitude,
                                                  longitude,
                                                ),
                                                zoom: 26,
                                              ),
                                              onMapCreated: (GoogleMapController
                                                  gmc) async {
                                                markers.add(
                                                  Marker(
                                                    markerId: MarkerId(
                                                        clinic.id.toString()),
                                                    position: LatLng(
                                                        latitude, longitude),
                                                    infoWindow: InfoWindow(
                                                        title: clinic.name),
                                                    icon: await BitmapDescriptor
                                                        .fromAssetImage(
                                                      ImageConfiguration(),
                                                      'assets/images/hospital128px.png',
                                                    ),
                                                  ),
                                                );
                                                setState(() {});
                                              },
                                              myLocationEnabled: true,
                                              mapToolbarEnabled: false,
                                              markers: markers,
                                            ),
                                          ),
                                        ),
                                        controller.seachStatus
                                            ? GetBuilder<StockController>(
                                                builder: (cst) {
                                                return cst
                                                        .vacineSelected.isEmpty
                                                    ? seachCard(
                                                        context, controller)
                                                    : showCompanyNameCard(
                                                        clinic, controller);
                                              })
                                            : showCompanyNameCard(
                                                clinic, controller)
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: stepper,
                                  ),
                                ),
                              ],
                            ),
                          );
                  }),
            ),
    );
  }

  Widget dropdownButtonSelectTimer(TimeSlotController controller) {
    return DropdownButtonFormField<String>(
      value: _dropdownValue,
      decoration: InputDecoration(
        isDense: true,
        //enabledBorder: InputBorder.none,
        border: OutlineInputBorder(
          borderRadius: const BorderRadius.all(
            const Radius.circular(10.0),
          ),
        ),
      ),
      focusColor: Colors.deepOrange,
      icon: Icon(
        Icons.arrow_downward,
        color: Colors.grey.shade600,
      ),
      hint: const Text('Selecione o horário'),
      iconSize: 24,
      elevation: 16,
      style: const TextStyle(color: Colors.black87),
      onChanged: (String? newValue) {
        _dropdownValue = newValue;
        _dropdownValueSeleted = controller.slotSeleted.first.slot;
      },
      items: GetTimeScheld.getTimer(controller)
          .map<DropdownMenuItem<String>>((value) {
        return DropdownMenuItem<String>(
          value: value['value'],
          onTap: () {
            controller.selectSlot(
                TimeSlotsModel(slot: value['slot'], time: value['timeSlot']));
          },
          child: Container(
            width: 200,
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 5),
                  child: Icon(Icons.timer, color: Colors.grey.shade600),
                ),
                Text(value['value']),
              ],
            ),
          ),
        );
      }).toList(),
      validator: (String? value) {
        if (value == null) {
          return 'Deve fazer uma seleção.';
        }
        return null;
      },
    );
  }

  // Future<int> schedule() async {
  //   return AgendamentController.to.insert(AgendementModel(
  //     vaccine: vaccine.text,
  //     date: data.text,
  //     slot: _dropdownValueSeleted,
  //     clinicId: int.parse(widget.clinic),
  //   ));
  // }
}