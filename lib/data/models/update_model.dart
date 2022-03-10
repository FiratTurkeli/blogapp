import 'dart:convert';

AccountUpdateModel accountUpdateModelFromJson(String str) => AccountUpdateModel.fromJson(json.decode(str));

String accountUpdateModelToJson(AccountUpdateModel data) => json.encode(data.toJson());

class AccountUpdateModel {
  AccountUpdateModel({
    this.image,
    this.location,
  });

  final String? image;
  final Location? location;

  factory AccountUpdateModel.fromJson(Map<String, dynamic> json) => AccountUpdateModel(
    image: json["Image"],
    location: json["Location"] == null ? null : Location.fromJson(json["Location"]),
  );

  Map<String, dynamic> toJson() => {
    "Image": image,
    "Location": location == null ? null : location!.toJson(),
  };
}

class Location {
  Location({
    this.longtitude,
    this.latitude,
  });

  final String? longtitude;
  final String? latitude;

  factory Location.fromJson(Map<String, dynamic> json) => Location(
    longtitude: json["Longtitude"],
    latitude: json["Latitude"],
  );

  Map<String, dynamic> toJson() => {
    "Longtitude": longtitude,
    "Latitude": latitude,
  };
}