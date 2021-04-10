class VacineCard {
  final int id;
  final String batch;
  final String applicationDate;

  VacineCard({this.id, this.batch, this.applicationDate});

  factory VacineCard.fromJson(Map<String, dynamic> json) => VacineCard(
      id: json["id"],
      batch: json["batch"],
      applicationDate: json["applicationDate"]);

  Map<String, dynamic> tojson() =>
      {"id": id, "batch": batch, "applicationDate": applicationDate};
}
