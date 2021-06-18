class AgendamentModel {
  final int? id;
  final String? idClinica;
  final String? vaccine;
  final String? data;
  final String? time;
  final String? cardRegistered;

  AgendamentModel({
    this.id,
    this.idClinica,
    this.vaccine,
    this.data,
    this.time,
    this.cardRegistered,
  });

  factory AgendamentModel.fromJson(Map<String, dynamic> json) =>
      AgendamentModel(
        id: json['id'],
        idClinica: json['idClinica'],
        vaccine: json['idVaccine'],
        data: json['data'],
        time: json['time'],
        cardRegistered: json['cardRegistered'],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "idClinica": idClinica,
        "idVaccine": vaccine,
        "data": data,
        "time": time,
        "cardRegistered": cardRegistered,
      };
}
