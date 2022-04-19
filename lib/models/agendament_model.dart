class AgendementModel {
  int? clinicId;
  String? vaccine;
  int? slot;
  bool? houseCall;
  String? date;
  String? phone;

  AgendementModel(
      {this.clinicId,
      this.vaccine,
      this.slot,
      this.houseCall,
      this.date,
      this.phone});

  AgendementModel.fromJson(Map<String, dynamic> json) {
    clinicId = json['clinicId'];
    vaccine = json['vaccine'];
    slot = json['slot'];
    houseCall = json['houseCall'];
    date = json['date'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['clinicId'] = this.clinicId;
    data['vaccine'] = this.vaccine;
    data['slot'] = this.slot;
    data['houseCall'] = this.houseCall;
    data['date'] = this.date;
    data['phone'] = this.phone;
    return data;
  }
}
