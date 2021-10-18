import 'package:brasil_fields/brasil_fields.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:suvic_app/common/button_custom.dart';
import 'package:suvic_app/controllers/credit_card_controller.dart';
import 'package:suvic_app/screens/credit_card/components/text_form_field.dart';
import 'package:credit_card_type_detector/credit_card_type_detector.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_credit_card/credit_card_widget.dart';
import 'package:get/get.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class CreditCardScreen extends StatefulWidget {
  @override
  _CreditCardScreenState createState() => _CreditCardScreenState();
}

class _CreditCardScreenState extends State<CreditCardScreen> {
  final CreditCardController creditCardController = CreditCardController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController cardNumberController = TextEditingController();
  final TextEditingController expiryDateController = TextEditingController();
  final TextEditingController cardHoldernameController = TextEditingController();
  final TextEditingController cvvCodeController = TextEditingController();

  final MaskTextInputFormatter dateFormatter = MaskTextInputFormatter(
      mask: '!#/####', filter: {'#': RegExp('[0-9]'), '!': RegExp('[0-1]')});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cadastrar cartão de credito"),
      ),

      body: SingleChildScrollView(
        child: Obx((){
          return Padding(
            padding: EdgeInsets.only(top: 20,),
            child: Column(
              children: [
                if (creditCardController.card.value)
                  // CarouselSlider(
                  //   options: CarouselOptions(),
                  //   items: creditCardController.cardNumber.map((e) {
                  //     return CreditCardWidget(
                  //       cardNumber: e,
                  //       expiryDate: creditCardController.expiryDate.value,
                  //       cardHolderName:
                  //       creditCardController.cardHoldername.value,
                  //       cvvCode: creditCardController.cvvCode.value,
                  //       showBackView: creditCardController.showBackView,
                  //       obscureCardNumber: true,
                  //       obscureCardCvv: true,
                  //       height: 200,
                  //       width: MediaQuery.of(context).size.width,
                  //       animationDuration: Duration(
                  //           milliseconds:
                  //           1000), // true when you want to show cvv(back) view
                  //     );
                  //   }).toList(),
                  // ),
                if (!creditCardController.card.value)
                  CreditCardWidget(
                    cardNumber: creditCardController.newCardNumber.value,
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
                if (creditCardController.card.value)
                  Padding(
                    padding: EdgeInsets.only(right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: Container(
                              color: Theme.of(context).primaryColor,
                              child: IconButton(
                                onPressed: (){},
                                color: Colors.white,
                                icon: Icon(Icons.remove),
                              ),
                            )
                        ),

                        SizedBox(width: 10,),
                        ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: Container(
                              color: Theme.of(context).primaryColor,
                              child: IconButton(
                                onPressed: (){
                                  creditCardController.card.value = false;
                                },
                                color: Colors.white,
                                icon: Icon(Icons.add),
                              ),
                            )
                        ),
                        SizedBox(width: 10,),
                        ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: Container(
                              color: Theme.of(context).primaryColor,
                              child: IconButton(
                                onPressed: (){},
                                color: Colors.white,
                                icon: Icon(Icons.arrow_forward_ios),
                              ),
                            )
                        ),

                      ],
                    ),
                  ),
                if (!creditCardController.card.value)
                  Form(
                    key: formKey,
                    child: Column(
                      children: [
                        TextFormFieldCustom(
                          controller: cardNumberController,
                          hintText: "0000 0000 0000 0000",
                          labelText: "Número",
                          validator: (text) {
                            if (text?.length != 19) {
                              return "Inválido";
                            } else if (detectCCType(text!) ==
                                CreditCardType.unknown) {
                              return 'Inválido';
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
                            creditCardController.newCardNumber.value = text;
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
                                    return "Inválido";
                                  } else {
                                    return null;
                                  }
                                },
                                inputFormatters: [dateFormatter],
                                keyboardType: TextInputType.number,
                                onChanget: (text) {
                                  creditCardController.showBackView = false;
                                  creditCardController.newExpiryDate.value = text;
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
                                    return "Inválido";
                                  } else {
                                    return null;
                                  }
                                },
                                inputFormatters: [],
                                keyboardType: TextInputType.number,
                                onChanget: (text) {
                                  creditCardController.showBackView = true;
                                  creditCardController.newCvvCode.value = text;
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
                            if (text == null) {
                              return 'Inválido';
                            } else {
                              return null;
                            }
                          },
                          inputFormatters: [],
                          keyboardType: TextInputType.text,
                          onChanget: (text) {
                            creditCardController.showBackView = false;
                            creditCardController.newCardHoldername.value = text;
                          },
                        ),
                        Obx(() {
                          return Row(
                            children: [
                              Checkbox(
                                value: creditCardController.selected.value,
                                onChanged: (newSelect) {
                                  creditCardController.selected.value =
                                  newSelect!;
                                },
                              ),
                              Text("Salvar dados do Cartão?")
                            ],
                          );
                        }),

                        Padding(
                            padding: EdgeInsets.only(right: 10),
                          child: ButtonCustom(
                              onPressed: (){
                                print("${cardHoldernameController.text}");
                                if (formKey.currentState!.validate()) {
                                  print("ok");
                                }
                              },
                              title: 'Proximo'),
                        ),

                      ],
                    ),
                  )
              ],
            ),
          );
        }),
      ),
    );
  }
}
