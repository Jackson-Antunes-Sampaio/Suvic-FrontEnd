import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class NotificationController extends GetxController {
  late RxBool news;
  late RxBool show;
  PageController pageController = PageController();
  @override
  onInit() {
    super.onInit();
    //news.value = false;
    getNews();
  }

  getNews() {
    //busca info no serviço e joga resultData no news boleano
    if (news.value) {
      showAnimation();
    } else {
      pauseAnimation();
    }
  }

  showAnimation() {
    show.value = true;
  }

  pauseAnimation() {
    show.value = false;
  }
}
