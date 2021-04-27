import 'package:covid_19/models/page_manager.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'custom_icon_navigation_bar.dart';


class CustomNavigationBar extends StatelessWidget {

  final PageController _pageController;
  CustomNavigationBar(this._pageController);
  PageManager pageManager = Get.find();

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
            shape: CircularNotchedRectangle(),
            child: Obx((){
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CustomIconNavigationBar(
                    color: pageManager.indexNavigation.value == 0 ? Theme.of(context).primaryColor : Colors.black,
                    onTap: (){
                      _pageController.jumpToPage(pageManager.indexNavigation.value=0);
                    },
                    iconData: Icons.home,
                    text: "Home",
                    size: null,
                  ),
                  CustomIconNavigationBar(
                    color: pageManager.indexNavigation.value == 1 ? Theme.of(context).primaryColor : Colors.black,
                    onTap: (){
                      _pageController.jumpToPage(pageManager.indexNavigation.value=1);
                    },
                    iconData: Icons.wallet_membership,
                    text: "Carteirinha",
                    size: null,
                  ),
                  CustomIconNavigationBar(
                    color: pageManager.indexNavigation.value == 2 ? Theme.of(context).primaryColor : Colors.black,
                    onTap: (){
                      _pageController.jumpToPage(pageManager.indexNavigation.value=2);
                    },
                    iconData: Icons.map,
                    text: "Notificação",
                    size: null,
                  ),
                  CustomIconNavigationBar(
                    color: pageManager.indexNavigation.value == 3 ? Theme.of(context).primaryColor : Colors.black,
                    onTap: (){
                      _pageController.jumpToPage(pageManager.indexNavigation.value=3);
                    },
                    iconData: Icons.search_outlined,
                    text: "Pesquisar",
                    size: null,
                  ),
                  CustomIconNavigationBar(
                    color: pageManager.indexNavigation.value == 4 ? Theme.of(context).primaryColor : Colors.black,
                    onTap: (){
                      _pageController.jumpToPage(pageManager.indexNavigation.value=4);
                    },
                    iconData: Icons.menu,
                    text: "Mais",
                    size: null,
                  ),
                ],
              );
            }),
          );

  }
}