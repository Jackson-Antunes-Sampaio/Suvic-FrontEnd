import 'package:covid_19/common/botton_navigation_bar/bottom_navigation_bar.dart';
import 'package:covid_19/common/icon_button_custom.dart';
import 'package:covid_19/common/my_header_widget.dart';
import 'package:covid_19/controllers/notify_covid_controller.dart';
import 'package:covid_19/routes/app_page.dart';
import 'package:covid_19/screens/home/components/button_custom.dart';
import 'package:covid_19/screens/notify_covid/components/drop_down_custom.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get.dart';

import '../../common/text_fiel_custom.dart';

class NotifyCovidScreen extends StatefulWidget {
  @override
  _NotifyCovidScreenState createState() => _NotifyCovidScreenState();
}

class _NotifyCovidScreenState extends State<NotifyCovidScreen> {

  final NotifyCovidController notifyCovidController = Get.put(NotifyCovidController());

  final controller = ScrollController();
  double offset = 0;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.addListener(onScroll);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    controller.dispose();
    super.dispose();
  }

  void onScroll() {
    setState(() {
      offset = (controller.hasClients) ? controller.offset : 0;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        controller: controller,
        child: Column(
          children: [
            MyHeader(
              image: "assets/images/wear_mask.png",
              textTop: "Me avise \nquando a \nvacina chegar",
              textBottom: "Em minha \nregião",
              offset: offset,
            ),
            Form(
                key: formKey,
                child: Padding(
                  padding: EdgeInsets.only(top: 20, left: 10, right: 10),
                  child: Column(
                    children: [
                      TextFieldCustom(
                        iconData: Icons.date_range,
                        labelText: 'Data de nascimento',
                        hintText: '01/01/1900',
                        textInputType: TextInputType.datetime,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      TextFieldCustom(
                        iconData: Icons.email,
                        labelText: 'E-mail',
                        hintText: 'email@email.com',
                        textInputType: TextInputType.emailAddress,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      DropDownCustom(),
                      SizedBox(
                        height: 15,
                      ),
                      TextFieldCustom(
                        iconData: Icons.location_city,
                        labelText: 'Cidade',
                        hintText: 'São Paulo',
                        textInputType: TextInputType.text,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: [
                          Obx(() {
                            return Checkbox(
                              value: notifyCovidController.selectNotify.value,
                              onChanged: (newSelect) {
                                notifyCovidController.selectNotify.value = newSelect!;
                              },
                            );
                          }),
                          Expanded(
                            child: Text(
                              "Tenho interesse em receber notificação sobre a vacina.",
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.red,
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey,
                                  blurRadius: 5.0,
                                  offset: Offset(2.0, 2.0))
                            ]),
                        height: 50,
                        child: RaisedButton(
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              print("okk");
                            }
                          },
                          color: Colors.blueAccent,
                          child: Center(
                            child: Text(
                              "Enviar",
                              style: TextStyle(
                                color: Colors.white70,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
