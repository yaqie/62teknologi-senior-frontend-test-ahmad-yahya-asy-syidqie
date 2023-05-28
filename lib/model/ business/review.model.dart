class ReviewBusinessModel {
  List<Reviews>? reviews;
  int? total;
  List<String>? possibleLanguages;

  ReviewBusinessModel({this.reviews, this.total, this.possibleLanguages});

  ReviewBusinessModel.fromJson(Map<String, dynamic> json) {
    if (json['reviews'] != null) {
      reviews = <Reviews>[];
      json['reviews'].forEach((v) {
        reviews!.add(Reviews.fromJson(v));
      });
    }
    total = json['total'];
    possibleLanguages = json['possible_languages'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (reviews != null) {
      data['reviews'] = reviews!.map((v) => v.toJson()).toList();
    }
    data['total'] = total;
    data['possible_languages'] = possibleLanguages;
    return data;
  }
}

class Reviews {
  String? id;
  String? url;
  String? text;
  int? rating;
  String? timeCreated;
  User? user;

  Reviews(
      {this.id, this.url, this.text, this.rating, this.timeCreated, this.user});

  Reviews.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    url = json['url'];
    text = json['text'];
    rating = json['rating'];
    timeCreated = json['time_created'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['url'] = url;
    data['text'] = text;
    data['rating'] = rating;
    data['time_created'] = timeCreated;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }
}

class User {
  String? id;
  String? profileUrl;
  String? imageUrl;
  String? name;

  User({this.id, this.profileUrl, this.imageUrl, this.name});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    profileUrl = json['profile_url'];
    imageUrl = json['image_url'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['profile_url'] = profileUrl;
    data['image_url'] = imageUrl;
    data['name'] = name;
    return data;
  }
}
