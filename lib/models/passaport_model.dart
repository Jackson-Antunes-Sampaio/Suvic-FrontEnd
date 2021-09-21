class PassaportModel {
  String? civilName;
  String? birthdate;
  String? cpf;
  String? email;
  String? password;
  String? documentFront;

  PassaportModel(
      {this.civilName,
      this.birthdate,
      this.cpf,
      this.email,
      this.password,
      this.documentFront});

  PassaportModel.fromJson(Map<String, dynamic> json) {
    civilName = json['civilName'];
    birthdate = json['birthdate'];
    cpf = json['cpf'];
    email = json['email'];
    password = json['password'];
    documentFront = json['documentFront'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['civilName'] = this.civilName;
    data['birthdate'] = this.birthdate;
    data['cpf'] = this.cpf;
    data['email'] = this.email;
    data['password'] = this.password;
    data['documentFront'] = this.documentFront;

    return data;
  }
}
