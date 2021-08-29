import 'package:covid_19/models/time_slot.dart';
import 'package:covid_19/utils/constants.dart';
import 'package:covid_19/utils/dio/custom_dio.dart';
import 'package:dio/dio.dart';

class SlotTimesRepository {
  Future<TimeSlots?> getSlotsByClinic(id) async {
    try {
      Dio? dio = CustomDio().instance;
      final response = await dio!.get(API_URL + 'clinics/slots');
      List<TimeSlots> slotsTime = [];
      response.data.forEach((element) {
        slotsTime.add(TimeSlots.fromJson(element));
        print(slotsTime);
      });
    } catch (erro) {
      print(erro);
    }
  }
}