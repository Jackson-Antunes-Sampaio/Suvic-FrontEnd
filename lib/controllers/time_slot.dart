import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:suvic_app/models/priceVacine.dart';
import 'package:suvic_app/models/time_slot.dart';
import 'package:suvic_app/repositories/time_slot.dart';
import 'package:suvic_app/utils/styles/style.dart';

class TimeSlotController extends GetxController {
  //user clinic
  var repository = SlotTimesRepository();
  List<TimeSlotsModel> timeSlots = [];
  List times = [];
  String? showDate;
  List<PriceVacine> priceVaccine = [];
  List<TimeSlotsModel> slotSeleted = [];

  bool loading = false;
  String idClinic;

  //Get Instance
  static TimeSlotController get to => Get.find();

  //controller
  TimeSlotController({required this.idClinic});

  getTimeOfSlot() {
    times.clear();
    timeSlots.forEach((element) {
      String time = element.time.toString();
      var timeList = time.split('.');
      var calMinutes = (double.parse(('0.' + timeList[1]))) * 60;
      var minutes =
          calMinutes.toInt() == 0 ? '00' : calMinutes.toInt().toString();

      times.add({
        'value': timeList[0] + ':' + minutes,
        'slot': element.slot,
        'timeSlot': element.time
      });
    });
    update();
  }

  void getSlotsByClinic(String idClinic, String date) async {
    loading = true;
    var getTimeSlots = await repository.getSlotsByClinic(idClinic, date);

    if (getTimeSlots.isNotEmpty) {
      timeSlots.clear();

      getTimeSlots.forEach((slots) {
        if (slots['amount'] > 0) {
          timeSlots.add(
            TimeSlotsModel(
              slot: slots['slot'],
              time: slots['time'].toDouble(),
              amount: slots['amount'],
            ),
          );
        }
      });
    }
    getTimeOfSlot();

    loading = false;

    update();
  }

  void selectDate(BuildContext context) async {
    final DateTime? newDate = await showDatePicker(
      context: context,
      initialEntryMode: DatePickerEntryMode.calendar,
      initialDate: DateTime.now(),
      firstDate: DateTime.now().subtract(Duration(days: 0)),
      lastDate: DateTime.now().add(Duration(days: 90)),
      helpText: 'Selecione a Data',
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.fromSwatch(
              primarySwatch: mtrKPrimaryColor,
              primaryColorDark: mtrKPrimaryColor,
              accentColor: mtrKPrimaryColor,
            ),
            dialogBackgroundColor: Colors.white,
          ),
          child: child!,
        );
      },
    );
    if (newDate != null) {
      var outputFormat = DateFormat('dd/MM/yyyy');
      var date1 = outputFormat.format(newDate);
      showDate = date1;
      //for request
      var outputFormat2 = DateFormat('yyyy-MM-dd');
      var date2 = outputFormat2.format(newDate);
      getSlotsByClinic(idClinic, date2);
    }
    update();
  }

  selectSlot(TimeSlotsModel slot) {
    slotSeleted.clear();
    slotSeleted.add(slot);
    update();
  }
}
