import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';

class CarouselCustom extends StatelessWidget {
  const CarouselCustom({Key? key, required this.carouselModel}) : super(key: key);
  final List<CarouselModel> carouselModel;
  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        height: 190,
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
      items: carouselModel.map((e){
        return InkWell(
          onTap: e.onTap,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Container(
              alignment: Alignment.bottomCenter,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage(e.image!,)
                )
              ),
              child: e.title != null? Container(
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                color: Colors.black.withAlpha(50),
                width: double.infinity,
                child: Text("Acesse sua carteinha digital", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),),
              ) : Container(),
            ),
          ),
        );
      }).toList(),
    );
  }
}

class CarouselModel{

  CarouselModel({this.image, this.onTap, this.title});

  String? image;
  Callback? onTap;
  String? title;

}

