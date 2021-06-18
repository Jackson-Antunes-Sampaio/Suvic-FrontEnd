class ClinicModel {
  final int? id;
  final String? name;
  final String? phone;
  final String? email;
  final String? address;
  final latitude;
  final longitude;

  ClinicModel({
    this.id,
    this.name,
    this.phone,
    this.email,
    this.address,
    this.latitude,
    this.longitude,
  });

  ClinicModel.fromJson(Map<String, Object?> json)
      : this(
          id: json['id'] as int,
          name: json['name'] as String,
          phone: json['phone'] as String,
          email: json['email'] as String,
          address: json['address'] as String,
          latitude: json['latitude'] as dynamic,
          longitude: json['longitude'] as dynamic,
        );

  Map<String, Object?> toJson() => {
        'id': id,
        'name': name,
        'phone': phone,
        'email': email,
        'address': address,
        'latitude': latitude,
        'longitude': longitude,
      };
}
