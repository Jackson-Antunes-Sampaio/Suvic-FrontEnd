class UserModel {
  String? civilName;
  String? socialName;
  String? cpf;
  int? rg;
  String? sUScard;
  String? birthdate;
  String? sex;
  bool? healthProfessional;
  String? addressStreetName;
  String? addressNumber;
  String? addressComplement;
  String? addressDistrict;
  String? addressCity;
  String? addressState;
  String? addressZip;
  String? addressCountry;
  bool? contactPreferenceWhatsapp;
  bool? contactPreferenceSms;
  bool? contactPreferenceEmail;
  bool? contactPreferencePush;
  String? contactPhone;
  String? contactCellphone;
  String? email;
  String? bloodType;
  bool? bedridden;
  bool? covidLast30Days;
  int? id;
  String? password;
  String? createdAt;
  String? updatedAt;
  String? permissionLevel;
  int? clinicId;

  UserModel(
      {this.civilName,
        this.socialName,
        this.cpf,
        this.rg,
        this.sUScard,
        this.birthdate,
        this.sex,
        this.healthProfessional,
        this.addressStreetName,
        this.addressNumber,
        this.addressComplement,
        this.addressDistrict,
        this.addressCity,
        this.addressState,
        this.addressZip,
        this.addressCountry,
        this.contactPreferenceWhatsapp,
        this.contactPreferenceSms,
        this.contactPreferenceEmail,
        this.contactPreferencePush,
        this.contactPhone,
        this.contactCellphone,
        this.email,
        this.bloodType,
        this.bedridden,
        this.covidLast30Days,
        this.id,
        this.password,
        this.createdAt,
        this.updatedAt,
        this.permissionLevel,
        this.clinicId});

  UserModel.fromJson(Map<String, dynamic> json) {
    civilName = json['civilName'];
    socialName = json['socialName'];
    cpf = json['cpf'];
    rg = json['rg'];
    sUScard = json['SUScard'];
    birthdate = json['birthdate'];
    sex = json['sex'];
    healthProfessional = json['healthProfessional'] ?? false;
    addressStreetName = json['address_streetName'];
    addressNumber = json['address_number'];
    addressComplement = json['address_complement'];
    addressDistrict = json['address_district'];
    addressCity = json['address_city'];
    addressState = json['address_state'];
    addressZip = json['address_zip'];
    addressCountry = json['address_country'];
    contactPreferenceWhatsapp = json['contactPreference_whatsapp'];
    contactPreferenceSms = json['contactPreference_sms'];
    contactPreferenceEmail = json['contactPreference_email'];
    contactPreferencePush = json['contactPreference_push'];
    contactPhone = json['contact_phone'];
    contactCellphone = json['contact_cellphone'];
    email = json['email'];
    bloodType = json['bloodType'];
    bedridden = json['bedridden'];
    covidLast30Days = json['covidLast30Days'];
    id = json['id'];
    password = json['password'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    permissionLevel = json['permissionLevel'];
    clinicId = json['clinicId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['civilName'] = this.civilName;
    data['socialName'] = this.socialName;
    data['cpf'] = this.cpf;
    data['rg'] = this.rg;
    data['SUScard'] = this.sUScard;
    data['birthdate'] = this.birthdate;
    data['sex'] = this.sex;
    data['healthProfessional'] = this.healthProfessional;
    data['address_streetName'] = this.addressStreetName;
    data['address_number'] = this.addressNumber;
    data['address_complement'] = this.addressComplement;
    data['address_district'] = this.addressDistrict;
    data['address_city'] = this.addressCity;
    data['address_state'] = this.addressState;
    data['address_zip'] = this.addressZip;
    data['address_country'] = this.addressCountry;
    data['contactPreference_whatsapp'] = this.contactPreferenceWhatsapp;
    data['contactPreference_sms'] = this.contactPreferenceSms;
    data['contactPreference_email'] = this.contactPreferenceEmail;
    data['contactPreference_push'] = this.contactPreferencePush;
    data['contact_phone'] = this.contactPhone;
    data['contact_cellphone'] = this.contactCellphone;
    data['email'] = this.email;
    data['bloodType'] = this.bloodType;
    data['bedridden'] = this.bedridden;
    data['covidLast30Days'] = this.covidLast30Days;
    data['id'] = this.id;
    data['password'] = this.password;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['permissionLevel'] = this.permissionLevel;
    data['clinicId'] = this.clinicId;
    return data;
  }
}
