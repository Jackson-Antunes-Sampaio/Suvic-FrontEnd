class AgendamentModel {
  final int? id;
  final String? idClinica;
  final String? userId;
  final String? idVaccine;
  final String? data;
  final String? time;
  final String? cardRegistered;

  AgendamentModel({
    this.id,
    this.idClinica,
    this.userId,
    this.idVaccine,
    this.data,
    this.time,
    this.cardRegistered,
  });

  factory AgendamentModel.fromJson(Map<String, dynamic> json) =>
      AgendamentModel(
        id: json['id'],
        idClinica: json['idClinica'],
        userId: json['userId'],
        idVaccine: json['idVaccine'],
        data: json['data'],
        time: json['time'],
        cardRegistered: json['cardRegistered'],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "idClinica": idClinica,
        "userId": userId,
        "idVaccine": idVaccine,
        "data": data,
        "time": time,
        "cardRegistered": cardRegistered,
      };
}
