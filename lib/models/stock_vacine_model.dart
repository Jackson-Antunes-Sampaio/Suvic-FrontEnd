class StockVacineModel {
  final int? id;
  final String? idClinica;
  final String name;
  final String lote;
  final int? reserved;
  final String dataValidade;
  final int quantidade;

  StockVacineModel({
    this.id,
    this.idClinica,
    required this.name,
    required this.lote,
    this.reserved,
    required this.dataValidade,
    required this.quantidade,
  });

  factory StockVacineModel.fromJson(Map<String, dynamic> json) =>
      StockVacineModel(
        id: json['id'],
        idClinica: json['idClinica'],
        name: json['name'],
        lote: json['lote'],
        reserved: json['reserved'],
        dataValidade: json['dataValidade'],
        quantidade: json['quantidade'],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        'idClinica': idClinica,
        "name": name,
        "lote": lote,
        "reserved": reserved,
        "dataValidade": dataValidade,
        "quantidade": quantidade,
      };
}
