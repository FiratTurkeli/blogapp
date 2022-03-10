import 'dart:convert';

UserLoginModel userLoginModelFromJson(String str) =>
    UserLoginModel.fromJson(json.decode(str));

String userLoginModelToJson(UserLoginModel data) => json.encode(data.toJson());

class UserLoginModel {
  UserLoginModel({
    this.validationErrors,
    this.hasError,
    this.message,
    this.data,
  });

  final List<dynamic>? validationErrors;
  final bool? hasError;
  final dynamic message;
  final Data? data;

  factory UserLoginModel.fromJson(Map<String, dynamic> json) => UserLoginModel(
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
    "Data": data?.toJson(),
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