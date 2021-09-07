class TimeSlotsModel {
  int? slot;
  double? time;
  // dynamic time;
  int? amount;

  TimeSlotsModel({this.slot, this.time, this.amount});

  TimeSlotsModel.fromJson(Map<String, dynamic> json) {
    slot = json['slot'];
    time = json['time'];
    amount = json['amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['slot'] = this.slot;
    data['time'] = this.time;
    data['amount'] = this.amount;
    return data;
  }
}
