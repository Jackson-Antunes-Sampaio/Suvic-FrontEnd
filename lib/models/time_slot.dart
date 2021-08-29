class TimeSlots {
  int? clinicId;
  String? date;

  TimeSlots({this.clinicId, this.date});

  TimeSlots.fromJson(Map<String, dynamic> json) {
    clinicId = json['clinicId'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['clinicId'] = this.clinicId;
    data['date'] = this.date;
    return data;
  }
}