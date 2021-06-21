class VaccineCardModel {
  String? batch;
  String? applicationDate;
  Vaccine? vaccine;

  VaccineCardModel({this.batch, this.applicationDate, this.vaccine});

  VaccineCardModel.fromJson(Map<String, dynamic> json) {
    batch = json['batch'];
    applicationDate = json['applicationDate'];
    vaccine =
    json['vaccine'] != null ? new Vaccine.fromJson(json['vaccine']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['batch'] = this.batch;
    data['applicationDate'] = this.applicationDate;
    if (this.vaccine != null) {
      data['vaccine'] = this.vaccine!.toJson();
    }
    return data;
  }

  @override
  String toString() {
    return 'VaccineCardModel{batch: $batch, applicationDate: $applicationDate, vaccine: $vaccine}';
  }
}

class Vaccine {
  String? name;

  Vaccine({this.name});

  Vaccine.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    return data;
  }

  @override
  String toString() {
    return 'Vaccine{name: $name}';
  }
}
