import 'package:suvic_app/common/my_header_widget.dart';
import 'package:suvic_app/screens/old_vaccination_card/old_vaccination_card.dart';
import 'package:flutter/material.dart';
import 'package:suvic_app/routes/app_page.dart';
import 'package:get/get.dart';

class OldVaccineCardScreen extends StatefulWidget {
  @override
  _VaccineCardScreenState createState() => _VaccineCardScreenState();
}

class _VaccineCardScreenState extends State<OldVaccineCardScreen> {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            MyHeader(
              image: "assets/images/covid-19-vaccine.png",
              textTop: "PASSAPORTE",
              textBottom: "DIGITAL",
              offset: 0,
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: RichText(
                  text: TextSpan(children: <TextSpan>[
                TextSpan(
                    style: TextStyle(color: Colors.black, fontSize: 15),
                    text:
                        "Nesse espaço vamos disponibilizar para que o usuário tire uma "),
                TextSpan(
                    text: "Foto ",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.black)),
                TextSpan(
                    style: TextStyle(color: Colors.black), text: "ou faça "),
                TextSpan(
                    text: "Upload ",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.black)),
                TextSpan(
                    style: TextStyle(color: Colors.black),
                    text:
                        "de um documento junto aos diretórios do seu Celular.\n"),
                TextSpan(
                    style: TextStyle(color: Colors.black),
                    text: "Abaixo terá como opção colocar seu "),
                TextSpan(
                    text: "Comprovante da vacina Covid-19 ",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.black)),
                TextSpan(style: TextStyle(color: Colors.black), text: "ou "),
                TextSpan(
                    text: "Sua antiga carteira de vacinação ",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.black)),
                TextSpan(
                    style: TextStyle(color: Colors.black),
                    text:
                        "para assim ter sempre em mãos seus documentos, de forma fácil de acessivel. "),
              ])),
            ),
            Divider(
              height: 100,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  height: 100,
                  width: 150,
                  child: ElevatedButton(
                    onPressed: () {
                      Get.toNamed(Routes.PASSAPORT);
                    },
                    child: Text("Comprovante Covid-19"),
                  ),
                ),
                SizedBox(
                  height: 100,
                  width: 150,
                  child: ElevatedButton(
                    onPressed: () {
                      Get.to(OldVaccinationCard());
                    },
                    child: Text("Carteira Antiga"),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
