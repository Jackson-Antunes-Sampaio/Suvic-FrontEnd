import 'package:covid_19/models/page_manager.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class BottomNavigationBarNew extends StatefulWidget {
  @override
  _BottomNavigationBarNewState createState() => _BottomNavigationBarNewState();

}

class _BottomNavigationBarNewState extends State<BottomNavigationBarNew> {
  PageManager pageManager = Get.find();
  //RxInt _currentIndex = 0.obs;
  @override
  Widget build(BuildContext context) {
    return Obx((){
      return Container(

        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey[100]!),
        ),
        child: SalomonBottomBar(
          currentIndex:  pageManager.indexNavigation.value,
          onTap: (index) {
            print("index: $index");
            pageManager.indexNavigation.value = index;
            pageManager.pageController.jumpToPage(index);
          },
          items: [
            SalomonBottomBarItem(
              icon: Icon(Icons.home),
              title: Text("Home"),
              selectedColor: Theme.of(context).primaryColor,
            ),
            SalomonBottomBarItem(
              icon: Icon(Icons.wallet_membership),
              title: Text("Carteirinha"),
              selectedColor: Theme.of(context).primaryColor,
            ),
            SalomonBottomBarItem(
              icon: Icon(Icons.add),
              title: Text("Adicionar"),
              selectedColor: Theme.of(context).primaryColor,
            ),
            SalomonBottomBarItem(
              icon: Icon(Icons.menu),
              title: Text("Mais"),
              selectedColor: Theme.of(context).primaryColor,
            ),
          ],
        ),
      );
    });
  }
}




