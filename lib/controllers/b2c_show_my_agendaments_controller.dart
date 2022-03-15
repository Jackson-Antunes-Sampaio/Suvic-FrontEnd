import 'package:get/get.dart';
import 'package:suvic_app/models/b2c_my_agendament_model.dart';
import 'package:suvic_app/repositories/ScheduledRepository.dart';
import 'package:suvic_app/repositories/b2c_show_my_agendaments_repository.dart';


class B2cShowMyAgendamentsController extends GetxController {

  B2cMyAgendamentModel data = Get.arguments[0];
  int index= Get.arguments[1];
  B2cShowMyAgendamentsRepository repository=B2cShowMyAgendamentsRepository();
  ScheduledRepository scheduledRepository= ScheduledRepository();
  alterAgendament(){

  }
  cancelAgendament()async{
    var scheduleList= await scheduledRepository.getAllScheduled();
    repository.delete(scheduleList[index]);
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


}