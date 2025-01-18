class GroundModel {
  String? title;
  String? description;
  List<String>? images;
  List<String>? placeTypes;
  List<String>? amenities;
  Location? location;
  BankDetails? bankDetails;
  Slots? slots;

  GroundModel(
      {this.title,
      this.description,
      this.images,
      this.placeTypes,
      this.amenities,
      this.location,
      this.bankDetails,
      this.slots});

  GroundModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    description = json['description'];
    images = json['images'].cast<String>();
    placeTypes = json['placeTypes'].cast<String>();
    amenities = json['amenities'].cast<String>();
    location =
        json['location'] != null ? Location.fromJson(json['location']) : null;
    bankDetails = json['bankDetails'] != null
        ? BankDetails.fromJson(json['bankDetails'])
        : null;
    slots = json['slots'] != null ? Slots.fromJson(json['slots']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['description'] = description;
    data['images'] = images;
    data['placeTypes'] = placeTypes;
    data['amenities'] = amenities;
    if (location != null) {
      data['location'] = location!.toJson();
    }
    if (bankDetails != null) {
      data['bankDetails'] = bankDetails!.toJson();
    }
    if (slots != null) {
      data['slots'] = slots!.toJson();
    }
    return data;
  }
}

class Location {
  String? countryCode;
  String? country;
  String? city;
  String? postalCode;
  String? address;
  String? lat;
  String? lng;

  Location(
      {this.countryCode,
      this.country,
      this.city,
      this.postalCode,
      this.address,
      this.lat,
      this.lng});

  Location.fromJson(Map<String, dynamic> json) {
    countryCode = json['countryCode'];
    country = json['country'];
    city = json['city'];
    postalCode = json['postalCode'];
    address = json['address'];
    lat = json['lat'];
    lng = json['lng'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['countryCode'] = countryCode;
    data['country'] = country;
    data['city'] = city;
    data['postalCode'] = postalCode;
    data['address'] = address;
    data['lat'] = lat;
    data['lng'] = lng;
    return data;
  }
}

class BankDetails {
  String? paymentMethod;
  String? bankName;
  String? accountNumber;

  BankDetails({this.paymentMethod, this.bankName, this.accountNumber});

  BankDetails.fromJson(Map<String, dynamic> json) {
    paymentMethod = json['paymentMethod'];
    bankName = json['bankName'];
    accountNumber = json['accountNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['paymentMethod'] = paymentMethod;
    data['bankName'] = bankName;
    data['accountNumber'] = accountNumber;
    return data;
  }
}

class Slots {
  Monday? monday;
  Monday? tuesday;
  Monday? wednesday;
  Monday? thursday;
  Monday? friday;
  Monday? saturday;
  Monday? sunday;

  Slots(
      {this.monday,
      this.tuesday,
      this.wednesday,
      this.thursday,
      this.friday,
      this.saturday,
      this.sunday});

  Slots.fromJson(Map<String, dynamic> json) {
    monday = json['Monday'] != null ? Monday.fromJson(json['Monday']) : null;
    tuesday = json['Tuesday'] != null ? Monday.fromJson(json['Tuesday']) : null;
    wednesday =
        json['Wednesday'] != null ? Monday.fromJson(json['Wednesday']) : null;
    thursday =
        json['Thursday'] != null ? Monday.fromJson(json['Thursday']) : null;
    friday = json['Friday'] != null ? Monday.fromJson(json['Friday']) : null;
    saturday =
        json['Saturday'] != null ? Monday.fromJson(json['Saturday']) : null;
    sunday = json['Sunday'] != null ? Monday.fromJson(json['Sunday']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (monday != null) {
      data['Monday'] = monday!.toJson();
    }
    if (tuesday != null) {
      data['Tuesday'] = tuesday!.toJson();
    }
    if (wednesday != null) {
      data['Wednesday'] = wednesday!.toJson();
    }
    if (thursday != null) {
      data['Thursday'] = thursday!.toJson();
    }
    if (friday != null) {
      data['Friday'] = friday!.toJson();
    }
    if (saturday != null) {
      data['Saturday'] = saturday!.toJson();
    }
    if (sunday != null) {
      data['Sunday'] = sunday!.toJson();
    }
    return data;
  }
}

class Monday {
  bool? active;
  List<Times>? times;

  Monday({this.active, this.times});

  Monday.fromJson(Map<String, dynamic> json) {
    active = json['active'];
    if (json['times'] != null) {
      times = <Times>[];
      json['times'].forEach((v) {
        times!.add(Times.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['active'] = active;
    if (times != null) {
      data['times'] = times!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Times {
  String? start;
  String? end;
  int? price;

  Times({this.start, this.end, this.price});

  Times.fromJson(Map<String, dynamic> json) {
    start = json['start'];
    end = json['end'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['start'] = start;
    data['end'] = end;
    data['price'] = price;
    return data;
  }
}
