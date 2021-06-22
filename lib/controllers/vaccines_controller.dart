import 'package:covid_19/models/vacine_card_model.dart';
import 'package:covid_19/repositories/vaccines_repository.dart';
import 'package:get/get.dart';

class VaccinesController extends GetxController {
  VaccineRepository vaccineRepository = VaccineRepository();
  List<VaccineCardModel> vaccinesCard = [];

  @override
  void onInit() {
    super.onInit();
    getVaccines();
  }

  void getVaccines() async {
    try {
      final List<VaccineCardModel> response =
          await vaccineRepository.getVaccineCard();
      vaccinesCard.addAll(response);
    } catch (e) {
      print(e);
    }
  }
}
