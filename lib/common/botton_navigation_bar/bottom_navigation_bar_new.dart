import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class BottomNavigationBarNew extends StatefulWidget {
  @override
  _BottomNavigationBarNewState createState() => _BottomNavigationBarNewState();
  BottomNavigationBarNew(this.pageController);
  final PageController pageController;
}

class _BottomNavigationBarNewState extends State<BottomNavigationBarNew> {

  RxInt _currentIndex = 0.obs;
  @override
  Widget build(BuildContext context) {
    return Obx((){
      return Container(

        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey[100]!),
        ),
        child: SalomonBottomBar(
          currentIndex:  _currentIndex.value,
          onTap: (index) {
            _currentIndex.value = index;
            widget.pageController.jumpToPage(index);
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
              icon: Icon(Icons.search),
              title: Text("Pesquisar"),
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




