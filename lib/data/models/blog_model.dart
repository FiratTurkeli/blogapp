import 'dart:convert';

GetBlogsModel getBlogsModelFromJson(String str) =>
    GetBlogsModel.fromJson(json.decode(str));

String getBlogsModelToJson(GetBlogsModel data) => json.encode(data.toJson());

class GetBlogsModel {
  GetBlogsModel({
    this.validationErrors,
    this.hasError,
    this.message,
    this.data,
  });

  final List<dynamic>? validationErrors;
  final bool? hasError;
  final dynamic message;
  final List<Datum>? data;

  factory GetBlogsModel.fromJson(Map<String, dynamic> json) => GetBlogsModel(
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
    this.content,
    this.image,
    this.categoryId,
    this.id,
  });

  final String? title;
  final String? content;
  final String? image;
  final String? categoryId;
  final String? id;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    title: json["Title"],
    content: json["Content"],
    image: json["Image"],
    categoryId: json["CategoryId"],
    id: json["Id"],
  );

  Map<String, dynamic> toJson() => {
    "Title": title,
    "Content": content,
    "Image": image,
    "CategoryId": categoryId,
    "Id": id,
  };
}