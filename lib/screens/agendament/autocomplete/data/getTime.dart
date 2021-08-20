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
