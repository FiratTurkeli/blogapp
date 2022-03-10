import 'dart:convert';

UploadImageModel uploadImageModelFromJson(String str) =>
    UploadImageModel.fromJson(json.decode(str));

String uploadImageModelToJson(UploadImageModel data) =>
    json.encode(data.toJson());

class UploadImageModel {
  UploadImageModel({
    this.validationErrors,
    this.hasError,
    this.message,
    this.data,
  });

  final List<dynamic>? validationErrors;
  final bool? hasError;
  final String? message;
  final String? data;

  factory UploadImageModel.fromJson(Map<String, dynamic> json) =>
      UploadImageModel(
        validationErrors: json["ValidationErrors"] == null
            ? null
            : List<dynamic>.from(json["ValidationErrors"].map((x) => x)),
        hasError: json["HasError"],
        message: json["Message"],
        data: json["Data"],
      );

  Map<String, dynamic> toJson() => {
    "ValidationErrors": validationErrors == null
        ? null
        : List<dynamic>.from(validationErrors!.map((x) => x)),
    "HasError": hasError,
    "Message": message,
    "Data": data,
  };
}