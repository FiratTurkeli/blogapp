import 'dart:convert';

AccountModel accountModelFromJson(String str) =>
    AccountModel.fromJson(json.decode(str));

String accountModelToJson(AccountModel data) => json.encode(data.toJson());

class AccountModel {
  AccountModel({
    this.validationErrors,
    this.hasError,
    this.message,
    this.data,
  });

  final List<dynamic>? validationErrors;
  final bool? hasError;
  final dynamic message;
  final Data? data;

  factory AccountModel.fromJson(Map<String, dynamic> json) => AccountModel(
    validationErrors: json["ValidationErrors"] == null
        ? null
        : List<dynamic>.from(json["ValidationErrors"].map((x) => x)),
    hasError: json["HasError"],
    message: json["Message"],
    data: json["Data"] == null ? null : Data.fromJson(json["Data"]),
  );

  Map<String, dynamic> toJson() => {
    "ValidationErrors": validationErrors == null
        ? null
        : List<dynamic>.from(validationErrors!.map((x) => x)),
    "HasError": hasError,
    "Message": message,
    "Data": data == null ? null : data!.toJson(),
  };
}

class Data {
  Data({
    this.id,
    this.email,
    this.image,
    this.location,
    required this.favoriteBlogIds,
  });

  final String? id;
  final String? email;
  final dynamic image;
  final dynamic location;
  final List<dynamic> favoriteBlogIds;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["Id"],
    email: json["Email"],
    image: json["Image"],
    location: json["Location"],
    favoriteBlogIds:
    List<dynamic>.from(json["FavoriteBlogIds"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "Id": id,
    "Email": email,
    "Image": image,
    "Location": location,
    "FavoriteBlogIds": List<dynamic>.from(favoriteBlogIds.map((x) => x)),
  };
}