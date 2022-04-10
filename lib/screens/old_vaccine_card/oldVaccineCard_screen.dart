import 'package:suvic_app/common/my_header_widget.dart';
import 'package:suvic_app/screens/old_vaccination_card/old_vaccination_card.dart';
import 'package:flutter/material.dart';
import 'package:suvic_app/routes/app_page.dart';
import 'package:get/get.dart';
import 'package:suvic_app/utils/styles/style.dart';

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
                        "Nesse espaço vamos disponibilizar para que você usuário tire uma "),
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
                    text: "Aqui você poderá "),
                TextSpan(
                    text: "Digitalizar ",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.black)),
                TextSpan(
                    text: "sua antiga carteira de vacinação ",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.black)),
                TextSpan(
                    style: TextStyle(color: Colors.black),
                    text:
                        "para assim ter sempre em mãos seus documentos, de forma fácil de acessivel. "),
              ])),
            ),
            Divider(
              height: 50,
            ),
            Center(
              child: SizedBox(
                height: 100,
                width: 150,
                child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(colorKPrimaryColor[900])),
                  onPressed: () {
                    Get.to(OldVaccinationCard());
                  },
                  child: Text("Digitalizar\nCarteira Antiga"),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
