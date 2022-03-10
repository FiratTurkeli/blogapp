import 'dart:convert';

GetCategoriesModel getCategoriesModelFromJson(String str) =>
    GetCategoriesModel.fromJson(json.decode(str));

String getCategoriesModelToJson(GetCategoriesModel data) =>
    json.encode(data.toJson());

class GetCategoriesModel {
  GetCategoriesModel({
    this.validationErrors,
    this.hasError,
    this.message,
    this.data,
  });

  final List<dynamic>? validationErrors;
  final bool? hasError;
  final dynamic message;
  final List<Datum>? data;

  factory GetCategoriesModel.fromJson(Map<String, dynamic> json) =>
      GetCategoriesModel(
        validationErrors: json["ValidationErrors"] == null
            ? null
            : List<dynamic>.from(json["ValidationErrors"].map((x) => x)),
        hasError: json["HasError"],
        message: json["Message"],
        data: json["Data"] == null
            ? null
            : List<Datum>.from(json["Data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
    "ValidationErrors": validationErrors == null
        ? null
        : List<dynamic>.from(validationErrors!.map((x) => x)),
    "HasError": hasError,
    "Message": message,
    "Data": data == null
        ? null
        : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Datum {
  Datum({
    this.title,
    this.image,
    this.id,
  });

  final String? title;
  final String? image;
  final String? id;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    title: json["Title"],
    image: json["Image"],
    id: json["Id"],
  );

  Map<String, dynamic> toJson() => {
    "Title": title,
    "Image": image,
    "Id": id,
  };
}