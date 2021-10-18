

import 'package:suvic_app/controllers/time_slot.dart';

class GetTimeScheld {
  static final List<Map<String, dynamic>> times = [];

  static List<Map<String, dynamic>> getTimer(TimeSlotController controller) {
    var timesSlote = controller.timeSlots;

    times.clear();
    timesSlote.forEach((element) {
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
    return times;
  }
}

// import 'package:covid_19/models/time_slots.dart';
// import 'package:covid_19/repositories/slots_times.dart';
//
// class GetTimeScheld {
//   static final List<String> times = [];
//   TimeSlots? data;
//
//   Future<TimeSlots?> getTimer(SlotTimesRepository slot, id) async {
//     data = await slot.getSlotsByClinic(id);
//     return data; // Verificar retorno
//   }
//
//   static List<String> getSuggestions(String query) {
//     List<String> matches = <String>[];
//     matches.addAll(times);
//
//     matches.retainWhere((s) => s.toLowerCase().contains(query.toLowerCase()));
//     return matches;
//   }
// }
