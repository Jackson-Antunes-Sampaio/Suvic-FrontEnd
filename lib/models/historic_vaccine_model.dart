class HistoricVaccineModel {
  int? id;
  String? batch;
  String? applicationDate;
  int? doseNumber;
  String? status;
  String? createdAt;
  String? updatedAt;
  int? userId;
  String? vaccineName;
  int? applicatorId;
  int? clinicId;
  User? user;

  HistoricVaccineModel(
      {this.id,
        this.batch,
        this.applicationDate,
        this.doseNumber,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.userId,
        this.vaccineName,
        this.applicatorId,
        this.clinicId,
        this.user});

  HistoricVaccineModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    batch = json['batch'];
    applicationDate = json['applicationDate'];
    doseNumber = json['doseNumber'];
    status = json['status'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    userId = json['userId'];
    vaccineName = json['vaccineName'];
    applicatorId = json['applicatorId'];
    clinicId = json['clinicId'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['batch'] = this.batch;
    data['applicationDate'] = this.applicationDate;
    data['doseNumber'] = this.doseNumber;
    data['status'] = this.status;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['userId'] = this.userId;
    data['vaccineName'] = this.vaccineName;
    data['applicatorId'] = this.applicatorId;
    data['clinicId'] = this.clinicId;
    if (this.user != null) {
      data['user'] = this.user?.toJson();
    }
    return data;
  }

  @override
  String toString() {
    return 'HistoricVaccineModel{id: $id, batch: $batch, applicationDate: $applicationDate, doseNumber: $doseNumber, status: $status, createdAt: $createdAt, updatedAt: $updatedAt, userId: $userId, vaccineName: $vaccineName, applicatorId: $applicatorId, clinicId: $clinicId, user: $user}';
  }
}

class User {
  String? socialName;
  String? email;

  User({this.socialName, this.email});

  User.fromJson(Map<String, dynamic> json) {
    socialName = json['socialName'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['socialName'] = this.socialName;
    data['email'] = this.email;
    return data;
  }

  @override
  String toString() {
    return 'User{socialName: $socialName, email: $email}';
  }
}