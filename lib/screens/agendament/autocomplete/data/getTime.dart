class GetTimeScheld {
  static final List<String> times = [
    '09:30',
    '10:30',
    '11:30',
    '12:30',
    '13:30',
    '14:30',
  ];

  static List<String> getTimer() {
    return times;
  }

  static List<String> getSuggestions(String query) {
    List<String> matches = <String>[];
    matches.addAll(times);

    matches.retainWhere((s) => s.toLowerCase().contains(query.toLowerCase()));
    return matches;
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
