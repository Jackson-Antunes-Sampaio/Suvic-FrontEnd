import 'package:get/get.dart';
import 'package:suvic_app/models/scheduledModel.dart';
import 'package:suvic_app/repositories/ScheduledRepository.dart';

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
