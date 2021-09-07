import 'package:covid_19/models/priceVacine.dart';
import 'package:covid_19/models/time_slot.dart';
import 'package:covid_19/repositories/time_slot.dart';
import 'package:covid_19/utils/styles/style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class TimeSlotController extends GetxController {
  //user clinic
  var repository = SlotTimesRepository();
  List<TimeSlotsModel> timeSlots = [];
  String? showDate;
  List<PriceVacine> priceVaccine = [];
  List<TimeSlotsModel> slotSeleted = [];

  bool loading = false;
  String idClinic;

  //Get Instance
  static TimeSlotController get to => Get.find();

  //controller
  TimeSlotController({required this.idClinic});

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
      loading = false;
    } else {
      loading = false;
    }
    update();
  }

  void selectDate(BuildContext context) async {
    final DateTime? newDate = await showDatePicker(
      context: context,
      initialEntryMode: DatePickerEntryMode.calendar,
      initialDate: DateTime.now(),
      firstDate: DateTime.now().subtract(Duration(days: 30)),
      lastDate: DateTime.now().add(Duration(days: 30)),
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
