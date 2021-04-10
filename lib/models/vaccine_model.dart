class Vaccine {
  String name;

  Vaccine({this.name});

  factory Vaccine.fromJson(Map<String, dynamic> json) =>
      Vaccine(name: json["name"]);

  Map<String, dynamic> toJson() => {"name": name};
}
