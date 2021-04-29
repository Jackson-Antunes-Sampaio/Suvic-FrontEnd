class UserModel {
  final int? id;
  final String? name;
  final String? email;
  final String? password;

  UserModel({this.id, this.name, this.email, this.password});

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
      id: json["id"],
      name: json["name"],
      email: json["email"],
      password: json["password"]);

  Map<String, dynamic> toJson() =>
      {"id": id, "name": name, "email": email, "password": password};
}
