import 'package:get/get.dart';

class NotificationController extends GetxController {
  bool news = false;

  getNews() {
    //busca info no serviço e joga resultData no news boleano
    if (news) {
      repeatAnimation();
    } else {
      pauseAnimation();
    }
  }

  repeatAnimation() {}

  pauseAnimation() {}
}
