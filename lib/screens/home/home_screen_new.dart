import 'dart:ui';
import 'package:covid_19/common/my_header_widget.dart';
import 'package:flutter/material.dart';
import 'components/custom_carrousel_slider.dart';

class HomeScreenNew extends StatefulWidget {
  @override
  _HomeScreenNewState createState() => _HomeScreenNewState();
}

class _HomeScreenNewState extends State<HomeScreenNew> {

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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(bottom: 5),
                    child: Text(
                      "Noticias",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  CustomCarouselSlider(
                    itemsString: [
                  "O App SUVIC é a sua Carteirinha de Vacinação Digital e GRATUITA, com\n"
                  "funções de Agendamento (SUS e Particular), Histórico, Calendário e\n"
                  "muito mais!",
                      "Avise-me quando a vacina chegar em minha cidade"
                    ],
                    itemsImage: [
                      "assets/images/suvic.png",
                      "assets/images/undraw_Map_dark_re_36sy.png"
                    ],
                  ),
                  SizedBox(height: 10,),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
