class UserModel {
  int? id;
  String? name;
  String? email;
  String? password;
  String? createdAt;
  String? updatedAt;
  bool? permissionLevel;
  String? clinicId;

  UserModel(
      {this.id,
        this.name,
        this.email,
        this.password,
        this.createdAt,
        this.updatedAt,
        this.permissionLevel,
        this.clinicId});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    password = json['password'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    permissionLevel = json['permissionLevel'];
    clinicId = json['clinicId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['password'] = this.password;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['permissionLevel'] = this.permissionLevel;
    data['clinicId'] = this.clinicId;
    return data;
  }

  @override
  String toString() {
    return 'UserModel{id: $id, name: $name, email: $email, password: $password, createdAt: $createdAt, updatedAt: $updatedAt, permissionLevel: $permissionLevel, clinicId: $clinicId}';
  }
}