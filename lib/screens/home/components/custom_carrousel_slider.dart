import 'package:carousel_slider/carousel_slider.dart';
import 'package:covid_19/routes/app_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class CustomCarouselSlider extends StatelessWidget {
  CustomCarouselSlider({required this.itemsString, required this.itemsImage});

  final List<String> itemsString;
  final List<String> itemsImage;

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        height: 160,
        aspectRatio: 16 / 9,
        viewportFraction: 0.8,
        initialPage: 0,
        enableInfiniteScroll: true,
        reverse: false,
        autoPlay: true,
        autoPlayInterval: Duration(seconds: 10),
        autoPlayAnimationDuration: Duration(milliseconds: 800),
        autoPlayCurve: Curves.fastOutSlowIn,
        enlargeCenterPage: true,
        scrollDirection: Axis.horizontal,
      ),
      items: itemsImage.map((i) {
        return Builder(
          builder: (BuildContext context) {
            // return Card(
            //   clipBehavior: Clip.antiAlias,
              //margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              return ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  //height: 300,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.asset(
                        i,
                        fit: BoxFit.cover,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                        child: Align(
                          alignment: Alignment.bottomLeft,
                          child: InkWell(
                            onTap: (){
                              if(i == "assets/images/suvic.png"){
                                Get.toNamed(Routes.SUVIC);
                              }else{
                                Get.toNamed(Routes.NOTIFYCOVID);
                              }

                            },
                            child: Row(
                              children: [
                                Text(
                                  "Saiba Mais ",
                                  style: TextStyle(
                                      color: Colors.yellow,
                                      fontWeight: FontWeight.w800,
                                      fontSize: 20),
                                ),
                                Icon(Icons.arrow_forward, color: Colors.yellow,)
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              );
            //);
          },
        );
      }).toList(),
    );
  }
}
