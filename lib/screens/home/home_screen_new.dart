import 'dart:ui';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:suvic_app/common/my_header_widget.dart';
import 'package:suvic_app/controllers/user_controller.dart';
import 'package:suvic_app/models/page_manager.dart';
import 'package:suvic_app/routes/app_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'components/custom_carrousel.dart';
import 'components/custom_carrousel_slider.dart';

class HomeScreenNew extends StatefulWidget {
  @override
  _HomeScreenNewState createState() => _HomeScreenNewState();
}

class _HomeScreenNewState extends State<HomeScreenNew> {
  final controller = ScrollController();
  final PageManager pageManager = Get.find();
  final userController = Get.put(UserController());
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
                  CarouselCustom(
                    carouselModel: [
                      CarouselModel(
                        image: "assets/images/suvic.png",
                        onTap: () {
                          Get.toNamed(Routes.SUVIC);
                        },
                      ),
                      CarouselModel(
                        image:
                            "assets/images/carteirinha-vacinacao-960x540.jpg",
                        title: "Acesse sua carteirinha",
                        onTap: () {
                          pageManager.indexNavigation.value = 1;
                          pageManager.pageController.jumpToPage(1);
                        },
                      ),
                    ],
                  ),
                  // SizedBox(height: 100,),
                  // CustomCarouselSlider(
                  //   itemsString: [
                  // "O App SUVIC é a sua Carteirinha de Vacinação Digital e GRATUITA, com\n"
                  // "funções de Agendamento (SUS e Particular), Histórico, Calendário e\n"
                  // "muito mais!",
                  //     "Avise-me quando a vacina chegar em minha cidade"
                  //   ],
                  //   itemsImage: [
                  //     "assets/images/suvic.png",
                  //     "assets/images/undraw_Map_dark_re_36sy.png"
                  //   ],
                  // ),
                  SizedBox(
                    height: 50,
                  ),
                  userController.user?.permissionLevel == "Overseer"?
                  LayoutBuilder(
                      builder: (context, constraints){
                        print(constraints.biggest);
                        return
                          Padding(
                            padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                            child: Center(
                              child: FloatingActionButton.extended(
                                backgroundColor: Theme.of(context).primaryColor,
                                  onPressed: () {
                                    Get.toNamed(Routes.OLDVACCINECARD);
                                  },
                                  label:
                                  Text("Seu Comprovante de Vacinação Covid-19",style: TextStyle(
                                      fontSize:constraints.maxWidth >=400?20:12 ),)),
                            ),

                          );
                      }):Container()
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
