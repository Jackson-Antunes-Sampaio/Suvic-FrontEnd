class VaccineCardModel {
  final int id;
  final String batch;
  final String applicationDate;

  VaccineCardModel({this.id, this.batch, this.applicationDate});

  factory VaccineCardModel.fromJson(Map<String, dynamic> json) => VaccineCardModel(
      id: json["id"],
      batch: json["batch"],
      applicationDate: json["applicationDate"]);

  Map<String, dynamic> tojson() =>
      {"id": id, "batch": batch, "applicationDate": applicationDate};
}
