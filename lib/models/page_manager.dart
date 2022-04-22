import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PageManager extends GetxController {
  final indexNavigation = 0.obs;
  late final PageController pageController;
  int? iniIndex;

  PageManager({this.iniIndex}) {
    pageController = PageController(initialPage: iniIndex ?? 0);
    indexNavigation.value = iniIndex ?? 0;
  }
}
