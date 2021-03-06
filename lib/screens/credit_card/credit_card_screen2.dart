import 'package:brasil_fields/brasil_fields.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:suvic_app/common/button_custom.dart';
import 'package:suvic_app/controllers/credit_card_controller.dart';
import 'package:suvic_app/controllers/user_controller.dart';
import 'package:suvic_app/models/pagarme_model.dart';
import 'package:suvic_app/screens/credit_card/components/text_form_field.dart';
import 'package:credit_card_type_detector/credit_card_type_detector.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_credit_card/credit_card_widget.dart';
import 'package:get/get.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class CreditCardNewScreen extends StatefulWidget {
  @override
  _CreditCardNewScreenState createState() => _CreditCardNewScreenState();
}


class _CreditCardNewScreenState extends State<CreditCardNewScreen> {
  final CreditCardController creditCardController = Get.find();
  final UserController userController = Get.find();

  final GlobalKey<FormState> formKeyCard = GlobalKey<FormState>();
  final GlobalKey<FormState> formKeyData = GlobalKey<FormState>();

  final TextEditingController cardNumberController = TextEditingController();
  final TextEditingController expiryDateController = TextEditingController();
  final TextEditingController cardHoldernameController = TextEditingController();
  final TextEditingController cvvCodeController = TextEditingController();
  final TextEditingController cpfController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController streetController = TextEditingController();
  final TextEditingController streetNumberController = TextEditingController();
  final TextEditingController zipCodeController = TextEditingController();
  final TextEditingController neighborhoodController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController stateController = TextEditingController();
  final TextEditingController birthdayController = TextEditingController();


  RxBool showStreet = false.obs;

  final MaskTextInputFormatter dateFormatter = MaskTextInputFormatter(
      mask: '!#/####', filter: {'#': RegExp('[0-9]'), '!': RegExp('[0-1]')});


