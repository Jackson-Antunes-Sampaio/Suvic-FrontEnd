class VaccineModel {
  String? name;

  VaccineModel({this.name});

  factory VaccineModel.fromJson(Map<String, dynamic> json) =>
      VaccineModel(name: json["name"]);

  Map<String, dynamic> toJson() => {"name": name};
}
