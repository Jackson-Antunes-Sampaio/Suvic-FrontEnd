import 'dart:ui';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:lottie/lottie.dart';
import 'package:share/share.dart';
import 'package:suvic_app/common/my_header_widget.dart';
import 'package:suvic_app/controllers/notification_controller.dart';
import 'package:suvic_app/controllers/user_controller.dart';
import 'package:suvic_app/models/page_manager.dart';
import 'package:suvic_app/routes/app_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'components/custom_carrousel.dart';

class HomeScreenNew extends StatefulWidget {
  @override
  _HomeScreenNewState createState() => _HomeScreenNewState();
}

class _HomeScreenNewState extends State<HomeScreenNew> {
  final controller = ScrollController();
  final PageManager pageManager = Get.find();
  final userController = Get.put(UserController());
  final notification = Get.put(NotificationController());
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
            Stack(
              children: [
                MyHeader(
                  image: "assets/icons/Drcorona.png",
                  textTop: "SUVIC",
                  textBottom: "Saúde Digital",
                  offset: offset,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 200,
                    ),
                    GestureDetector(
                        onTap: () {
                          print('Funcionando');
                        },
                        child: Padding(
                          padding: EdgeInsets.all(20),
                          child: Lottie.network(
                              'https://assets9.lottiefiles.com/private_files/lf30_3frgatkh.json',
                              height: 100,
                              width: 100,
                              fit: BoxFit.fitHeight),
                        )),
                  ],
                ),
              ],
            ),
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
                        image: "assets/images/febreamrela-carteirinha.webp",
                        title: "Digitalizar minha antiga carteira",
                        onTap: () {
                          Get.toNamed(Routes.OLDVACCINECARD);
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
                      CarouselModel(
                        image: "assets/images/icon-share-new.png",
                        title: 'Compartilhar App com Amigos',
                        onTap: () {
                          Share.share(
                              'Pessoal Olha que fantastico minha carteirinha de vacinação é digital! A sua também é? https://suvic.com.br/download/',
                              subject:
                                  'Pessoal Olha que fantastico esse app, ele será nossa nova carteira de vacinação!');
                        },
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  userController.user?.permissionLevel == "Applicator" ||
                          userController.user?.permissionLevel == "Oversser" ||
                          userController.user?.permissionLevel == "Admin" ||
                          userController.user?.permissionLevel == "Superadmin"
                      ? Container()
                      : Container()
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
