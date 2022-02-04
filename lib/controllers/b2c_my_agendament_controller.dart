import 'package:get/get.dart';
import 'package:suvic_app/models/b2c_my_agendament_model.dart';
import 'package:suvic_app/repositories/b2c_my_agendament_repository.dart';


class B2cMyagendamentController extends GetxController {

  List<B2cMyAgendamentModel> list =<B2cMyAgendamentModel>[];
  B2cMyAgendamentRepository repository =B2cMyAgendamentRepository();


  getDatas()async{
    list = await repository.getVaccineCard() as List<B2cMyAgendamentModel>;
    print('LIST===>$list');
    update();
  }

  statusToUser(String status){
    switch(status) {
      case 'scheduled': {
        return  'agendado';
      }
      case 'awaitingCommit': {
        return 'realizado';
      }
      case 'late': {
        return 'atrasado';
      }
      case 'latePaid': {
        return 'Atrasado pago';
      }
      case 'complete': {
        return 'realizado';
      }
      case 'scheduledPaid': {
        return 'Agendado pago';
      }
      case 'canceledPaid': {
        return 'Cancelado pago';
      }
      default: {
        return 'Desconhecido/aguardando';
      }
    }
  }



  @override
  void onInit() {
    getDatas();
    super.onInit();
  }
}