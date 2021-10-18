import 'dart:ui';
import 'package:suvic_app/common/botton_navigation_bar/bottom_navigation_bar.dart';
import 'package:suvic_app/common/my_header_widget.dart';
import 'package:suvic_app/routes/app_page.dart';
import 'package:suvic_app/utils/styles/style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../info/info_screen.dart';
import 'components/button_custom.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final controller = ScrollController();
  double offset = 0;

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
          children: <Widget>[
            MyHeader(
              image: "assets/icons/Drcorona.png",
              textTop: "SUVIC",
              textBottom: "HealthTech",
              offset: offset,
            ),
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "Suvic",
                              style: kTitleTextstyle,
                            ),
                          ],
                        ),
                      ),
                      Spacer(),
                    ],
                  ),
                  SizedBox(height: 20),
                  Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(0, 4),
                          blurRadius: 30,
                          color: kShadowColor,
                        ),
                      ],
                    ),
                    child: Container(
                      width: 400,
                      height: 150,
                      child: Text(
                        "Somos uma Startup com foco em servir a cada cidadão da melhor forma, ajudando na organização de seu saude.\n"
                        "Serviços como Carteira de Vacinação, históricos de saúde e marcação de Vacinação ou consulta.\n"
                        "Tudo isso sempre na palma de sua mão.",
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    height: 320,
                    width: 350,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ButtonCustom(
                              navigation: () {
                                    Get.toNamed(Routes.INFO);
                                  },
                              text: "Agendar\nVacinação",
                              icon: Icons.quick_contacts_mail_sharp,
                                color: Colors.blueAccent
                                ),
                            Container(
                              width: 20,
                            ),
                            ButtonCustom(
                              text: "Minha\nCarteirinha",
                              color: Color(0xFF11249F),
                              icon: Icons.wallet_membership,
                              navigation: (){
                                Get.toNamed(Routes.VACCINECARD);
                              },
                            ),
                          ],
                        ),
                        Divider(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ButtonCustom(
                              text: "Pesquisar\nClinicas",
                              color: Color(0xff011579b),
                              icon: Icons.search,
                              navigation: (){

                              },
                            ),

                            Container(
                              width: 20,
                            ),

                            ButtonCustom(
                              text: "Me avise \nquando \nchegar a \nvacina \ndo Covid",
                              color: Colors.lightBlueAccent,
                              icon: Icons.map,
                              navigation: (){
                                Get.toNamed(Routes.NOTIFYCOVID);
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
