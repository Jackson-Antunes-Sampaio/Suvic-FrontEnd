import 'package:covid_19/common/botton_navigation_bar/bottom_navigation_bar_new.dart';
import 'package:covid_19/models/page_manager.dart';
import 'package:covid_19/screens/credit_card/credit_card_screen.dart';
import 'package:covid_19/screens/home/home_screen_new.dart';
import 'package:covid_19/screens/info/info_screen.dart';
import 'package:covid_19/screens/vaccine_card/vaccine_card_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BaseScreen extends StatefulWidget {
  @override
  _BaseScreenState createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {

  PageController pageController = PageController();
  PageManager pageManager = Get.put(PageManager());
  var _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        // onPageChanged: (index){
        //   pageManager.setPage(index);
        // },
        controller: pageController,
        children: [
          HomeScreenNew(),
          VaccineCardScreen(),
          InfoScreen(),
          CreditCardScreen(),
          // Scaffold(
          //   body: Center(
          //     child: Text("Em Desenvolvimento", style: TextStyle(fontSize: 20),),
          //   ),
          // ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBarNew(pageController),
      //bottomNavigationBar: CustomNavigationBar(pageController),
    );
  }
}
