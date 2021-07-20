class PagarMeModel {
  int? amount;
  String? cardNumber;
  String? cardCvv;
  String? cardExpirationDate;
  String? cardHolderName;
  Customer? customer;
  Billing? billing;
  List<Items?>? items;

  PagarMeModel(
      {this.amount,
        this.cardNumber,
        this.cardCvv,
        this.cardExpirationDate,
        this.cardHolderName,
        this.customer,
        this.billing,
        this.items});

  PagarMeModel.fromJson(Map<String, dynamic> json) {
    amount = json['amount'];
    cardNumber = json['card_number'];
    cardCvv = json['card_cvv'];
    cardExpirationDate = json['card_expiration_date'];
    cardHolderName = json['card_holder_name'];
    customer = json['customer'] != null
        ? new Customer.fromJson(json['customer'])
        : null;
    billing =
    json['billing'] != null ? new Billing.fromJson(json['billing']) : null;
    if (json['items'] != null) {
      items =  [];
      json['items'].forEach((v) {
        items?.add(new Items.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['amount'] = this.amount;
    data['card_number'] = this.cardNumber;
    data['card_cvv'] = this.cardCvv;
    data['card_expiration_date'] = this.cardExpirationDate;
    data['card_holder_name'] = this.cardHolderName;
    if (this.customer != null) {
      data['customer'] = this.customer?.toJson();
    }
    if (this.billing != null) {
      data['billing'] = this.billing?.toJson();
    }
    if (this.items != null) {
      data['items'] = this.items?.map((v) => v?.toJson()).toList();
    }
    return data;
  }

  @override
  String toString() {
    return 'PagarMeModel{amount: $amount, cardNumber: $cardNumber, cardCvv: $cardCvv, cardExpirationDate: $cardExpirationDate, cardHolderName: $cardHolderName, customer: $customer, billing: $billing, items: $items}';
  }
}

class Customer {
  String? externalId;
  String? name;
  String? type;
  String? country;
  String? email;
  List<Documents?>? documents;
  List<String?>? phoneNumbers;
  String? birthday;

  Customer(
      {this.externalId,
        this.name,
        this.type,
        this.country,
        this.email,
        this.documents,
        this.phoneNumbers,
        this.birthday});

  Customer.fromJson(Map<String, dynamic> json) {
    externalId = json['external_id'];
    name = json['name'];
    type = json['type'];
    country = json['country'];
    email = json['email'];
    if (json['documents'] != null) {
      documents = [];
      json['documents'].forEach((v) {
        documents?.add(new Documents.fromJson(v));
      });
    }
    phoneNumbers = json['phone_numbers'].cast<String>();
    birthday = json['birthday'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['external_id'] = this.externalId;
    data['name'] = this.name;
    data['type'] = this.type;
    data['country'] = this.country;
    data['email'] = this.email;
    if (this.documents != null) {
      data['documents'] = this.documents?.map((v) => v?.toJson()).toList();
    }
    data['phone_numbers'] = this.phoneNumbers;
    data['birthday'] = this.birthday;
    return data;
  }
}

class Documents {
  String? type;
  String? number;

  Documents({this.type, this.number});

  Documents.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    number = json['number'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['number'] = this.number;
    return data;
  }
}

class Billing {
  String? name;
  Address? address;

  Billing({this.name, this.address});

  Billing.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    address =
    json['address'] != null ? new Address.fromJson(json['address']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    if (this.address != null) {
      data['address'] = this.address?.toJson();
    }
    return data;
  }
}

class Address {
  String? country;
  String? state;
  String? city;
  String? neighborhood;
  String? street;
  String? streetNumber;
  String? zipcode;

  Address(
      {this.country,
        this.state,
        this.city,
        this.neighborhood,
        this.street,
        this.streetNumber,
        this.zipcode});

  Address.fromJson(Map<String, dynamic> json) {
    country = json['country'];
    state = json['state'];
    city = json['city'];
    neighborhood = json['neighborhood'];
    street = json['street'];
    streetNumber = json['street_number'];
    zipcode = json['zipcode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['country'] = this.country;
    data['state'] = this.state;
    data['city'] = this.city;
    data['neighborhood'] = this.neighborhood;
    data['street'] = this.street;
    data['street_number'] = this.streetNumber;
    data['zipcode'] = this.zipcode;
    return data;
  }
}

class Items {
  String? id;
  String? title;
  int? unitPrice;
  int? quantity;
  bool? tangible;

  Items({this.id, this.title, this.unitPrice, this.quantity, this.tangible});

  Items.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    unitPrice = json['unit_price'];
    quantity = json['quantity'];
    tangible = json['tangible'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['unit_price'] = this.unitPrice;
    data['quantity'] = this.quantity;
    data['tangible'] = this.tangible;
    return data;
  }
}