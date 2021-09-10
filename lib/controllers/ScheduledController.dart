import 'package:covid_19/models/scheduledModel.dart';
import 'package:covid_19/repositories/ScheduledRepository.dart';
import 'package:get/get.dart';

class ScheduledController extends GetxController {
  var repository = ScheduledRepository();
  List<ScheduledModel> scheduleds = [];

  bool loading = false;

  ScheduledController() {
    init();
  }

  init() {
    getAllScheduleds();
  }

  getAllScheduleds() async {
    loading = true;
    var scheduledsList = await repository.getAllScheduled();

    scheduledsList.forEach((scheduled) {
      scheduleds.add(scheduled);
    });

    loading = false;
    update();
  }
}
