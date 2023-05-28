// To parse this JSON data, do
//
//     final detailBusinessModel = detailBusinessModelFromJson(jsonString);

import 'dart:convert';

DetailBusinessModel detailBusinessModelFromJson(String str) =>
    DetailBusinessModel.fromJson(json.decode(str));

String detailBusinessModelToJson(DetailBusinessModel data) =>
    json.encode(data.toJson());

class DetailBusinessModel {
  String? id;
  String? alias;
  String? name;
  String? imageUrl;
  bool? isClaimed;
  bool? isClosed;
  String? url;
  String? phone;
  String? displayPhone;
  int? reviewCount;
  List<Category>? categories;
  double? rating;
  Location? location;
  Coordinates? coordinates;
  List<String>? photos;
  String? price;
  List<Hour>? hours;
  List<String>? transactions;

  DetailBusinessModel({
    this.id,
    this.alias,
    this.name,
    this.imageUrl,
    this.isClaimed,
    this.isClosed,
    this.url,
    this.phone,
    this.displayPhone,
    this.reviewCount,
    this.categories,
    this.rating,
    this.location,
    this.coordinates,
    this.photos,
    this.price,
    this.hours,
    this.transactions,
  });

  factory DetailBusinessModel.fromJson(Map<String, dynamic> json) =>
      DetailBusinessModel(
        id: json["id"],
        alias: json["alias"],
        name: json["name"],
        imageUrl: json["image_url"],
        isClaimed: json["is_claimed"],
        isClosed: json["is_closed"],
        url: json["url"],
        phone: json["phone"],
        displayPhone: json["display_phone"],
        reviewCount: json["review_count"],
        categories: json["categories"] == null
            ? []
            : List<Category>.from(
                json["categories"]!.map((x) => Category.fromJson(x))),
        rating: json["rating"]?.toDouble(),
        location: json["location"] == null
            ? null
            : Location.fromJson(json["location"]),
        coordinates: json["coordinates"] == null
            ? null
            : Coordinates.fromJson(json["coordinates"]),
        photos: json["photos"] == null
            ? []
            : List<String>.from(json["photos"]!.map((x) => x)),
        price: json["price"],
        hours: json["hours"] == null
            ? []
            : List<Hour>.from(json["hours"]!.map((x) => Hour.fromJson(x))),
        transactions: json["transactions"] == null
            ? []
            : List<String>.from(json["transactions"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "alias": alias,
        "name": name,
        "image_url": imageUrl,
        "is_claimed": isClaimed,
        "is_closed": isClosed,
        "url": url,
        "phone": phone,
        "display_phone": displayPhone,
        "review_count": reviewCount,
        "categories": categories == null
            ? []
            : List<dynamic>.from(categories!.map((x) => x.toJson())),
        "rating": rating,
        "location": location?.toJson(),
        "coordinates": coordinates?.toJson(),
        "photos":
            photos == null ? [] : List<dynamic>.from(photos!.map((x) => x)),
        "price": price,
        "hours": hours == null
            ? []
            : List<dynamic>.from(hours!.map((x) => x.toJson())),
        "transactions": transactions == null
            ? []
            : List<dynamic>.from(transactions!.map((x) => x)),
      };
}

class Category {
  String? alias;
  String? title;

  Category({
    this.alias,
    this.title,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        alias: json["alias"],
        title: json["title"],
      );

  Map<String, dynamic> toJson() => {
        "alias": alias,
        "title": title,
      };
}

class Coordinates {
  double? latitude;
  double? longitude;

  Coordinates({
    this.latitude,
    this.longitude,
  });

  factory Coordinates.fromJson(Map<String, dynamic> json) => Coordinates(
        latitude: json["latitude"]?.toDouble(),
        longitude: json["longitude"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "latitude": latitude,
        "longitude": longitude,
      };
}

class Hour {
  List<Open>? open;
  String? hoursType;
  bool? isOpenNow;

  Hour({
    this.open,
    this.hoursType,
    this.isOpenNow,
  });

  factory Hour.fromJson(Map<String, dynamic> json) => Hour(
        open: json["open"] == null
            ? []
            : List<Open>.from(json["open"]!.map((x) => Open.fromJson(x))),
        hoursType: json["hours_type"],
        isOpenNow: json["is_open_now"],
      );

  Map<String, dynamic> toJson() => {
        "open": open == null
            ? []
            : List<dynamic>.from(open!.map((x) => x.toJson())),
        "hours_type": hoursType,
        "is_open_now": isOpenNow,
      };
}

class Open {
  bool? isOvernight;
  String? start;
  String? end;
  int? day;

  Open({
    this.isOvernight,
    this.start,
    this.end,
    this.day,
  });

  factory Open.fromJson(Map<String, dynamic> json) => Open(
        isOvernight: json["is_overnight"],
        start: json["start"],
        end: json["end"],
        day: json["day"],
      );

  Map<String, dynamic> toJson() => {
        "is_overnight": isOvernight,
        "start": start,
        "end": end,
        "day": day,
      };
}

class Location {
  String? address1;
  String? address2;
  String? address3;
  String? city;
  String? zipCode;
  String? country;
  String? state;
  List<String>? displayAddress;
  String? crossStreets;

  Location({
    this.address1,
    this.address2,
    this.address3,
    this.city,
    this.zipCode,
    this.country,
    this.state,
    this.displayAddress,
    this.crossStreets,
  });

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        address1: json["address1"],
        address2: json["address2"],
        address3: json["address3"],
        city: json["city"],
        zipCode: json["zip_code"],
        country: json["country"],
        state: json["state"],
        displayAddress: json["display_address"] == null
            ? []
            : List<String>.from(json["display_address"]!.map((x) => x)),
        crossStreets: json["cross_streets"],
      );

  Map<String, dynamic> toJson() => {
        "address1": address1,
        "address2": address2,
        "address3": address3,
        "city": city,
        "zip_code": zipCode,
        "country": country,
        "state": state,
        "display_address": displayAddress == null
            ? []
            : List<dynamic>.from(displayAddress!.map((x) => x)),
        "cross_streets": crossStreets,
      };
}
