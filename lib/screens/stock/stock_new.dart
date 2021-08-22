import 'package:covid_19/common/botton_navigation_bar/bottom_navigation_bar_new.dart';
import 'package:covid_19/common/text_fiel_custom.dart';
import 'package:covid_19/controllers/StockController.dart';
import 'package:covid_19/controllers/user_controller.dart';
import 'package:covid_19/models/stock_vacine_model.dart';
import 'package:covid_19/screens/stock/autocomplete/textFormField.dart';
import 'package:covid_19/screens/stock/graphics/pie_chart.dart';
import 'package:covid_19/utils/styles/style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class Stock extends StatefulWidget {
  const Stock({Key? key}) : super(key: key);

  @override
  _StockState createState() => _StockState();
}

class _StockState extends State<Stock> {
  TextEditingController vacine = TextEditingController();
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
              Tab(child: Text('Estatiscas'), icon: Icon(Icons.list)),
              Tab(child: Text('Dashboard'), icon: Icon(Icons.dashboard)),
              Tab(child: Text('Adicionar'), icon: Icon(Icons.add)),
            ]),
          ),
          body: GetBuilder<StockController>(
              init: StockController(),
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
                          child: listProductInStock(controller),
                        ),
                        Center(
                          child: dashbaordTabPage(controller),
                        ),
                        Center(
                          child: addProductStock(controller),
                        ),
                      ]);
              }),
        ),
      ),
      bottomNavigationBar: BottomNavigationBarNew(),
    );
  }

  Widget listProductInStock(StockController controller) {
    var vacines = controller.vaccineInStock;
    return vacines.length == 0
        ? Center(child: Text('Sem vacina em Stock'))
        : Padding(
            padding: const EdgeInsets.all(10.0),
            child: ListView.builder(
                itemCount: vacines.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ExpansionTile(
                      leading: Icon(
                        Icons.medication,
                        color: kPrimaryColor,
                      ),
                      title: Text(vacines[index].name),
                      subtitle: Text(
                        'Quantidade(${vacines[index].quantidade})',
                      ),
                    ),
                  );
                }),
          );
  }

  Widget dashbaordTabPage(StockController controller) {
    return controller.vaccineInChart.length == 4
        ? Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: double.maxFinite,
              height: 600,
              child: PieChartStock(vaccines: controller.vaccineInChart),
            ),
          )
        : Center(
            child: Text('Stock de Vacinas'),
          );
  }

  Widget addProductStock(StockController controller) {
    var maskDate = new MaskTextInputFormatter(mask: '##-##-####');

    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.only(top: 30, bottom: 150),
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(left: 20, right: 20),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    autocompleVaccines(context, vacine),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: lote,
                      decoration: InputDecoration(
                        isDense: true,
                        prefixIcon: Icon(Icons.add_box),
                        labelText: 'Lote',
                        hintText: 'Lote',
                        //enabledBorder: InputBorder.none,
                        border: OutlineInputBorder(
                          borderRadius: const BorderRadius.all(
                            const Radius.circular(10.0),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: datavalidade,
                      inputFormatters: [maskDate],
                      decoration: InputDecoration(
                        isDense: true,
                        prefixIcon: Icon(Icons.calendar_today),
                        labelText: 'Data de Validade',
                        hintText: 'Data de Validade',
                        //enabledBorder: InputBorder.none,
                        border: OutlineInputBorder(
                          borderRadius: const BorderRadius.all(
                            const Radius.circular(10.0),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: quantidade,
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
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: valor,
                      decoration: InputDecoration(
                        isDense: true,
                        prefixIcon: Icon(Icons.attach_money),
                        labelText: 'Valor',
                        hintText: 'Valor',

                        //enabledBorder: InputBorder.none,
                        border: OutlineInputBorder(
                          borderRadius: const BorderRadius.all(
                            const Radius.circular(10.0),
                          ),
                        ),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    // ButtonCustom(onPressed: () {}, title: "Adicionar"),
                    Container(
                      width: double.maxFinite,
                      child: ElevatedButton(
                        onPressed: () {
                          addVacineInStock(controller);
                        },
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
              ),
            )
          ],
        ),
      ),
    );
  }

  void addVacineInStock(StockController controller) {
    if (_formKey.currentState!.validate()) {
      //valid name of vacine
      if (controller.vaccines.contains(vacine.text)) {
        controller.insert(
          StockVacineModel(
            name: vacine.text,
            lote: lote.text,
            dataValidade: datavalidade.text,
            quantidade: int.parse(quantidade.text),
            valor: double.parse(valor.text),
          ),
        );
      } else {
        Get.snackbar(
          'Erro no Formulario',
          'Selecione um nome valido na de lista de vacinas',
          backgroundColor: Colors.deepOrange,
        );
      }
    }
  }
}
