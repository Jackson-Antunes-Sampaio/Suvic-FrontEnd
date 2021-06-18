class UserModel {
  final int? id;
  final String? name;
  final String? email;
  final String? password;
  final String? createdAt;
  final String? updatedAt;
  final String? permissionLevel;
  final int? clinicId;

  UserModel({
    this.id,
    this.name,
    this.email,
    this.password,
    this.createdAt,
    this.updatedAt,
    this.permissionLevel,
    this.clinicId,
  });

  UserModel.fromJson(Map<String, Object?> json)
      : this(
          id: json['id'] as int,
          name: json['name'] as String,
          email: json['email'] as String,
          password: json['password'] as String,
          createdAt: json['createdAt'] as String,
          updatedAt: json['updatedAt'] as String,
          permissionLevel: json['permissionLevel'] as String,
          clinicId: json['clinicId'] as int,
        );

  Map<String, Object?> toJson() => {
        'id': id,
        'name': name,
        'email': email,
        'password': password,
        'createdAt': createdAt,
        'updatedAt': updatedAt,
        'permissionLevel': permissionLevel,
        'clinicId': clinicId,
      };
}


// class UserModel {
//   String? id;
//   String? name;
//   String? email;
//   String? password;
//   String? createdAt;
//   String? updatedAt;
//   String? permissionLevel;
//   String? clinicId;

//   UserModel(
//       {this.id,
//       this.name,
//       this.email,
//       this.password,
//       this.createdAt,
//       this.updatedAt,
//       this.permissionLevel,
//       this.clinicId});

//   UserModel.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     name = json['name'];
//     email = json['email'];
//     password = json['password'];
//     createdAt = json['createdAt'];
//     updatedAt = json['updatedAt'];
//     permissionLevel = json['permissionLevel'];
//     clinicId = json['clinicId'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['name'] = this.name;
//     data['email'] = this.email;
//     data['password'] = this.password;
//     data['createdAt'] = this.createdAt;
//     data['updatedAt'] = this.updatedAt;
//     data['permissionLevel'] = this.permissionLevel;
//     data['clinicId'] = this.clinicId;
//     return data;
//   }

//   @override
//   String toString() {
//     return 'UserModel{id: $id, name: $name, email: $email, password: $password, createdAt: $createdAt, updatedAt: $updatedAt, permissionLevel: $permissionLevel, clinicId: $clinicId}';
//   }
// }