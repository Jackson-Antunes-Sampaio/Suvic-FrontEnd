import 'package:covid_19/common/botton_navigation_bar/bottom_navigation_bar_new.dart';
import 'package:covid_19/controllers/StockController.dart';
import 'package:covid_19/controllers/agendament_controller.dart';
import 'package:covid_19/controllers/clinicController.dart';
import 'package:covid_19/models/Clinic_model.dart';
import 'package:covid_19/models/agendament_model.dart';
import 'package:covid_19/models/stock_vacine_model.dart';
import 'package:covid_19/screens/agendament/autocomplete/aVaccinesAgend.dart';
import 'package:covid_19/screens/agendament/autocomplete/data/getTime.dart';
import 'package:covid_19/utils/styles/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class SelectVacine extends StatefulWidget {
  final String clinic;
  const SelectVacine({Key? key, required this.clinic}) : super(key: key);

  @override
  _SelectVacineState createState() => _SelectVacineState();
}

class _SelectVacineState extends State<SelectVacine> {
  final AgendamentController agendamentController = Get.put(AgendamentController());
  final _formKey = GlobalKey<FormState>();
  final TextEditingController vaccine = TextEditingController();
  final TextEditingController time = TextEditingController();
  final TextEditingController data = TextEditingController();

  String? _dropdownValue;
  bool docilio = false;
  final markers = Set<Marker>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: widget.clinic.isEmpty
            ? Center(child: Text('Selecione uma clinica'))
            : GetBuilder<ClinicController>(
                init: ClinicController(idClinic: widget.clinic),
                builder: (controller) {
                  //Get clinic selected
                  var clinic = controller.clinics.firstWhere(
                    (element) => element.id == int.parse(widget.clinic),
                  );
                  //Get all vacine in stock
                  var vaccinesInCart = controller.vacineSelected;
                  var maskDate = new MaskTextInputFormatter(mask: '##-##-####');
                  final oCcy = NumberFormat("R\$ #,##0.00", "en_US");

                  return Column(
                    children: [
                      Container(
                        width: double.maxFinite,
                        height: 180,
                        child: GoogleMap(
                          mapType: MapType.terrain,
                          zoomControlsEnabled: false,
                          initialCameraPosition: CameraPosition(
                            target: LatLng(clinic.latitude, clinic.longitude),
                            zoom: 26,
                          ),
                          onMapCreated: (GoogleMapController gmc) async {
                            markers.add(
                              Marker(
                                markerId: MarkerId(clinic.id.toString()),
                                position:
                                    LatLng(clinic.latitude, clinic.longitude),
                                infoWindow: InfoWindow(title: clinic.name),
                                icon: await BitmapDescriptor.fromAssetImage(
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
                      controller.seachStatus
                          ? vaccinesInCart.length == 0
                              ? seachCard(context, controller)
                              : showCardBtnClose(clinic, controller)
                          : vaccinesInCart.length == 0
                              ? showCompanyNameCard(clinic, controller)
                              : showCardBtnClose(clinic, controller),
                      Container(
                        width: double.maxFinite,
                        height: 469,
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
                                      : vaccinesInCart.length == 0
                                          ? ListView.builder(
                                              padding: EdgeInsets.only(top: 0),
                                              itemCount: vaccines.length,
                                              itemBuilder: (context, index) {
                                                var price = 0;

                                                if ((prices.where((element) =>
                                                        element.vacine ==
                                                        vaccines[index]
                                                            .name)).length !=
                                                    0) {
                                                  price = prices
                                                      .firstWhere((element) =>
                                                          element.vacine ==
                                                          vaccines[index].name)
                                                      .price;
                                                } else {
                                                  price = 0;
                                                }
                                                return Card(
                                                  child: ListTile(
                                                    leading: Image.asset(
                                                      'assets/images/iconVacine.png',
                                                      width: 30,
                                                      height: 30,
                                                    ),
                                                    title: Text(
                                                        vaccines[index].name),
                                                    trailing: Text(
                                                        oCcy.format(price)),
                                                    onTap: () => controller
                                                        .addVacineInCart(
                                                      StockVacineModel(
                                                        name: vaccines[index].name,
                                                        lote: vaccines[index].lote,
                                                        dataValidade: vaccines[index].dataValidade,
                                                        quantidade: 1,
                                                        price: price,
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              },
                                            )
                                          : Column(
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                    left: 10,
                                                    top: 20,
                                                    right: 10,
                                                    bottom: 10,
                                                  ),
                                                  child: TextFormField(
                                                    controller: vaccine,
                                                    enabled: false,
                                                    initialValue: vaccinesInCart.first.name,
                                                    decoration: InputDecoration(
                                                      isDense: true,

                                                      // icon: Image.asset(
                                                      //   'assets/images/iconVacine.png',
                                                      //   width: 35,
                                                      //   height: 35,
                                                      // ),
                                                      // prefix: ,
                                                      //enabledBorder: InputBorder.none,
                                                      disabledBorder:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            const BorderRadius
                                                                .all(
                                                          const Radius.circular(
                                                              10.0),
                                                        ),
                                                        borderSide: BorderSide(
                                                          color: Colors.grey,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 10,
                                                      right: 10,
                                                      bottom: 10),
                                                  // child: autoCompleteTime(),
                                                  // child: autocompleTime(),
                                                  child: TextFormField(
                                                    controller: data,
                                                    inputFormatters: [maskDate],
                                                    decoration: InputDecoration(
                                                      isDense: true,
                                                      prefixIcon: Icon(
                                                          Icons.calendar_today),
                                                      labelText: 'Data',
                                                      hintText: 'Data',
                                                      //enabledBorder: InputBorder.none,
                                                      border:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            const BorderRadius
                                                                .all(
                                                          const Radius.circular(
                                                              10.0),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                    left: 10,
                                                    right: 10,
                                                    bottom: 10,
                                                  ),
                                                  child:
                                                      DropdownButtonSelectTimer(),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 10,
                                                      right: 10,
                                                      bottom: 10),
                                                  child: Container(
                                                    child: Card(
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Text(
                                                                'Usar Cartão Cadastrado'),
                                                            Checkbox(
                                                                value: true,
                                                                onChanged:
                                                                    (value) {})
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 10,
                                                      right: 10,
                                                      bottom: 10),
                                                  child: Container(
                                                    child: GestureDetector(
                                                      onTap: () =>
                                                          Get.defaultDialog(
                                                        radius: 5,
                                                        title:
                                                            'Endereço do Usuario',
                                                        content: Container(
                                                          width: 350,
                                                          child: Column(
                                                            children: [
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        2.0),
                                                                child:
                                                                    TextFormField(
                                                                  decoration:
                                                                      InputDecoration(
                                                                    contentPadding: EdgeInsets.only(
                                                                        top: 0,
                                                                        bottom:
                                                                            0,
                                                                        left: 4,
                                                                        right:
                                                                            4),
                                                                    labelText:
                                                                        'CEP',
                                                                    //enabledBorder: InputBorder.none,
                                                                    border:
                                                                        OutlineInputBorder(
                                                                      borderRadius:
                                                                          const BorderRadius
                                                                              .all(
                                                                        const Radius.circular(
                                                                            10.0),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        2.0),
                                                                child:
                                                                    TextFormField(
                                                                  decoration:
                                                                      InputDecoration(
                                                                    contentPadding: EdgeInsets.only(
                                                                        top: 0,
                                                                        bottom:
                                                                            0,
                                                                        left: 4,
                                                                        right:
                                                                            4),
                                                                    labelText:
                                                                        'Número',
                                                                    //enabledBorder: InputBorder.none,
                                                                    border:
                                                                        OutlineInputBorder(
                                                                      borderRadius:
                                                                          const BorderRadius
                                                                              .all(
                                                                        const Radius.circular(
                                                                            10.0),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  keyboardType:
                                                                      TextInputType
                                                                          .number,
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        2.0),
                                                                child:
                                                                    TextFormField(
                                                                  decoration:
                                                                      InputDecoration(
                                                                    contentPadding: EdgeInsets.only(
                                                                        top: 0,
                                                                        bottom:
                                                                            0,
                                                                        left: 4,
                                                                        right:
                                                                            4),
                                                                    labelText:
                                                                        'Complemento',
                                                                    //enabledBorder: InputBorder.none,
                                                                    border:
                                                                        OutlineInputBorder(
                                                                      borderRadius:
                                                                          const BorderRadius
                                                                              .all(
                                                                        const Radius.circular(
                                                                            10.0),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  ElevatedButton
                                                                      .icon(
                                                                    style:
                                                                        ButtonStyle(
                                                                      backgroundColor:
                                                                          MaterialStateProperty
                                                                              .all(
                                                                        Color(
                                                                            0xff303f9f),
                                                                      ),
                                                                      shape: MaterialStateProperty
                                                                          .all(
                                                                        RoundedRectangleBorder(
                                                                          borderRadius:
                                                                              BorderRadius.circular(30.0),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    onPressed:
                                                                        () => Get
                                                                            .back(),
                                                                    icon: Icon(Icons
                                                                        .cancel),
                                                                    label: Text(
                                                                        'Cancelar'),
                                                                  ),
                                                                  ElevatedButton
                                                                      .icon(
                                                                    style:
                                                                        ButtonStyle(
                                                                      backgroundColor:
                                                                          MaterialStateProperty
                                                                              .all(
                                                                        Color(
                                                                            0xff303f9f),
                                                                      ),
                                                                      shape: MaterialStateProperty
                                                                          .all(
                                                                        RoundedRectangleBorder(
                                                                          borderRadius:
                                                                              BorderRadius.circular(30.0),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    onPressed:
                                                                        () {},
                                                                    icon: Icon(
                                                                        Icons
                                                                            .done),
                                                                    label: Text(
                                                                        'Adicionar'),
                                                                  ),
                                                                ],
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      child: Card(
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Text(
                                                                  'Atendimento ao domicílio'),
                                                              Checkbox(
                                                                value: docilio,
                                                                onChanged:
                                                                    (value) {},
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 10,
                                                      top: 5,
                                                      right: 10,
                                                      bottom: 10),
                                                  child: Container(
                                                    width: double.maxFinite,
                                                    child: ElevatedButton.icon(
                                                      style: ButtonStyle(
                                                        backgroundColor:
                                                            MaterialStateProperty
                                                                .all(
                                                          Color(0xff303f9f),
                                                        ),
                                                        shape:
                                                            MaterialStateProperty
                                                                .all(
                                                          RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        30.0),
                                                          ),
                                                        ),
                                                      ),
                                                      onPressed: () {
                                                         return schedule();
                                                      },
                                                      icon: Obx(() =>
                                                          AgendamentController
                                                                  .to
                                                                  .loading
                                                                  .value
                                                              ? Container(
                                                                  width: 15,
                                                                  height: 15,
                                                                  child:
                                                                      CircularProgressIndicator(
                                                                    color: Colors
                                                                        .white,
                                                                    strokeWidth:
                                                                        2,
                                                                  ),
                                                                )
                                                              : Icon(
                                                                  Icons.add)),
                                                      label: Text('Agendar'),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            );
                            }),
                      ),
                    ],
                  );
                }),
      ),
      bottomNavigationBar: BottomNavigationBarNew(),
    );
  }
  schedule() {
    if (_formKey.currentState!.validate()) {
      AgendamentController.to.insert(AgendamentModel(
        vaccine: vaccine.text,
        data: time.text,
        time: _dropdownValue,
      ));
      _formKey.currentState!.reset();
    }
  }

  DropdownButtonFormField<String> DropdownButtonSelectTimer() {
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
      icon: const Icon(
        Icons.arrow_downward,
        color: kPrimaryColor,
      ),
      hint: const Text('Selecione o horário'),
      iconSize: 24,
      elevation: 16,
      style: const TextStyle(color: Colors.black87),
      onChanged: (String? newValue) {
        setState(() {
          _dropdownValue = newValue;
        });
      },
      items: GetTimeScheld.getTimer()
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Container(
              width: 200,
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 5),
                    child: Icon(Icons.timer, color: kPrimaryColor),
                  ),
                  Text(value),
                ],
              )),
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

  Card showCardBtnClose(ClinicModel clinic, ClinicController controller) {
    return Card(
      margin: EdgeInsets.all(0),
      child: Container(
        color: kPrimaryColor,
        child: Container(
          width: double.maxFinite,
          height: 70,
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.white,
              radius: 20,
              child: FaIcon(FontAwesomeIcons.hospitalSymbol),
            ),
            title: Text(
              clinic.name!,
              style: TextStyle(color: Colors.white),
            ),
            subtitle: Text(
              clinic.address!,
              style: TextStyle(color: Colors.white),
            ),
            trailing: IconButton(
              onPressed: () => controller
                  .removeVacineInCart(controller.vacineSelected.first),
              icon: Icon(
                Icons.close,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Card showCompanyNameCard(ClinicModel clinic, ClinicController controller) {
    return Card(
      margin: EdgeInsets.all(0),
      child: Container(
        color: kPrimaryColor,
        child: Container(
          width: double.maxFinite,
          height: 70,
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.white,
              radius: 20,
              child: FaIcon(FontAwesomeIcons.hospitalSymbol),
            ),
            title: Text(
              clinic.name!,
              style: TextStyle(color: Colors.white),
            ),
            subtitle: Text(
              clinic.address!,
              style: TextStyle(color: Colors.white),
            ),
            trailing: IconButton(
              onPressed: () => controller.changeSeachStatus(),
              icon: Icon(
                Icons.search,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Card seachCard(BuildContext context, ClinicController controller) {
    return Card(
      margin: EdgeInsets.all(0),
      child: Container(
        color: kPrimaryColor,
        child: Container(
          width: double.maxFinite,
          height: 70,
          child: Center(
              child: Padding(
            padding: const EdgeInsets.only(left: 6, right: 4),
            child: Container(
              width: double.maxFinite,
              child: autocompleVaccinesAgendaments(
                context,
                controller,
              ),
            ),
          )),
        ),
      ),
      //bottomNavigationBar: BottomNavigationBarNew(),
    );
  }
}
