
import 'package:get/get.dart';
import 'package:suvic_app/models/vacine_card_model.dart';
import 'package:suvic_app/repositories/vaccines_repository.dart';
class VaccinesController extends GetxController{


  VaccineRepository vaccineRepository = VaccineRepository();
  List<VaccineCardModel> vaccinesCard = [];
  List<VaccineCardModel> vaccinesFilterCard = [];
  RxBool loading = false.obs;

  @override
  void onInit() {
    super.onInit();
    getVaccines();
  }

  
  Future<void> getVaccines()async{
    loading.value = true;
    try {
      final List<VaccineCardModel> response = await vaccineRepository.getVaccineCard();

      vaccinesCard = [];
      vaccinesFilterCard = [];

      vaccinesCard.addAll(response);
      vaccinesFilterCard.addAll(vaccinesCard);
      loading.value = false;
    }catch(e){
      loading.value = false;
      print(e);
    }
  }
  
  void filter(String value)async{
    loading.value = true;
    if(value == ""){
      await getVaccines();
      print(vaccinesFilterCard);

    }else{
      value = value.toUpperCase();
      vaccinesFilterCard = [];
      var list = vaccinesCard.where((e) {
        String? name = e.vaccine!.name!.toUpperCase();
        return name.contains("$value");
      });
      vaccinesFilterCard.addAll(list);

    }
    loading.value = false;
  }


}


  