  @override
  void initState() {
    // TODO: implement initState
    creditCardController.stateCreditCard.value = StateCreditCard.FORMCARD;
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async{
        bool? response = await _showMyDialog();
        print("aqui");
        if(response == null){
          return false;
        }else{
          return response;
        }


      },
        child: Scaffold(
            appBar: AppBar(
              title: Text("Cadastrar cart??o de credito"),
            ),
            floatingActionButton: Stack(
              children: <Widget>[
                Obx(() {
                  return creditCardController.stateCreditCard.value ==
                      StateCreditCard.FORMDATA || creditCardController.stateCreditCard.value ==
                      StateCreditCard.FAIL
                      ? Padding(
                    padding: EdgeInsets.only(left: 30),
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: FloatingActionButton(
                        heroTag: "btn1",
                        onPressed: () {
                          creditCardController.stateCreditCard.value =
                              StateCreditCard.FORMCARD;
                        },
                        backgroundColor: Theme.of(context).primaryColor,
                        child: Icon(Icons.arrow_back_ios),
                      ),
                    ),
                  )
                      : Container();
                }),
                Align(
                  alignment: Alignment.bottomRight,
                  child: FloatingActionButton(
                    heroTag: "btn2",
                    onPressed: () {
                      if (creditCardController.stateCreditCard.value ==
                          StateCreditCard.FORMCARD) {
                        if (formKeyCard.currentState!.validate()) {
                          creditCardController.stateCreditCard.value =
                              StateCreditCard.FORMDATA;
                        }
                      } else if (creditCardController.stateCreditCard.value == StateCreditCard.FORMDATA || creditCardController.stateCreditCard.value == StateCreditCard.FAIL) {
                        print("form: ${formKeyData.currentState}");
                        if (formKeyData.currentState!.validate()) {
                          pagarmeObject();
                          Get.back();
                          //creditCardController.transactionsPagarme(map);
                        }
                      }
                    },
                    backgroundColor: Theme.of(context).primaryColor,
                    child: Icon(Icons.arrow_forward_ios),
                  ),
                ),
              ],
            ),
            // FloatingActionButton(
            //   onPressed: (){
            //     print("${cardHoldernameController.text}");
            //     if (formKey.currentState!.validate()) {
            //      creditCardController.stateCreditCard.value = StateCreditCard.FORMDATA;
            //     }
            //   },
            //   backgroundColor: Theme.of(context).primaryColor,
            //   child: Icon(Icons.arrow_forward_ios),
            // ),

            body: Obx(() {
              if (creditCardController.cardSave.value) {
                return Column(
                  children: [
                    CreditCardWidget(
                      cardNumber: creditCardController.cardNumber.value,
                      expiryDate: creditCardController.expiryDate.value,
                      cardHolderName: creditCardController.cardHoldername.value,
                      cvvCode: creditCardController.cvvCode.value,
                      showBackView: creditCardController.showBackView,
                      obscureCardNumber: true,
                      obscureCardCvv: true,
                      height: 200,
                      width: MediaQuery.of(context).size.width,
                      animationDuration: Duration(
                          milliseconds:
                          1000), // true when you want to show cvv(back) view
                    ),
                  ],
                );
              } else {
                return SingleChildScrollView(
                  padding: EdgeInsets.only(bottom: 20),
                  child: Column(
                    children: [
                      CreditCardWidget(
                        cardNumber: creditCardController.cardNumber.value,
                        expiryDate: creditCardController.expiryDate.value,
                        cardHolderName: creditCardController.cardHoldername.value,
                        cvvCode: creditCardController.cvvCode.value,
                        showBackView: creditCardController.showBackView,
                        obscureCardNumber: true,
                        obscureCardCvv: true,
                        height: 200,
                        width: MediaQuery.of(context).size.width,
                        animationDuration: Duration(
                            milliseconds:
                            1000), // true when you want to show cvv(back) view
                      ),
                      creditCardController.stateCreditCard.value ==
                          StateCreditCard.FORMCARD
                          ? Form(
                        key: formKeyCard,
                        child: Column(
                          children: [
                            TextFormFieldCustom(
                              controller: cardNumberController,
                              hintText: "0000 0000 0000 0000",
                              labelText: "N??mero",
                              validator: (text) {
                                if (text?.length != 19) {
                                  return "Inv??lido";
                                } else if (detectCCType(text!) ==
                                    CreditCardType.unknown) {
                                  return 'Inv??lido';
                                } else {
                                  return null;
                                }
                              },
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                                CartaoBancarioInputFormatter()
                              ],
                              keyboardType: TextInputType.number,
                              onChanget: (text) {
                                creditCardController.showBackView = false;
                                creditCardController.cardNumber.value = text;
                              },
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: TextFormFieldCustom(
                                    controller: expiryDateController,
                                    hintText: "11/2023",
                                    labelText: "Validade",
                                    validator: (text) {
                                      if (text?.length != 7) {
                                        return "Inv??lido";
                                      } else {
                                        return null;
                                      }
                                    },
                                    inputFormatters: [dateFormatter],
                                    keyboardType: TextInputType.number,
                                    onChanget: (text) {
                                      creditCardController.showBackView =
                                      false;
                                      creditCardController.expiryDate.value =
                                          text;
                                    },
                                  ),
                                ),
                                Expanded(
                                  child: TextFormFieldCustom(
                                    controller: cvvCodeController,
                                    hintText: "123",
                                    labelText: "CVV",
                                    maxLength: 3,
                                    validator: (text) {
                                      if (text?.length != 3) {
                                        return "Inv??lido";
                                      } else {
                                        return null;
                                      }
                                    },
                                    inputFormatters: [],
                                    keyboardType: TextInputType.number,
                                    onChanget: (text) {
                                      creditCardController.showBackView =
                                      true;
                                      creditCardController.cvvCode.value =
                                          text;
                                    },
                                  ),
                                )
                              ],
                            ),
                            TextFormFieldCustom(
                              controller: cardHoldernameController,
                              hintText: "Fabiana dos Santos",
                              labelText: "Titular",
                              validator: (text) {
                                if (text!.length < 3) {
                                  return 'Inv??lido';
                                } else {
                                  return null;
                                }
                              },
                              inputFormatters: [],
                              keyboardType: TextInputType.text,
                              onChanget: (text) {
                                creditCardController.showBackView = false;
                                creditCardController.cardHoldername.value =
                                    text;
                              },
                            ),
                            Obx(() {
                              return Row(
                                children: [
                                  Checkbox(
                                    value:
                                    creditCardController.selected.value,
                                    onChanged: (newSelect) {
                                      creditCardController.selected.value =
                                      newSelect!;
                                    },
                                  ),
                                  Text("Salvar dados do Cart??o?")
                                ],
                              );
                            }),

                            // Padding(
                            //   padding: EdgeInsets.only(right: 10),
                            //   child: ButtonCustom(
                            //       onPressed: (){
                            //         print("${cardHoldernameController.text}");
                            //         if (formKey.currentState!.validate()) {
                            //           print("ok");
                            //         }
                            //       },
                            //       title: 'Proximo'),
                            // ),
                          ],
                        ),
                      )
                          : creditCardController.stateCreditCard.value == StateCreditCard.FORMDATA
                          ? Form(
                          key: formKeyData,
                          child: Column(
                            children: [
                              TextFormFieldCustom(
                                  controller: cpfController,
                                  hintText: '111.111.111-11',
                                  labelText: 'CPF',
                                  validator: (text) {
                                    if (text?.length != 14) {
                                      return 'Inv??lido';
                                    } else {
                                      return null;
                                    }
                                  },
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly,
                                    CpfInputFormatter()
                                  ],
                                  keyboardType: TextInputType.number,
                                  onChanget: (text) {}),
                              Row(
                                children: [
                                  Expanded(
                                      child: TextFormFieldCustom(
                                          controller: phoneController,
                                          hintText: '(11) 99999-8888',
                                          labelText: 'Telefone',
                                          validator: (text) {
                                            if (text!.length < 4) {
                                              return 'Inv??lido';
                                            } else {
                                              return null;
                                            }
                                          },
                                          inputFormatters: [
                                            FilteringTextInputFormatter.digitsOnly,
                                            TelefoneInputFormatter()
                                          ],
                                          keyboardType: TextInputType.number,
                                          onChanget: (text) {})),
                                  Expanded(
                                      child: TextFormFieldCustom(
                                          controller: birthdayController,
                                          hintText: '01/01/1993',
                                          labelText: 'Data de Nascimento',
                                          validator: (text) {
                                            if (text?.length != 10) {
                                              return 'Inv??lido';
                                            } else {
                                              return null;
                                            }
                                          },
                                          inputFormatters: [
                                            FilteringTextInputFormatter.digitsOnly,
                                            DataInputFormatter()
                                          ],
                                          keyboardType: TextInputType.number,
                                          onChanget: (text) {})),

                                ],
                              ),
                              TextFormFieldCustom(
                                  controller: zipCodeController,
                                  hintText: '11.111-111',
                                  labelText: 'CEP',
                                  validator: (text) {
                                    if (text?.length != 10) {
                                      return 'Inv??lido';
                                    } else {
                                      return null;
                                    }
                                  },
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly,
                                    CepInputFormatter()
                                  ],
                                  keyboardType: TextInputType.number,
                                  onChanget: (text) {
                                    if (text.length == 10) {
                                      showStreet.value = true;
                                    } else {
                                      showStreet.value = false;
                                    }
                                  }),
                              showStreet.value
                                  ? Column(
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        flex: 2,
                                        child: TextFormFieldCustom(
                                            controller:
                                            streetController,
                                            hintText: 'Av. Paulista',
                                            labelText: 'Endere??o',
                                            validator: (text) {
                                              if (text!.length < 3) {
                                                return 'Inv??lido';
                                              } else {
                                                return null;
                                              }
                                            },
                                            inputFormatters: [],
                                            keyboardType:
                                            TextInputType.text,
                                            onChanget: (text) {}),
                                      ),
                                      Expanded(
                                        child: TextFormFieldCustom(
                                            controller:
                                            streetNumberController,
                                            hintText: '111',
                                            labelText: 'N??mero',
                                            validator: (text) {
                                              if (text!.isEmpty) {
                                                return 'Inv??lido';
                                              } else {
                                                return null;
                                              }
                                            },
                                            inputFormatters: [],
                                            keyboardType:
                                            TextInputType.number,
                                            onChanget: (text) {}),
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        flex: 2,
                                        child: TextFormFieldCustom(
                                            controller:
                                            neighborhoodController,
                                            hintText: 'Centro',
                                            labelText: 'Bairro',
                                            validator: (text) {
                                              if (text!.length < 2) {
                                                return 'Inv??lido';
                                              } else {
                                                return null;
                                              }
                                            },
                                            inputFormatters: [],
                                            keyboardType:
                                            TextInputType.text,
                                            onChanget: (text) {}),
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: TextFormFieldCustom(
                                            controller:
                                            cityController,
                                            hintText: 'S??o Paulo',
                                            labelText: 'Cidade',
                                            validator: (text) {
                                              if (text!.length < 2) {
                                                return 'Inv??lido';
                                              } else {
                                                return null;
                                              }
                                            },
                                            inputFormatters: [

                                            ],
                                            keyboardType:
                                            TextInputType.text,
                                            onChanget: (text) {}),
                                      ),
                                      Expanded(
                                          child: TextFormFieldCustom(
                                              controller:
                                              stateController,
                                              hintText: 'SP',
                                              labelText: 'Estado',
                                              validator: (text) {
                                                if (text?.length !=
                                                    2) {
                                                  return 'Inv??lido';
                                                } else {
                                                  return null;
                                                }
                                              },
                                              inputFormatters: [
                                                LengthLimitingTextInputFormatter(2),
                                              ],
                                              keyboardType:
                                              TextInputType.text,
                                              onChanget: (text) {}))
                                    ],
                                  ),
                                  SizedBox(height: 100,),
                                ],
                              )
                                  : Container()
                            ],
                          ))
                          : creditCardController.stateCreditCard.value == StateCreditCard.SUCCESS
                          ? Center(
                        child: Text("Transa????o realizada com sucesso"),
                      ) : creditCardController.stateCreditCard.value == StateCreditCard.FAIL
                          ? Center(
                          child: Text("Falha na transa????o"))  : CircularProgressIndicator(),
                    ],
                  ),
                );
              }
            })));
  }

  void pagarmeObject() {

    creditCardController.pagarMeModel.value = PagarMeModel.fromJson({
      "amount": 0,
      "card_number": "${cardNumberController.text.replaceAll(' ', '')}",
      "card_cvv": "${cvvCodeController.text}",
      "card_expiration_date": "${expiryDateController.text.replaceAll("/", "")}",
      "card_holder_name": "${cardHoldernameController.text}",
      "customer": {
        "external_id": "${userController.user?.id}",
        "name": "${userController.user?.civilName}",
        "type": "individual",
        "country": "br",
        "email": "${userController.user?.email}",
        "documents": [
          {"type": "cpf", "number": "${cpfController.text.replaceAll(".", "").replaceAll("-", "")}"}
        ],
        "phone_numbers": ["+55${phoneController.text.replaceAll("(", "").replaceAll(")", "").replaceAll("-", "").replaceAll(" ", "")}"],
        "birthday": "${birthdayController.text.split("/").last}-${birthdayController.text.split("/")[1]}-${birthdayController.text.split("/").first}"
      },
      "billing": {
        "name": "${userController.user?.civilName}",
        "address": {
          "country": "br",
          "state": "${stateController.text}",
          "city": "${cityController.text}",
          "neighborhood": "${neighborhoodController.text}",
          "street": "${streetController.text}",
          "street_number": "${streetNumberController.text}",
          "zipcode": "${zipCodeController.text.replaceAll(".", "").replaceAll("-", "")}"
        }
      },
      "items": [
        {
          "id": null,
          "title": null,
          "unit_price": null,
          "quantity": null,
          "tangible": null
        },
      ]
    });

    print("pagarme: ${creditCardController.pagarMeModel.value}");

  }


  Future<bool?> _showMyDialog() async {

    return showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Alerta'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('Deseja voltar?'),
                Text('Voc?? perdera todos os dados preenchido.'),

              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('N??o'),
              onPressed: () {
                Navigator.pop(context, false);

              },
            ),
            TextButton(
              child: const Text('Sim', style: TextStyle(color: Colors.red),),
              onPressed: () {
                Navigator.pop(context, true);

              },
            ),

          ],
        );
      },
    );
  }
}
