class PriceVacine {
  final String vacine;
  final int price;

  PriceVacine({
    required this.vacine,
    required this.price,
  });

  factory PriceVacine.fromJson(Map<String, dynamic> json) => PriceVacine(
        vacine: json['vacine'],
        price: json['price'],
      );

  Map<String, dynamic> toJson() => {
        "vacine": vacine,
        'price': price,
      };
}
