import 'package:covid_19/models/user_model.dart';

class ScheduledModel {
  String? date;
  String? updatedAt;
  int? slot;
  double? time;
  UserModel? user;
  String? status;

  ScheduledModel(
      {this.date,
      this.updatedAt,
      this.slot,
      this.time,
      this.user,
      this.status});

  ScheduledModel.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    updatedAt = json['updatedAt'];
    slot = json['slot'];
    time = json['time'];
    user = json['user'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    data['updatedAt'] = this.updatedAt;
    data['slot'] = this.slot;
    data['time'] = this.time;
    data['user'] = this.user;
    data['status'] = this.status;
    return data;
  }
}
