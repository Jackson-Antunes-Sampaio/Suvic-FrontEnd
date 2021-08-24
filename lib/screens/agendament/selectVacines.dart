import 'package:covid_19/common/botton_navigation_bar/bottom_navigation_bar_new.dart';
import 'package:covid_19/controllers/agendament_controller.dart';
import 'package:covid_19/controllers/clinicController.dart';
import 'package:covid_19/screens/agendament/autocomplete/data/getTime.dart';
import 'package:covid_19/utils/styles/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class SelectVacine extends StatefulWidget {
  final String clinic;
  const SelectVacine({Key? key, required this.clinic}) : super(key: key);

  @override
  _SelectVacineState createState() => _SelectVacineState();
}

class _SelectVacineState extends State<SelectVacine> {
  AgendamentController agendamentController = Get.put(AgendamentController());
  String? _dropdownValue;
  bool docilio = false;
  final markers = Set<Marker>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: GetBuilder<ClinicController>(
            init: ClinicController(idClinic: widget.clinic),
            builder: (controller) {
              //Get clinic selected
              var clinic = controller.clinics.firstWhere(
                  (element) => element.id == int.parse(widget.clinic));
              //Get all vacine in stock
              var vaccines = controller.vaccineInStock;
              var vaccinesInCart = controller.vacineSelected;
              var maskDate = new MaskTextInputFormatter(mask: '##-##-####');

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
                            position: LatLng(clinic.latitude, clinic.longitude),
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
                  Container(
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
                        trailing: Icon(
                          Icons.search,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: double.maxFinite,
                    height: 469,
                    child: controller.loading
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
                                      return Card(
                                        child: ListTile(
                                          leading: Hero(
                                            tag: 'dash',
                                            child: Image.asset(
                                              'assets/images/iconVacine.png',
                                              width: 30,
                                              height: 30,
                                            ),
                                          ),
                                          title: Text(vaccines[index].name),
                                          trailing: Text('2.000 Kz'),
                                          onTap: () => controller
                                              .addVacineInCart(vaccines[index]),
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
                                            bottom: 10),
                                        child: Slidable(
                                          actionPane:
                                              SlidableDrawerActionPane(),
                                          actionExtentRatio: 0.25,
                                          child: Card(
                                            margin: EdgeInsets.all(0),
                                            child: ListTile(
                                              leading: Hero(
                                                tag: 'dash',
                                                child: Image.asset(
                                                  'assets/images/iconVacine.png',
                                                  width: 30,
                                                  height: 30,
                                                ),
                                              ),
                                              title: Text(
                                                  vaccinesInCart.first.name),
                                              trailing: Text('2.000 Kz'),
                                            ),
                                          ),
                                          secondaryActions: <Widget>[
                                            IconSlideAction(
                                              color: Colors.red,
                                              icon: Icons.delete,
                                              onTap: () =>
                                                  controller.removeVacineInCart(
                                                      vaccinesInCart.first),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: 10, right: 10, bottom: 10),
                                        // child: autoCompleteTime(),
                                        // child: autocompleTime(),
                                        child: TextFormField(
                                          inputFormatters: [maskDate],
                                          decoration: InputDecoration(
                                            isDense: true,
                                            prefixIcon:
                                                Icon(Icons.calendar_today),
                                            labelText: 'Data',
                                            hintText: 'Data',
                                            //enabledBorder: InputBorder.none,
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  const BorderRadius.all(
                                                const Radius.circular(10.0),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: 10, right: 10, bottom: 10),
                                        // child: autoCompleteTime(),
                                        // child: autocompleTime(),
                                        child: DropdownButtonFormField<String>(
                                          value: _dropdownValue,
                                          decoration: InputDecoration(
                                            isDense: true,
                                            //enabledBorder: InputBorder.none,
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  const BorderRadius.all(
                                                const Radius.circular(10.0),
                                              ),
                                            ),
                                          ),
                                          focusColor: Colors.deepOrange,
                                          icon: const Icon(
                                            Icons.arrow_downward,
                                            color: kPrimaryColor,
                                          ),
                                          hint:
                                              const Text('Selecione o horário'),
                                          iconSize: 24,
                                          elevation: 16,
                                          style: const TextStyle(
                                              color: Colors.black87),
                                          onChanged: (String? newValue) {
                                            setState(() {
                                              _dropdownValue = newValue;
                                            });
                                          },
                                          items: GetTimeScheld.getTimer()
                                              .map<DropdownMenuItem<String>>(
                                                  (String value) {
                                            return DropdownMenuItem<String>(
                                              value: value,
                                              child: Container(
                                                  width: 200,
                                                  child: Row(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(right: 5),
                                                        child: Icon(Icons.timer,
                                                            color:
                                                                kPrimaryColor),
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
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: 10, right: 10, bottom: 10),
                                        child: Container(
                                          child: Card(
                                            child: Padding(
                                              padding: const EdgeInsets.all(8),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                      'Usar Cartão Cadastrado'),
                                                  Checkbox(
                                                      value: true,
                                                      onChanged: (value) {})
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: 10, right: 10, bottom: 10),
                                        child: Container(
                                          child: GestureDetector(
                                            onTap: () => Get.defaultDialog(
                                              title: 'Endereço do Usuario',
                                              content: Column(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            2.0),
                                                    child: TextFormField(
                                                      decoration:
                                                          InputDecoration(
                                                        contentPadding:
                                                            EdgeInsets.only(
                                                                top: 0,
                                                                bottom: 0,
                                                                left: 4,
                                                                right: 4),
                                                        labelText: 'CEP',
                                                        //enabledBorder: InputBorder.none,
                                                        border:
                                                            OutlineInputBorder(
                                                          borderRadius:
                                                              const BorderRadius
                                                                  .all(
                                                            const Radius
                                                                .circular(10.0),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            2.0),
                                                    child: TextFormField(
                                                      decoration:
                                                          InputDecoration(
                                                        contentPadding:
                                                            EdgeInsets.only(
                                                                top: 0,
                                                                bottom: 0,
                                                                left: 4,
                                                                right: 4),
                                                        labelText: 'Número',
                                                        //enabledBorder: InputBorder.none,
                                                        border:
                                                            OutlineInputBorder(
                                                          borderRadius:
                                                              const BorderRadius
                                                                  .all(
                                                            const Radius
                                                                .circular(10.0),
                                                          ),
                                                        ),
                                                      ),
                                                      keyboardType:
                                                          TextInputType.number,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            2.0),
                                                    child: TextFormField(
                                                      decoration:
                                                          InputDecoration(
                                                        contentPadding:
                                                            EdgeInsets.only(
                                                                top: 0,
                                                                bottom: 0,
                                                                left: 4,
                                                                right: 4),
                                                        labelText:
                                                            'Complemento',
                                                        //enabledBorder: InputBorder.none,
                                                        border:
                                                            OutlineInputBorder(
                                                          borderRadius:
                                                              const BorderRadius
                                                                  .all(
                                                            const Radius
                                                                .circular(10.0),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              cancel: ElevatedButton.icon(
                                                style: ButtonStyle(
                                                  backgroundColor:
                                                      MaterialStateColor
                                                          .resolveWith(
                                                              (states) =>
                                                                  kPrimaryColor),
                                                ),
                                                onPressed: () => Get.back(),
                                                icon: Icon(Icons.cancel),
                                                label: Text('Cancelar'),
                                              ),
                                              confirm: ElevatedButton.icon(
                                                style: ButtonStyle(
                                                  backgroundColor:
                                                      MaterialStateColor
                                                          .resolveWith(
                                                              (states) =>
                                                                  kPrimaryColor),
                                                ),
                                                onPressed: () {},
                                                icon: Icon(Icons.done),
                                                label: Text('Adicionar'),
                                              ),
                                            ),
                                            child: Card(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                        'Atendimento ao domicílio'),
                                                    Checkbox(
                                                        value: docilio,
                                                        onChanged: (value) {})
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
                                                  MaterialStateProperty.all(
                                                Color(0xff303f9f),
                                              ),
                                              shape: MaterialStateProperty.all(
                                                RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          30.0),
                                                ),
                                              ),
                                            ),
                                            onPressed: () {
                                              // return schedule();
                                            },
                                            icon: Obx(() => AgendamentController
                                                    .to.loading.value
                                                ? Container(
                                                    width: 15,
                                                    height: 15,
                                                    child:
                                                        CircularProgressIndicator(
                                                      color: Colors.white,
                                                      strokeWidth: 2,
                                                    ),
                                                  )
                                                : Icon(Icons.add)),
                                            label: Text('Agendar'),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                  ),
                ],
              );
            }),
      ),
      //bottomNavigationBar: BottomNavigationBarNew(),
    );
  }
}
