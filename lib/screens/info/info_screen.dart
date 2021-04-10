import 'package:covid_19/common/my_header_widget.dart';
import 'package:covid_19/styles/constant.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_svg/flutter_svg.dart';

class InfoScreen extends StatefulWidget {
  @override
  _InfoScreenState createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {

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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            MyHeader(
              image: "assets/icons/coronadr.png",
              textTop: "SUVIC",
              textBottom: "HealthTech",
              offset: offset,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  /*  Text(
                    "Suvic",
                    style: kTitleTextstyle,
                  ),*/
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
                      height: 120,
                      child: Text(
                        'Esteja entre os primeiros vacinados. Acompanhe o lançamento do App e diga adeus à carteirinha de papel!',
                        style: TextStyle(color: Colors.black, fontSize: 18),
                      ),
                    ),
                  ),
                  SizedBox(height: 50),
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
                      height: 300,
                      child: Column(
                        children: [
                          Text(
                            "Regressiva",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 28,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            '(em breve mais funcionalidades)',
                            style: TextStyle(fontSize: 10),
                          ),
                          Divider(
                            height: 5,
                          ),
                          Container(
                              height: 200,
                              width: 200,
                              child: Center(
                                child: Image.asset("assets/images/rocket.png"),
                              )),
                          CircularProgressIndicator(),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                      decoration: BoxDecoration(boxShadow: [
                        BoxShadow(
                            color: Colors.grey,
                            blurRadius: 5.0,
                            offset: Offset(2.0, 2.0))
                      ]),
                      width: 400,
                      height: 80,
                      child: RaisedButton(
                        onPressed: () {

                        },
                        color: Colors.blueAccent,
                        child: Center(
                          child: Text(
                            "Veja a notícia do dia",
                            style: TextStyle(
                                color: Colors.white70,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      )),
                  SizedBox(height: 20),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class PreventCard extends StatelessWidget {
  final String image;
  final String title;
  final String text;
  const PreventCard({
    Key key,
    this.image,
    this.title,
    this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: SizedBox(
        height: 156,
        child: Stack(
          alignment: Alignment.centerLeft,
          children: <Widget>[
            Container(
              height: 136,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 8),
                    blurRadius: 24,
                    color: kShadowColor,
                  ),
                ],
              ),
            ),
            Image.asset(image),
            Positioned(
              left: 130,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                height: 136,
                width: MediaQuery.of(context).size.width - 170,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      title,
                      style: kTitleTextstyle.copyWith(
                        fontSize: 16,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        text,
                        maxLines: 4,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: Image.asset("assets/icons/forward.svg"),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SymptomCard extends StatelessWidget {
  final String image;
  final String title;
  final bool isActive;
  const SymptomCard({
    Key key,
    this.image,
    this.title,
    this.isActive = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
        boxShadow: [
          isActive
              ? BoxShadow(
                  offset: Offset(0, 10),
                  blurRadius: 20,
                  color: kActiveShadowColor,
                )
              : BoxShadow(
                  offset: Offset(0, 3),
                  blurRadius: 6,
                  color: kShadowColor,
                ),
        ],
      ),
      child: Column(
        children: <Widget>[
          Image.asset(image, height: 90),
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
