class B2cMyAgendamentModel{

  int? id;
  String? batch;
  String? applicationDate;
  int? doseNumber;
  String? status;
  String? manufacturer;
  String? createdAt;
  String? updatedAt;
  int? userId;
  String? vaccineName;
  int? applicatorId;
  int? clinicId;
  Vaccine? vaccine;

  B2cMyAgendamentModel(
  {this.id,
  this.batch,
  this.applicationDate,
  this.doseNumber,
  this.status,
  this.manufacturer,
  this.createdAt,
  this.updatedAt,
  this.userId,
  this.vaccineName,
  this.applicatorId,
  this.clinicId,
  this.vaccine});

  B2cMyAgendamentModel.fromJson(Map<String, dynamic> json) {
  id = json['id'];
  batch = json['batch'];
  applicationDate = json['applicationDate'];
  doseNumber = json['doseNumber'];
  status = json['status'];
  manufacturer = json['manufacturer'];
  createdAt = json['createdAt'];
  updatedAt = json['updatedAt'];
  userId = json['userId'];
  vaccineName = json['vaccineName'];
  applicatorId = json['applicatorId'];
  clinicId = json['clinicId'];
  vaccine =
  json['vaccine'] != null ? new Vaccine.fromJson(json['vaccine']) : null;
  }

  Map<String, dynamic> toJson() {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['id'] = this.id;
  data['batch'] = this.batch;
  data['applicationDate'] = this.applicationDate;
  data['doseNumber'] = this.doseNumber;
  data['status'] = this.status;
  data['manufacturer'] = this.manufacturer;
  data['createdAt'] = this.createdAt;
  data['updatedAt'] = this.updatedAt;
  data['userId'] = this.userId;
  data['vaccineName'] = this.vaccineName;
  data['applicatorId'] = this.applicatorId;
  data['clinicId'] = this.clinicId;
  if (this.vaccine != null) {
  data['vaccine'] = this.vaccine?.toJson();
  }
  return data;
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
  }