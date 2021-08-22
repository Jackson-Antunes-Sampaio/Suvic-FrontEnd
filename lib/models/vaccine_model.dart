class VaccinesModel {
  String? name;
  List<Type>? type;
  String? createdAt;
  String? updatedAt;

  VaccinesModel({this.name, this.type, this.createdAt, this.updatedAt});

  VaccinesModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    if (json['type'] != null) {
      type = [];
      json['type'].forEach((v) {
        type?.add(new Type.fromJson(v));
      });
    }
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    if (this.type != null) {
      data['type'] = this.type?.map((v) => v.toJson()).toList();
    }
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }

  @override
  String toString() {
    return 'VaccinesModel{name: $name, type: $type, createdAt: $createdAt, updatedAt: $updatedAt}';
  }
}

class Type {
  int? duration;
  String? manufacturer;
  int? numberOfDoses;
  int? timeBetweenDoses;

  Type(
      {this.duration,
        this.manufacturer,
        this.numberOfDoses,
        this.timeBetweenDoses});

  Type.fromJson(Map<String, dynamic> json) {
    duration = json['duration'];
    manufacturer = json['manufacturer'];
    numberOfDoses = json['numberOfDoses'];
    timeBetweenDoses = json['timeBetweenDoses'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['duration'] = this.duration;
    data['manufacturer'] = this.manufacturer;
    data['numberOfDoses'] = this.numberOfDoses;
    data['timeBetweenDoses'] = this.timeBetweenDoses;
    return data;
  }

  @override
  String toString() {
    return 'Type{duration: $duration, manufacturer: $manufacturer, numberOfDoses: $numberOfDoses, timeBetweenDoses: $timeBetweenDoses}';
  }
}