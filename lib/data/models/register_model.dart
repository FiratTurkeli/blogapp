import 'dart:convert';

SignUpModel signUpModelFromJson(String str) =>
    SignUpModel.fromJson(json.decode(str));

String signUpModelToJson(SignUpModel data) => json.encode(data.toJson());

class SignUpModel {
  SignUpModel({
    this.validationErrors,
    this.hasError,
    this.message,
    this.data,
  });

  final List<dynamic>? validationErrors;
  final bool? hasError;
  final dynamic message;
  final Data? data;

  factory SignUpModel.fromJson(Map<String, dynamic> json) => SignUpModel(
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
    this.token,
  });

  final String? token;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    token: json["Token"],
  );

  Map<String, dynamic> toJson() => {
    "Token": token,
  };
}