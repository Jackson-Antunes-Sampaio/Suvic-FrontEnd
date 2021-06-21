class StockVacineModel {
  final int? id;
  final String? idClinica;
  final String name;
  final int lote;
  final String dataValidade;
  final int quantidade;
  final double valor;

  StockVacineModel({
    this.id,
    this.idClinica,
    required this.name,
    required this.lote,
    required this.dataValidade,
    required this.quantidade,
    required this.valor,
  });

  factory StockVacineModel.fromJson(Map<String, dynamic> json) =>
      StockVacineModel(
        id: json['id'],
        idClinica: json['idClinica'],
        name: json['name'],
        lote: json['lote'],
        dataValidade: json['dataValidade'],
        quantidade: json['quantidade'],
        valor: json['valor'],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        'idClinica': idClinica,
        "name": name,
        "lote": lote,
        "dataValidade": dataValidade,
        "quantidade": quantidade,
        'valor': valor,
      };
}
