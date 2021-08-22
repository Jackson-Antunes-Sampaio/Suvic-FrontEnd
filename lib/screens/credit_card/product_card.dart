import 'package:covid_19/common/button_custom.dart';
import 'package:covid_19/common/icon_button_custom.dart';
import 'package:covid_19/common/text_fiel_custom.dart';
import 'package:covid_19/controllers/credit_card_controller.dart';
import 'package:covid_19/routes/app_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductCardScreen extends StatefulWidget {
  @override
  _ProductCardScreenState createState() => _ProductCardScreenState();
}

class _ProductCardScreenState extends State<ProductCardScreen> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: keyScaffold,
      appBar: AppBar(
        title: Text("Produto"),
      ),
      body: Obx(() {
        switch (creditCardController.stateProductCard.value) {
          case StateProductCard.LOADING:
            return Center(
              child: CircularProgressIndicator(),
            );
            break;
          case StateProductCard.IDL:
            return SingleChildScrollView(
              child: Form(
                key: _keyForm,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      TextFieldCustom(
                        controller: clinicsController,
                        validator: (value) {
                          if (value?.length == 0) {
                            return 'Campo inválido';
                          } else {
                            return null;
                          }
                        },
                        hintText: 'Nome da Clinica',
                        iconData: Icons.local_hospital,
                        labelText: 'Nome da Clinica',
                        textInputType: TextInputType.text,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFieldCustom(
                        controller: productController,
                        validator: (value) {
                          if (value?.length == 0) {
                            return 'Campo inválido';
                          } else {
                            return null;
                          }
                        },
                        hintText: 'Produto/Vacina',
                        iconData: Icons.production_quantity_limits,
                        labelText: 'Produto/Vacina',
                        textInputType: TextInputType.text,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFieldCustom(
                        controller: valueController,
                        validator: (value) {
                          if (value?.length == 0) {
                            return 'Campo inválido';
                          } else {
                            return null;
                          }
                        },
                        hintText: 'Valor (R\$)',
                        iconData: Icons.attach_money,
                        labelText: 'Valor (R\$)',
                        textInputType: TextInputType.number,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Obx(() {
                        return Row(
                          children: [
                            creditCardController
                                        .pagarMeModel.value.cardNumber ==
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
                                      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                                      decoration: BoxDecoration(
                                        color: Theme.of(context).primaryColor.withAlpha(200),
                                        borderRadius: BorderRadius.circular(15)
                                      ),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "N° Cartão: *******${creditCardController.pagarMeModel.value.cardNumber?.substring(16 - 4)}",
                                            style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
                                          ),
                                          IconButtonCustom(
                                            onTap: (){},
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
                      SizedBox(
                        height: 10,
                      ),
                      ButtonCustom(
                          onPressed: () {
                            if (creditCardController
                                    .pagarMeModel.value.cardNumber ==
                                null) {
                              keyScaffold.currentState?.showSnackBar(SnackBar(
                                content: Text("Adicione um Cartãoo de Credito"),
                              ));
                            } else {
                              if (_keyForm.currentState!.validate()) {
                                creditCardController
                                    .pagarMeModel.value.items![0]!.quantity = 1;
                                creditCardController
                                    .pagarMeModel.value.items![0]!.id = "1";
                                creditCardController.pagarMeModel.value.amount =
                                    int.parse(valueController.text) * 100;
                                creditCardController.pagarMeModel.value
                                        .items![0]!.unitPrice =
                                    int.parse(valueController.text) * 100;
                                creditCardController.pagarMeModel.value
                                    .items![0]!.title = productController.text;
                                creditCardController.pagarMeModel.value
                                    .items![0]!.tangible = true;
                                creditCardController.transactionsPagarme();
                              }
                            }
                          },
                          title: "Finalizar")
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
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
    );
  }
}
