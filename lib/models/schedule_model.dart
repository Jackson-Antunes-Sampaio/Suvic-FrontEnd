class ScheduleModel {
  int? id;
  int? slot;
  String? date;
  bool? houseCall;
  String? createdAt;
  String? updatedAt;
  int? userId;
  String? cpf;
  int? clinicId;
  String? vaccineName;
  User? user;
  Clinic? clinic;
  Vaccine? vaccine;

  ScheduleModel(
      {this.id,
        this.slot,
        this.date,
        this.houseCall,
        this.createdAt,
        this.updatedAt,
        this.userId,
        this.clinicId,
        this.vaccineName,
        this.user,
        this.clinic,
        this.vaccine, this.cpf});

  ScheduleModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    slot = json['slot'];
    date = json['date'];
    houseCall = json['houseCall'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    userId = json['userId'];
    cpf = json['cpf'];
    clinicId = json['clinicId'];
    vaccineName = json['vaccineName'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    clinic =
    json['clinic'] != null ? new Clinic.fromJson(json['clinic']) : null;
    vaccine =
    json['vaccine'] != null ? new Vaccine.fromJson(json['vaccine']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['slot'] = this.slot;
    data['date'] = this.date;
    data['houseCall'] = this.houseCall;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['userId'] = this.userId;
    data['cpf'] = this.cpf;
    data['clinicId'] = this.clinicId;
    data['vaccineName'] = this.vaccineName;
    if (this.user != null) {
      data['user'] = this.user?.toJson();
    }
    if (this.clinic != null) {
      data['clinic'] = this.clinic?.toJson();
    }
    if (this.vaccine != null) {
      data['vaccine'] = this.vaccine?.toJson();
    }
    return data;
  }

  @override
  String toString() {
    return 'ScheduleModel{id: $id, slot: $slot, date: $date, houseCall: $houseCall, createdAt: $createdAt, updatedAt: $updatedAt, userId: $userId, cpf: $cpf, clinicId: $clinicId, vaccineName: $vaccineName, user: $user, clinic: $clinic, vaccine: $vaccine}';
  }
}

class User {
  String? civilName;
  String? email;

  User({this.civilName, this.email});

  User.fromJson(Map<String, dynamic> json) {
    civilName = json['civilName'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['civilName'] = this.civilName;
    data['email'] = this.email;
    return data;
  }

  @override
  String toString() {
    return 'User{civilName: $civilName, email: $email}';
  }
}

class Clinic {
  int? openingTime;
  double? appointmentDuration;

  Clinic({this.openingTime, this.appointmentDuration});

  Clinic.fromJson(Map<String, dynamic> json) {
    openingTime = json['openingTime'];
    appointmentDuration = json['appointmentDuration'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['openingTime'] = this.openingTime;
    data['appointmentDuration'] = this.appointmentDuration;
    return data;
  }

  @override
  String toString() {
    return 'Clinic{openingTime: $openingTime, appointmentDuration: $appointmentDuration}';
  }
}

class Vaccine {
  String? name;
  int? dose;
  String? manufacturer;

  Vaccine({this.name, this.dose, this.manufacturer});

  Vaccine.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    dose = json['dose'] ?? 1;
    manufacturer = json['manufacturer'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['dose'] = this.dose;
    data['manufacturer'] = this.manufacturer;
    return data;
  }

  @override
  String toString() {
    return 'Vaccine{name: $name, dose: $dose, manufacturer: $manufacturer}';
  }
}